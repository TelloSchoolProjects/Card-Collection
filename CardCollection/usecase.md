graph LR
    user((User))

    subgraph System["Pokemon Card Collection System"]
        subgraph Search["Search Management"]
            UC1["Search Cards"]
            UC2["Filter by Set"]
            UC3["Filter by Type"]
            UC4["Filter by Name"] 
            UC5["View Card Details"]
            UC6["Add to Collection"]
        end

        subgraph Discovery["Discovery Management"]
            UC7["Discover Random Card"]
            UC8["Apply Set Filters"]
            UC9["Apply Type Filters"]
            UC10["View Card Details"]
            UC11["Add to Collection"]
        end

        subgraph Collection["Collection Management"]
            UC12["View Collection"]
            UC13["Save Collection"]
            UC14["Load Collection"]
            UC15["Compare Cards"]
            UC16["Remove from Collection"]
            UC17["View Card Details"]
            UC18["Process Collection Data"]
        end
    end

    %% Primary flows
    user --> UC1
    user --> UC7
    user --> UC12

    %% Search relationships - all optional
    UC1 --> |extends| UC2
    UC1 --> |extends| UC3
    UC1 --> |extends| UC4
    UC1 --> |extends| UC5
    UC1 --> |extends| UC6

    %% Discover relationships - all optional
    UC7 --> |extends| UC8
    UC7 --> |extends| UC9
    UC7 --> |extends| UC10
    UC7 --> |extends| UC11

    %% Collection relationships
    UC12 --> |extends| UC13
    UC12 --> |extends| UC14
    UC12 --> |extends| UC15
    UC12 --> |extends| UC16
    UC12 --> |extends| UC17
    UC12 --> |extends| UC18

    %% Cross-component relationships 
    UC6 --> |extends| UC12
    UC11 --> |extends| UC12