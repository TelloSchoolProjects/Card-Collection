# test_inithandler.py
import pytest
from unittest.mock import Mock, patch
from inithandler import InitHandler

@pytest.fixture
def init_handler():
    return InitHandler()

@patch('backend.Backend')
def test_handle_sets_retrieve_success(mock_backend):
    # Setup
    handler = InitHandler()
    mock_set1 = Mock(name="Set1")
    mock_set2 = Mock(name="Set2")
    mock_backend.all_sets.return_value = [mock_set1, mock_set2]
    
    # Execute
    result = handler.handle_sets_retrieve()
    
    # Verify
    assert len(result) == 2
    mock_backend.all_sets.assert_called_once()

@patch('backend.Backend')
def test_handle_sets_retrieve_empty(mock_backend):
    handler = InitHandler()
    mock_backend.all_sets.return_value = []
    
    result = handler.handle_sets_retrieve()
    assert result == []
    mock_backend.all_sets.assert_called_once()

@patch('backend.Backend')
def test_handle_sets_retrieve_error(mock_backend):
    handler = InitHandler()
    mock_backend.all_sets.side_effect = Exception("API Error")
    
    with pytest.raises(Exception) as exc_info:
        handler.handle_sets_retrieve()
    assert "API Error" in str(exc_info.value)