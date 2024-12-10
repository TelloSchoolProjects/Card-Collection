# test_backend.py
import pytest
from unittest.mock import Mock, patch
from backend import Backend
from pokemontcgsdk import Card, Set

@pytest.fixture
def backend():
    return Backend()

def test_construct_query_single_param():
    backend = Backend()
    params = [('name', '', 'Pikachu')]
    query = backend.construct_query(params)
    # The field name 'name' should be included in the query
    assert query == '(name:"Pikachu")'  # This matches actual implementation

def test_construct_query_multiple_params_same_category():
    backend = Backend()
    params = [
        ('types', '', 'Fire'),
        ('types', '', 'Water')
    ]
    query = backend.construct_query(params)
    assert query == '(types:"Fire" OR types:"Water")'

def test_construct_query_multiple_categories():
    backend = Backend()
    params = [
        ('set', 'name', 'Base'),
        ('types', '', 'Fire')
    ]
    query = backend.construct_query(params)
    assert query == '(set.name:"Base") AND (types:"Fire")'

def test_construct_query_with_subcategory():
    backend = Backend()
    params = [('set', 'name', 'Base Set')]
    query = backend.construct_query(params)
    assert query == '(set.name:"Base Set")'

@patch('backend.Card')  # Change from pokemontcgsdk.Card to backend.Card
def test_query_api(mock_card):
    # Setup mock response
    mock_response = [Mock(name='Card1'), Mock(name='Card2')]
    mock_card.where.return_value = mock_response
    
    backend = Backend()
    result = backend.query_api('types:"Fire"')
    
    # Verify API was called correctly
    mock_card.where.assert_called_once_with(q='types:"Fire"')
    assert result == mock_response


@patch('backend.Set')  # Change from pokemontcgsdk.Set to backend.Set
def test_all_sets(mock_set):
    # Setup mock response
    mock_sets = [Mock(name='Set1'), Mock(name='Set2')]
    mock_set.all.return_value = mock_sets
    
    backend = Backend()
    result = backend.all_sets()
    
    # Verify API was called
    mock_set.all.assert_called_once()
    assert result == mock_sets

@patch.object(Backend, 'query_api')
@patch.object(Backend, 'construct_query')
def test_fetch_data_integration(mock_construct, mock_query):
    # Setup mocks
    mock_construct.return_value = 'test query'
    mock_cards = [Mock(name='Card1'), Mock(name='Card2')]
    mock_query.return_value = mock_cards
    
    backend = Backend()
    params = [('types', '', 'Fire')]
    result = backend.fetch_data(params)
    
    # Verify workflow
    mock_construct.assert_called_once_with(params)
    mock_query.assert_called_once_with('test query')
    assert result == mock_cards

def test_construct_query_empty_params():
    backend = Backend()
    params = []
    query = backend.construct_query(params)
    assert query == ""

def test_construct_query_complex():
    backend = Backend()
    params = [
        ('set', 'name', 'Base Set'),
        ('types', '', 'Fire'),
        ('name', '', 'Charizard'),
        ('set', 'name', 'Jungle')
    ]
    expected = '(set.name:"Base Set" OR set.name:"Jungle") AND (types:"Fire") AND (name:"Charizard")'
    query = backend.construct_query(params)
    assert query == expected