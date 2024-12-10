stateDiagram-v2
    [*] --> TurnOn
    TurnOn --> Waiting
    
    state Waiting {
        [*] --> Idle
        
        Idle --> PickType: Select Type Filter
        Idle --> PickSet: Select Set Filter
        Idle --> PressDiscover: Click Discover
        Idle --> ClearFilters: Press Clear
        Idle --> ToggleLeftDrawer: Press Left Ball
        Idle --> ToggleRightDrawer: Press Right Ball
        Idle --> ToggleBothDrawers: Press Center Ball
        
        PickType --> Idle
        PickSet --> Idle
        ClearFilters --> Idle
        
        PressDiscover --> ViewRandomCard
        ViewRandomCard --> ViewCardDetails: Card Displayed
        ViewCardDetails --> MarkCollection: Press Collection Button
        
        ToggleLeftDrawer --> LeftDrawerOpen
        LeftDrawerOpen --> ViewAttacks: View Attacks Info
        LeftDrawerOpen --> ViewAbilities: View Abilities Info
        LeftDrawerOpen --> ViewRules: View Rules Info
        LeftDrawerOpen --> Idle: Close Drawer
        
        ToggleRightDrawer --> RightDrawerOpen
        RightDrawerOpen --> ViewTypes: View Types Info
        RightDrawerOpen --> ViewSetInfo: View Set Info
        RightDrawerOpen --> ViewFlavorText: View Flavor Text
        RightDrawerOpen --> Idle: Close Drawer
        
        ToggleBothDrawers --> BothDrawersOpen
        BothDrawersOpen --> ViewAttacks
        BothDrawersOpen --> ViewAbilities
        BothDrawersOpen --> ViewRules
        BothDrawersOpen --> ViewTypes
        BothDrawersOpen --> ViewSetInfo
        BothDrawersOpen --> ViewFlavorText
        BothDrawersOpen --> Idle: Close Drawers
        
        MarkCollection --> Idle
        ViewRandomCard --> PressDiscover: Try Again
    }
    
    Waiting --> Off: Exit
    Off --> [*]