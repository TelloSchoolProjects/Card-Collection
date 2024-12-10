stateDiagram-v2
    [*] --> TurnOn
    TurnOn --> Waiting
    
    state Waiting {
        [*] --> Idle
        
        Idle --> AdjustColumns: Move Column Slider
        AdjustColumns --> Idle
        
        Idle --> EditCollection: Press Edit Button
        EditCollection --> CardSelection
        CardSelection --> RemoveCard: Uncheck Card
        CardSelection --> Idle: Press Edit Again
        RemoveCard --> CardSelection
        
        Idle --> CompareSelection: Press Compare Button
        CompareSelection --> LeftCompare: Press Left Compare
        CompareSelection --> RightCompare: Press Right Compare
        LeftCompare --> CompareSelection
        RightCompare --> CompareSelection
        CompareSelection --> Idle
        
        Idle --> ToggleLeftDrawer: Press Left Ball
        ToggleLeftDrawer --> LeftDrawerOpen
        LeftDrawerOpen --> ViewLeftCompare: View Left Compare Card
        ViewLeftCompare --> LeftDrawerOpen
        LeftDrawerOpen --> Idle: Close Drawer
        
        Idle --> ToggleRightDrawer: Press Right Ball
        ToggleRightDrawer --> RightDrawerOpen
        RightDrawerOpen --> ViewRightCompare: View Right Compare Card
        ViewRightCompare --> RightDrawerOpen
        RightDrawerOpen --> Idle: Close Drawer
        
        Idle --> ToggleBothDrawers: Press Center Ball
        ToggleBothDrawers --> BothDrawersOpen
        BothDrawersOpen --> ViewLeftCompare
        BothDrawersOpen --> ViewRightCompare
        ViewLeftCompare --> BothDrawersOpen
        ViewRightCompare --> BothDrawersOpen
        BothDrawersOpen --> Idle: Close Drawers
        
        Idle --> ToggleFilterDrawer: Press Bottom Ball
        ToggleFilterDrawer --> FilterDrawerOpen
        FilterDrawerOpen --> PickType: Select Type Filter
        FilterDrawerOpen --> PickSet: Select Set Filter
        FilterDrawerOpen --> ClearFilters: Press Clear
        FilterDrawerOpen --> Idle: Close Drawer
        
        PickType --> FilterDrawerOpen
        PickSet --> FilterDrawerOpen
        ClearFilters --> FilterDrawerOpen
        
        RemoveCard --> AutoSave: Collection Changed
        AutoSave --> Idle
    }
    
    Waiting --> Off: Exit
    Off --> [*]