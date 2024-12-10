stateDiagram-v2
    [*] --> TurnOn
    TurnOn --> Waiting
    
    state Waiting {
        [*] --> Idle
        
        Idle --> PickType: Select Type Filter
        Idle --> PickSet: Select Set Filter
        Idle --> EnterName: Type Name
        Idle --> PressSearch: Click Search
        Idle --> ClearFilters: Press Clear
        Idle --> NavigateResults: Press Next/Prev/First/Last
        Idle --> ToggleDrawer: Press Ball
        
        PickType --> Idle
        PickSet --> Idle
        EnterName --> Idle
        ClearFilters --> Idle
        
        PressSearch --> ViewResults
        ViewResults --> ViewCardDetails: Card Displayed
        ViewCardDetails --> MarkCollection: Press Collection Button
        ViewResults --> Idle: Back
        
        NavigateResults --> ViewResults
        
        ToggleDrawer --> DrawerOpen
        DrawerOpen --> ViewCardDetails
        DrawerOpen --> Idle: Close Drawer
        
        MarkCollection --> Idle
    }
    
    Waiting --> Off: Exit
    Off --> [*]