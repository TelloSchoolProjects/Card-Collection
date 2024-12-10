# test_cardprocessor.py
import pytest
from unittest.mock import Mock
from cardprocessor import CardProcessor

@pytest.fixture
def mock_card():
    card = Mock()
    card.name = "Test Card"
    card.id = "test123"
    return card

def test_process_cards_empty_list():
    result = CardProcessor.process_cards([])
    assert result == []

def test_process_abilities_no_abilities(mock_card):
    mock_card.abilities = None
    result = CardProcessor.process_abilities(mock_card)
    assert result == {
        "ability1Name": "",
        "ability1Text": "",
        "ability1Type": "",
        "ability2Name": "",
        "ability2Text": "",
        "ability2Type": ""
    }

def test_process_abilities_with_one_ability(mock_card):
    # Create Mock ability object instead of dictionary
    ability = Mock()
    ability.name = "Test Ability"
    ability.text = "Test Text"
    ability.type = "Test Type"
    
    mock_card.abilities = [ability]
    
    result = CardProcessor.process_abilities(mock_card)
    assert result == {
        "ability1Name": "Test Ability",
        "ability1Text": "Test Text",
        "ability1Type": "Test Type",
        "ability2Name": "",
        "ability2Text": "",
        "ability2Type": ""
    }

def test_process_abilities_with_multiple_abilities(mock_card):
    ability1 = Mock()
    ability1.name = "First Ability"
    ability1.text = "First Text"
    ability1.type = "First Type"
    
    ability2 = Mock()
    ability2.name = "Second Ability"
    ability2.text = "Second Text"
    ability2.type = "Second Type"
    
    mock_card.abilities = [ability1, ability2]
    
    result = CardProcessor.process_abilities(mock_card)
    assert result == {
        "ability1Name": "First Ability",
        "ability1Text": "First Text",
        "ability1Type": "First Type",
        "ability2Name": "Second Ability",
        "ability2Text": "Second Text",
        "ability2Type": "Second Type"
    }

def test_process_abilities_with_wrong_data(mock_card):
    # Test with wrong data type
    mock_card.abilities = "not a list"
    with pytest.raises(AttributeError) as exc_info:
        CardProcessor.process_abilities(mock_card)
    assert "str" in str(exc_info.value)

def test_process_abilities_with_malformed_ability(mock_card):
    # Missing required attributes
    bad_ability = Mock(spec=[])  # Empty spec to prevent auto-creation of attributes
    mock_card.abilities = [bad_ability]
    with pytest.raises(AttributeError) as exc_info:
        CardProcessor.process_abilities(mock_card)
    assert "name" in str(exc_info.value)

def test_process_abilities_with_too_many(mock_card):
    # Create 3 abilities when code expects max 2
    abilities = []
    for i in range(3):
        ability = Mock()
        ability.name = f"Ability {i}"
        ability.text = f"Text {i}"
        ability.type = f"Type {i}"
        abilities.append(ability)
    
    mock_card.abilities = abilities
    result = CardProcessor.process_abilities(mock_card)
    # Should only process first 2 abilities
    assert len([v for v in result.values() if v != ""]) == 6

def test_process_types_no_types(mock_card):
    mock_card.types = None
    result = CardProcessor.process_types(mock_card)
    assert result == {
        "type1": "",
        "type2": ""
    }

def test_process_types_with_types(mock_card):
    mock_card.types = ["Fire", "Fighting"]
    result = CardProcessor.process_types(mock_card)
    assert result == {
        "type1": "Fire",
        "type2": "Fighting"
    }

def test_process_subtypes_no_subtypes(mock_card):
    mock_card.subtypes = None
    result = CardProcessor.process_subtypes(mock_card)
    assert result == {
        "subtype1": "",
        "subtype2": "",
        "subtype3": "",
        "subtype4": ""
    }

def test_process_subtypes_with_subtypes(mock_card):
    mock_card.subtypes = ["Basic", "Pokemon", "Stage 1"]
    result = CardProcessor.process_subtypes(mock_card)
    assert result == {
        "subtype1": "Basic",
        "subtype2": "Pokemon",
        "subtype3": "Stage 1",
        "subtype4": ""
    }

def test_process_rules_no_rules(mock_card):
    mock_card.rules = None
    result = CardProcessor.process_rules(mock_card)
    assert result == {
        "rule1": "",
        "rule2": "",
        "rule3": "",
        "rule4": ""
    }

def test_process_rules_with_rules(mock_card):
    mock_card.rules = ["Rule 1", "Rule 2"]
    result = CardProcessor.process_rules(mock_card)
    assert result == {
        "rule1": "Rule 1",
        "rule2": "Rule 2",
        "rule3": "",
        "rule4": ""
    }

@staticmethod
def process_abilities(card):
    abilities = {
        "ability1Name": "",
        "ability1Text": "",
        "ability1Type": "",
        "ability2Name": "",
        "ability2Text": "",
        "ability2Type": ""
    }

    try:
        if hasattr(card, 'abilities') and card.abilities and isinstance(card.abilities, list):
            if len(card.abilities) > 0:
                # Safely get ability1 attributes
                ability = card.abilities[0]
                abilities["ability1Name"] = getattr(ability, 'name', '')
                abilities["ability1Text"] = getattr(ability, 'text', '')
                abilities["ability1Type"] = getattr(ability, 'type', '')

            if len(card.abilities) > 1:
                # Safely get ability2 attributes
                ability = card.abilities[1]
                abilities["ability2Name"] = getattr(ability, 'name', '')
                abilities["ability2Text"] = getattr(ability, 'text', '')
                abilities["ability2Type"] = getattr(ability, 'type', '')
    except (AttributeError, TypeError, IndexError):
        # Reset abilities on any error
        abilities = {k: "" for k in abilities.keys()}

    return abilities