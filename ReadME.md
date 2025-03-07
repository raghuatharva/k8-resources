flowchart TD
    Start([Storage Provisioning in Kubernetes]) --> Decision{Choose Provisioning Type}
    Decision -->|Static| StaticPath
    Decision -->|Dynamic| DynamicPath
    
    %% Static Provisioning Flow
    subgraph StaticPath[Static Provisioning]
        S1[Admin creates storage on backend] --> S2[Admin manually creates PV]
        S2 --> S3[User creates PVC]
        S3 --> S4{PVC matches existing PV?}
        S4 -->|Yes| S5[K8s binds PVC to PV]
        S4 -->|No| S3
        S5 --> S7[Pod references PVC]
        S7 --> S8[Pod uses storage]
        S8 --> S9[Apply reclaim policy when done]
    end
    
    %% Dynamic Provisioning Flow
    subgraph DynamicPath[Dynamic Provisioning]
        D1[Admin creates StorageClass] --> D2[User creates PVC with StorageClass]
        D2 --> D3[Provisioner automatically creates PV]
        D3 --> D4[K8s binds PVC to PV]
        D4 --> D5[Pod references PVC]
        D5 --> D6[Pod uses storage]
        D6 --> D7[Apply reclaim policy from StorageClass when done]
    end
    
    %% Cross connections
    S2 -.->|"Manual vs"| D1
    S3 -.->|"Same concept"| D2
    S5 -.->|"Same process"| D4
    S7 -.->|"Same usage"| D5
    S9 -.->|"Policies defined differently"| D7
    
    %% Decision factors connections
    Decision -.->|"Influences choice"| Factors
    
    %% Decision Factors
    Factors[Decision Factors]
    Factors --> F1[Team: IT-centered vs DevOps]
    Factors --> F2[Environment: On-prem vs Cloud]
    Factors --> F3[Workload: Predictable vs Variable]
    
    %% Style
    classDef default fill:#f5f5f5,stroke:#333,stroke-width:1px
    classDef static fill:#e6f7ff,stroke:#1890ff,stroke-width:1px
    classDef dynamic fill:#f6ffed,stroke:#52c41a,stroke-width:1px
    classDef decision fill:#fff2e8,stroke:#fa8c16,stroke-width:1px,shape:diamond
    
    class Start,Factors,F1,F2,F3 default
    class StaticPath,S1,S2,S3,S4,S5,S7,S8,S9 static
    class DynamicPath,D1,D2,D3,D4,D5,D6,D7 dynamic
    class Decision decision
