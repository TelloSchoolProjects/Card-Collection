import random
from collections import defaultdict
from pokemontcgsdk import Card
from backend import Backend
from cardprocessor import CardProcessor


class DiscoverHandler:
    """
    DiscoverHandler Class:
    
    Summary:
        The `DiscoverHandler` class provides methods to discover a 
            single random card based on search criteria. 
        The class uses `Backend.fetch_data` to retrieve data and 
            `CardProcessor.process_cards` for data processing.
        
    Methods:
        handle_discover:
            Returns a single card matching randomized criteria from a list of possible parameters.
            
        random_select_set:
            Randomly selects a set from the input list of sets.
            
        random_select_type:
            Randomly selects a type from the input list of types.
    """

    def handle_discover(self, param_list: list[tuple[str, str, str]], max_attempts: int = 3) -> list[dict[str, str]]:
        for attempt in range(max_attempts):
            try:
                random_select = DiscoverHandler.random_select(param_list)
                query = Backend.construct_query(self, random_select)
                results = Backend.query_api(self, query)
                if results:  # Found valid combination
                    processed_cards = CardProcessor.process_cards(results)
                    return [random.choice(processed_cards)]
            except IndexError:
                if attempt == max_attempts - 1:  # Last attempt
                    raise NoValidCombinationError(f"No valid combinations found after {max_attempts} attempts")
                continue

    @staticmethod
    def random_select(select_list: list[tuple[str, str, str]]) -> list[tuple[str, str, str]]:
        """
        Summary:
            Builds a list containing one randomly selected tuple from each unique category.
        """
        category_dict = defaultdict(list)
        for item in select_list:
            category_dict[item[0]].append(item)
        return [random.choice(items) for items in category_dict.values()]

class NoValidCombinationError(Exception):
    """Raised when no valid type-set combination can be found"""
    pass