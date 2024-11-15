import json
from backend import Backend
from cardprocessor import CardProcessor

class CollectionHandler:
    def __init__(self, filename: str = "collection_data.json"):
        self.filename = filename

    def handle_load_collection(self) -> list[dict[str, str]]:
        """Load collection, build a query, call API, process results, and return processed data."""
        # Step 1: Load data from the file
        loaded_params = self._load_collection_from_file()

        # Step 2: Construct the query using backend
        query = Backend().construct_query(loaded_params)

        # Step 3: Query the API with constructed query
        cards = Backend().query_api(query)

        # Step 4: Process cards data
        processed_data = CardProcessor().process_cards(cards)

        # Step 5: Return the processed data
        return processed_data

    def handle_save_collection(self, save_params: list[tuple[str, str, str]]):
        """Save collection data to a JSON file."""
        self._save_collection_to_file(save_params)

    def _load_collection_from_file(self) -> list[tuple[str, str, str]]:
        """Helper function to load the collection from a JSON file."""
        try:
            with open(self.filename, 'r', encoding='utf-8') as file:
                data = json.load(file)
                return [(d['field1'], d['field2'], d['field3']) for d in data]
        except (FileNotFoundError, json.JSONDecodeError):
            return []

    def _save_collection_to_file(self, save_params: list[tuple[str, str, str]]):
        """Helper function to save the collection data to a JSON file."""
        data_to_save = [{"field1": t[0], "field2": t[1], "field3": t[2]} for t in save_params]

        plain_string = json.dumps(data_to_save, separators=(',', ':'))

        print(plain_string)
        # Debug print to inspect the data being saved
        print("Saving data to file:", data_to_save)

        with open(self.filename, 'w', encoding='utf-8') as file:
            json.dump(data_to_save, file, ensure_ascii=False, indent=4)
