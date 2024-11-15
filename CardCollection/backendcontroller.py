import threading
from PySide6.QtCore import QObject, Signal, QMetaObject, Slot, Qt, Q_ARG

import json

#from requests.exceptions import RequestException

import inithandler
import searchhandler
import discoverhandler
import collectionhandler


class BackendController(QObject):
    """
    Handles any front end requests for backend interaction.

    Args:
         QObject: Inheritance of QObject allows for the use of QT Signals and Slots

    ## Note:
    The `@Slot` decorator in this code is used to define a slot function that can be connected to a
    signal in a Qt application. Slots are functions or methods that can be called in response to a
    signal being emitted. By using the `@Slot` decorator, you're explicitly defining which functions
    can be connected to signals in the Qt framework. This helps in maintaining a clear separation
    between signals and slots in the codebase and ensures that the connections are set up correctly.
    """

    def __init__(self):
            super().__init__()
            print("backendController __init__ called.")


    def __del__(self):
      print("BackendController being destructed")

    setsResults = Signal(str)  # Signal that emits JSON string
    searchResults = Signal(str)  # Signal that emits JSON string
    discoverResults = Signal(str)  # Signal that emits JSON string
    loadResults = Signal(str)  # Signal that emits JSON string
    saveResults = Signal(str)

    @Slot()
    def request_sets_retrieve(self):
        """
        ## Description:
            Provide an interface for the front end to retrieve all available sets.
        Args:
            params none
        """
        try:

            initHandler = inithandler.InitHandler()

            sets = initHandler.handle_sets_retrieve()

            setList = [{"name" : set.name} for set in sets]

            self.setsResults.emit(json.dumps(setList))

        except Exception as e:
            self.setsResults.emit(json.dump({"error": str(e)}))

    @Slot(list)
    def request_search(self, params: list[tuple[str, str, str]]):
        print("DEBUG: request_search called on main thread:", threading.current_thread().name)

        # Start the search in a new thread
        query_thread = threading.Thread(target=self._perform_search, args=(params,))
        query_thread.start()
        print("DEBUG: Started query_thread:", query_thread.name)

    def _perform_search(self, params):
        print("DEBUG: _perform_search called on thread:", threading.current_thread().name)

        try:
            # Instantiate search handler and process the search
            search_handler = searchhandler.SearchHandler()
            cards = search_handler.handle_search(params)

            if cards is not None:
                json_result = json.dumps(cards)
                print("DEBUG: Cards found and serialized")
            else:
                json_result = json.dumps({"error": "No cards found"})
                print("DEBUG: No cards found")

        except Exception as e:
            json_result = json.dumps({"error": str(e)})
            print("DEBUG: Exception occurred:", e)

        # Emit the searchResults signal from the main thread
        print("DEBUG: Invoking _emit_search_results on main thread via QueuedConnection")
        QMetaObject.invokeMethod(self, "_emit_search_results",
                                 Qt.QueuedConnection,
                                 Q_ARG(str, json_result))


    @Slot(str)  # Mark as Slot so it’s recognized by invokeMethod
    def _emit_search_results(self, json_result):
        print("DEBUG: _emit_search_results called on main thread:", threading.current_thread().name)
        self.searchResults.emit(json_result)
        print("DEBUG: searchResults signal emitted to QML")

    @Slot(list)
    def request_discover(self, params: list[tuple[str, str, str]]):
        """
        ## Description
            Provide an interface for the front end
            to make discover requests with the given parameters.

        Args:
            params (list[tuple[str, str, str]]):
                List of search parameter tuples of the form (category, subcategory, target)
        """

        print("DEBUG: request_discover called on main thread:", threading.current_thread().name)

        # Start the discover in a new thread
        query_thread = threading.Thread(target=self._perform_discover, args=(params,))
        query_thread.start()
        print("DEBUG: Started query_thread:", query_thread.name)

    def _perform_discover(self, params):
        print("DEBUG: _perform_discover called on thread:", threading.current_thread().name)

        try:
            # Instantiate discover handler and process the discover
            discover_handler = discoverhandler.DiscoverHandler()
            cards = discover_handler.handle_discover(params)

            if cards is not None:
                json_result = json.dumps(cards)
                print("DEBUG: Cards found and serialized")
            else:
                json_result = json.dumps({"error": "No cards found"})
                print("DEBUG: No cards found")

        except Exception as e:
            json_result = json.dumps({"error": str(e)})
            print("DEBUG: Exception occurred:", e)

        # Emit the discoverResults signal from the main thread
        print("DEBUG: Invoking _emit_discover_results on main thread via QueuedConnection")
        QMetaObject.invokeMethod(self, "_emit_discover_results",
                                 Qt.QueuedConnection,
                                 Q_ARG(str, json_result))


    @Slot(str)  # Mark as Slot so it’s recognized by invokeMethod
    def _emit_discover_results(self, json_result):
        print("DEBUG: _emit_discover_results called on main thread:", threading.current_thread().name)
        self.discoverResults.emit(json_result)
        print("DEBUG: discoverResults signal emitted to QML")

    @Slot()
    def request_load_collection(self):
        """
        Provide an interface for the front end to request the backend to load and return the user's collection.
        """
        # Start the loading process in a new thread to keep frontend responsive
        load_thread = threading.Thread(target=self._perform_load_collection)
        load_thread.start()
        print("DEBUG: Started load_thread:", load_thread.name)

    def _perform_load_collection(self):
        print("DEBUG: _perform_load_collection called on thread:", threading.current_thread().name)

        try:
            # Load collection using CollectionHandler
            collection_handler = collectionhandler.CollectionHandler()
            collection_results = collection_handler.handle_load_collection()

            if collection_results is not None:
                json_result = json.dumps(collection_results)
                print("DEBUG: Collection loaded and serialized")
            else:
                json_result = json.dumps({"error": "No collection data found"})
                print("DEBUG: No collection data found")

        except Exception as e:
            json_result = json.dumps({"error": str(e)})
            print("DEBUG: Exception occurred during collection load:", e)

        # Emit the loadResults signal from the main thread
        print("DEBUG: Invoking _emit_load_results on main thread via QueuedConnection")
        QMetaObject.invokeMethod(self, "_emit_load_results",
                                 Qt.QueuedConnection,
                                 Q_ARG(str, json_result))

    @Slot(str)
    def _emit_load_results(self, json_result):
        print("DEBUG: _emit_load_results called on main thread:", threading.current_thread().name)
        self.loadResults.emit(json_result)
        print("DEBUG: loadResults signal emitted to QML")

    @Slot(list)
    def request_save_collection(self, params: list[tuple[str, str, str]]):
        """
        Provide an interface for the front end to save the user's collection with the provided parameters.
        """
        try:
            print("request_save_collection recieved: ")
            # Save collection using CollectionHandler
            collection_handler = collectionhandler.CollectionHandler()
            collection_handler.handle_save_collection(params)
            json_result = json.dumps({"status": "success", "message": "Collection saved successfully."})
            print("DEBUG: Collection saved successfully")

        except Exception as e:
            json_result = json.dumps({"error": str(e)})
            print("DEBUG: Exception occurred during collection save:", e)

        # Emit the saveResults signal with confirmation or error
        self.saveResults.emit(json_result)
