# test_searchhandler.py
import pytest
import logging
from unittest.mock import Mock, patch
from searchhandler import SearchHandler
from backend import Backend  

import threading
import signal

def timeout_handler(signum, frame):
    print("\nCurrent thread stack:")
    for th in threading.enumerate():
        print(f"\nThread {th.name}:")
        import traceback
        traceback.print_stack(frame)
    raise TimeoutError("Test timed out")

# Setup signal handler
signal.signal(signal.SIGALRM, timeout_handler)
signal.alarm(10)  # 10 second timeout

@pytest.fixture
def search_handler():
    print("\nCreating SearchHandler instance...")
    return SearchHandler()

@patch('backend.Backend')
def test_handle_search_with_params(mock_backend):
    handler = SearchHandler()
    
    # Setup mock returns
    mock_backend.construct_query.return_value = "name:Pikachu"
    mock_backend.query_api.return_value = [Mock(name="TestCard")]
    
    result = handler.handle_search([("name", "", "Pikachu")])
    assert len(result) > 0

@patch('searchhandler.Backend')
def test_handle_search_basic(mock_backend):
    handler = SearchHandler()
    
    # Create fully mocked card with all required attributes
    mock_card = Mock()
    mock_card.name = "Pikachu"
    mock_card.id = "test123"
    mock_card.supertype = "Pokemon"
    mock_card.abilities = []
    mock_card.attacks = []
    mock_card.types = []
    mock_card.subtypes = []
    mock_card.rules = []
    mock_card.flavorText = ""
    
    # Mock nested objects
    mock_card.images = Mock()
    mock_card.images.large = "url/to/image"
    
    mock_card.set = Mock()
    mock_card.set.name = "Base Set"
    mock_card.set.images = Mock()
    mock_card.set.images.symbol = "url/to/symbol"
    mock_card.set.images.logo = "url/to/logo"
    
    mock_backend.construct_query.return_value = "name:Pikachu"
    mock_backend.query_api.return_value = [mock_card]
    
    result = handler.handle_search([("name", "", "Pikachu")])
    assert len(result) > 0
    mock_backend.construct_query.assert_called_once()
    mock_backend.query_api.assert_called_once()

@patch('searchhandler.Backend')
def test_handle_search_with_invalid_params(mock_backend):
    handler = SearchHandler()
    # Configure mock to raise TypeError when construct_query is called with None
    mock_backend.construct_query.side_effect = TypeError("'NoneType' object is not iterable")
    
    with pytest.raises(TypeError) as exc_info:
        handler.handle_search(None)
    assert "'NoneType' object is not iterable" in str(exc_info.value)

@patch.object(Backend, 'construct_query')
def test_handle_search_query_error(mock_construct, search_handler):
    mock_construct.side_effect = Exception("Query error")
    with pytest.raises(Exception) as exc_info:
        search_handler.handle_search([('invalid', '', 'param')])
    assert "Query error" in str(exc_info.value)

# @patch('searchhandler.Backend')
# def test_handle_search_query_error(mock_backend):
#     handler = SearchHandler()
#     mock_backend.construct_query.side_effect = Exception("Query error")
    
#     with pytest.raises(Exception) as exc_info:
#         handler.handle_search([('invalid', '', 'param')])
#     assert "Query error" in str(exc_info.value)

# Run with increased verbosity and debug
# python -m pytest test_searchhandler.py -vv --capture=no