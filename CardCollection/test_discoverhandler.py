# test_discoverhandler.py
import pytest
from unittest.mock import Mock, patch
from discoverhandler import DiscoverHandler, NoValidCombinationError

@pytest.fixture
def discover_handler():
    return DiscoverHandler()

@patch('discoverhandler.Backend')
@patch('discoverhandler.CardProcessor')
def test_handle_discover_basic(mock_processor, mock_backend, discover_handler):
    # Setup mock card
    mock_card = Mock()
    mock_card.name = "Test Card"
    mock_card.id = "test123"
    
    mock_backend.construct_query.return_value = "types:Fire"
    mock_backend.query_api.return_value = [mock_card]
    mock_processor.process_cards.return_value = [{"name": "Test Card", "id": "test123"}]
    
    params = [("types", "", "Fire")]
    result = discover_handler.handle_discover(params)
    
    assert len(result) == 1
    assert result[0]["name"] == "Test Card"

def test_random_select_single_category():
    params = [
        ("types", "", "Fire"),
        ("types", "", "Water"),
        ("types", "", "Grass")
    ]
    result = DiscoverHandler.random_select(params)
    
    assert len(result) == 1
    assert result[0][0] == "types"
    assert result[0][2] in ["Fire", "Water", "Grass"]

def test_random_select_multiple_categories():
    params = [
        ("types", "", "Fire"),
        ("types", "", "Water"),
        ("set", "name", "Base"),
        ("set", "name", "Jungle")
    ]
    result = DiscoverHandler.random_select(params)
    
    assert len(result) == 2  # One from each category
    categories = {item[0] for item in result}
    assert categories == {"types", "set"}

@patch('discoverhandler.Backend')
@patch('discoverhandler.CardProcessor')
@patch('random.choice')  # Add this to control random.choice behavior
def test_handle_discover_no_results(mock_choice, mock_processor, mock_backend, discover_handler):
    # Setup mocks
    mock_backend.query_api.return_value = []
    mock_processor.process_cards.return_value = []
    mock_choice.side_effect = IndexError  # Force IndexError on random.choice
    
    with pytest.raises(NoValidCombinationError):
        discover_handler.handle_discover([("types", "", "Fire")], max_attempts=1)

@patch('discoverhandler.Backend')
@patch('discoverhandler.CardProcessor')
@patch('random.choice')
def test_handle_discover_incompatible_type_set(mock_choice, mock_processor, mock_backend, discover_handler):
    # Setup mocks
    mock_backend.query_api.return_value = []
    mock_processor.process_cards.return_value = []
    mock_choice.side_effect = IndexError
    
    params = [
        ("types", "", "Fairy"),
        ("set", "name", "Base")
    ]
    
    with pytest.raises(NoValidCombinationError):
        discover_handler.handle_discover(params, max_attempts=1)

@patch('discoverhandler.Backend')
@patch('discoverhandler.CardProcessor')
def test_handle_discover_incompatible_type_set_with_alternatives(mock_processor, mock_backend, discover_handler):
    # Mock failed first attempt, successful second attempt
    mock_backend.query_api.side_effect = [[], [Mock(name="Test Card")]]
    mock_processor.process_cards.return_value = [{"name": "Test Card"}]
    
    params = [
        ("types", "", "Fairy"),
        ("types", "", "Fire"),  # Alternative type
        ("set", "name", "Base"),
        ("set", "name", "Neo")  # Alternative set
    ]
    
    result = discover_handler.handle_discover(params)
    assert len(result) == 1
    assert mock_backend.query_api.call_count == 2

# Uncomment the following patch after implementing the Discover patch

@patch('discoverhandler.Backend')
@patch('discoverhandler.CardProcessor')
@patch('random.choice')
def test_handle_discover_no_valid_combinations(mock_choice, mock_processor, mock_backend, discover_handler):
    # Setup mocks
    mock_backend.query_api.return_value = []
    mock_processor.process_cards.return_value = []
    mock_choice.side_effect = IndexError
    
    params = [
        ("types", "", "Fairy"),
        ("set", "name", "Base")
    ]
    
    with pytest.raises(NoValidCombinationError):
        discover_handler.handle_discover(params, max_attempts=1)

    assert mock_backend.query_api.called