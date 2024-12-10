# test_backendcontroller.py
import pytest
from unittest.mock import Mock, patch, call
from PySide6.QtCore import QObject, QTimer, QEventLoop
from backendcontroller import BackendController
import json

def wait_for_signal(signal, timeout=1000):
    """Helper function to wait for a signal"""
    loop = QEventLoop()
    timer = QTimer()
    timer.setSingleShot(True)
    timer.timeout.connect(loop.quit)
    signal.connect(loop.quit)
    timer.start(timeout)
    loop.exec_()

@pytest.fixture
def backend_controller():
    return BackendController()

@patch('backendcontroller.inithandler.InitHandler')
def test_request_sets_retrieve(mock_init_handler, backend_controller):
    # Setup mock
    mock_set = Mock()
    mock_set.name = "Test Set"
    mock_init_handler().handle_sets_retrieve.return_value = [mock_set]
    
    # Connect to signal
    signal_received = []
    backend_controller.setsResults.connect(lambda x: signal_received.append(x))
    
    # Execute
    backend_controller.request_sets_retrieve()
    
    # Verify
    expected = json.dumps([{"name": "Test Set"}])
    assert signal_received[0] == expected

@patch('backendcontroller.searchhandler.SearchHandler')
@patch('backendcontroller.QMetaObject')
def test_request_search(mock_meta, mock_search_handler, backend_controller):
    # Setup mocks
    mock_search_handler().handle_search.return_value = [{"name": "Test Card"}]
    
    # Setup signal capture
    signal_received = []
    backend_controller.searchResults.connect(lambda x: signal_received.append(x))
    
    # Execute search request
    params = [("name", "", "Test")]
    backend_controller.request_search(params)
    
    # Manually emit result like the thread would
    backend_controller._emit_search_results(json.dumps([{"name": "Test Card"}]))
    
    # Verify
    assert len(signal_received) == 1
    assert signal_received[0] == json.dumps([{"name": "Test Card"}])
    mock_search_handler().handle_search.assert_called_once_with(params)

@patch('backendcontroller.discoverhandler.DiscoverHandler')
@patch('backendcontroller.QMetaObject')
def test_request_discover(mock_meta, mock_discover_handler, backend_controller):
    mock_discover_handler().handle_discover.return_value = [{"name": "Random Card"}]
    signal_received = []
    backend_controller.discoverResults.connect(lambda x: signal_received.append(x))
    
    params = [("types", "", "Fire")]
    backend_controller.request_discover(params)
    
    backend_controller._emit_discover_results(json.dumps([{"name": "Random Card"}]))
    
    assert len(signal_received) == 1
    assert signal_received[0] == json.dumps([{"name": "Random Card"}])
    mock_discover_handler().handle_discover.assert_called_once_with(params)

@patch('backendcontroller.collectionhandler.CollectionHandler')
@patch('backendcontroller.QMetaObject')
def test_request_load_collection(mock_meta, mock_collection_handler, backend_controller):
    # Setup mock
    mock_card = {"name": "Collected Card"}
    mock_collection_handler.return_value.handle_load_collection.return_value = [mock_card]
    
    # Setup signal capture
    signal_received = []
    backend_controller.loadResults.connect(lambda x: signal_received.append(x))
    
    # Execute load request
    backend_controller.request_load_collection()
    
    # Manually emit result like the thread would
    backend_controller._emit_load_results(json.dumps([mock_card]))
    
    # Verify
    assert len(signal_received) == 1
    assert signal_received[0] == json.dumps([mock_card])
    mock_collection_handler.return_value.handle_load_collection.assert_called_once()

@patch('backendcontroller.collectionhandler.CollectionHandler')
def test_request_save_collection(mock_collection_handler, backend_controller):
    # Connect to signal
    signal_received = []
    backend_controller.saveResults.connect(lambda x: signal_received.append(x))
    
    # Execute
    params = [("", "id", "test123")]
    backend_controller.request_save_collection(params)
    
    # Verify
    expected = json.dumps({"status": "success", "message": "Collection saved successfully."})
    assert signal_received[0] == expected
    mock_collection_handler().handle_save_collection.assert_called_once_with(params)

def test_error_handling(backend_controller):
    signals_received = {'sets': []}
    backend_controller.setsResults.connect(lambda x: signals_received['sets'].append(x))
    
    with patch('backendcontroller.inithandler.InitHandler') as mock_init:
        mock_init.side_effect = Exception("Test error")
        backend_controller.request_sets_retrieve()
        
        # Fix json.dump to json.dumps
        expected = json.dumps({"error": "Test error"})
        assert signals_received['sets'][0] == expected