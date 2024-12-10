# test_collectionhandler.py
import pytest
import json
from unittest.mock import Mock, patch, mock_open
from collectionhandler import CollectionHandler

@pytest.fixture
def collection_handler():
    return CollectionHandler("test_collection.json")

def test_init():
    handler = CollectionHandler("custom.json")
    assert handler.filename == "custom.json"
    
    default_handler = CollectionHandler()
    assert default_handler.filename == "collection_data.json"

@patch("builtins.open", new_callable=mock_open, read_data='[{"field1": "", "field2": "id", "field3": "test123"}]')
@patch('collectionhandler.Backend')
@patch('collectionhandler.CardProcessor')
def test_handle_load_collection(mock_processor, mock_backend, mock_file, collection_handler):
    # Setup mocks
    mock_card = Mock()
    mock_card.name = "Test Card"
    mock_card.id = "test123"
    
    mock_backend().construct_query.return_value = "id:test123"
    mock_backend().query_api.return_value = [mock_card]
    mock_processor().process_cards.return_value = [{"name": "Test Card", "id": "test123"}]
    
    result = collection_handler.handle_load_collection()
    
    assert len(result) == 1
    assert result[0]["id"] == "test123"
    mock_file.assert_called_once_with("test_collection.json", 'r', encoding='utf-8')

@patch("builtins.open", new_callable=mock_open)
def test_handle_save_collection(mock_file, collection_handler):
    save_data = [("", "id", "test123")]
    collection_handler.handle_save_collection(save_data)
    
    # Get all write calls
    write_calls = mock_file().write.call_args_list
    written_data = ''.join(call[0][0] for call in write_calls)
    
    # Now parse the complete written data
    saved_data = json.loads(written_data)
    assert len(saved_data) == 1
    assert saved_data[0]["field1"] == ""
    assert saved_data[0]["field2"] == "id"
    assert saved_data[0]["field3"] == "test123"

@patch("builtins.open")
def test_load_collection_file_not_found(mock_file, collection_handler):
    mock_file.side_effect = FileNotFoundError
    result = collection_handler._load_collection_from_file()
    assert result == []

@patch("builtins.open", new_callable=mock_open, read_data='invalid json')
def test_load_collection_invalid_json(mock_file, collection_handler):
    result = collection_handler._load_collection_from_file()
    assert result == []

@patch("builtins.open", new_callable=mock_open)
def test_save_collection_writes_valid_json(mock_file, collection_handler):
    save_data = [("", "id", "test123"), ("", "id", "test456")]
    collection_handler.handle_save_collection(save_data)
    
    # Get write calls and reconstruct full data
    write_calls = mock_file().write.call_args_list
    written_data = ''
    for call in write_calls:
        written_data += str(call[0][0])
    
    # Print for debugging
    print(f"Captured written data: {written_data}")
    
    # Clean the data if needed (remove any extra characters)
    written_data = written_data.strip()
    
    try:
        parsed_data = json.loads(written_data)
        assert len(parsed_data) == 2
        assert all(isinstance(item, dict) for item in parsed_data)
        assert all(all(key in item for key in ['field1', 'field2', 'field3']) for item in parsed_data)
        assert parsed_data[0]['field3'] == 'test123'
        assert parsed_data[1]['field3'] == 'test456'
    except json.JSONDecodeError as e:
        print(f"JSON decode error: {e}")
        print(f"Written data was: {repr(written_data)}")
        raise