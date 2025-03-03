erDiagram
    COMPANY {
        int company_id PK
        string name
        string company_description
    }
    EMPLOYEE {
        int employee_id PK
        int company_id FK
        string name
        string email
        string role
        boolean is_active
    }
    POSITION {
        int position_id PK
        int company_id FK
        int interview_flow_id FK
        int position_status_id FK
        int employment_type_id FK
        string title
        text description
        boolean is_visible
        string location
        text job_description
        text requirements
        text responsibilities
        numeric salary_min
        numeric salary_max
        text benefits
        date application_deadline
        string contact_info
        datetime created_at
        datetime updated_at
    }
    POSITION_STATUS {
        int position_status_id PK
        string status_name
    }
    EMPLOYMENT_TYPE {
        int employment_type_id PK
        string type_name
    }
    INTERVIEW_FLOW {
        int interview_flow_id PK
        string description
    }
    INTERVIEW_STEP {
        int interview_step_id PK
        int interview_flow_id FK
        int interview_type_id FK
        string name
        int order_index
    }
    INTERVIEW_TYPE {
        int interview_type_id PK
        string name
        text description
    }
    CANDIDATE {
        int candidate_id PK
        string firstName
        string lastName
        string email
        string phone
        string address
        datetime created_at
        datetime updated_at
    }
    APPLICATION {
        int application_id PK
        int position_id FK
        int candidate_id FK
        int application_status_id FK
        date application_date
        text notes
        datetime created_at
        datetime updated_at
    }
    APPLICATION_STATUS {
        int application_status_id PK
        string status_name
    }
    INTERVIEW {
        int interview_id PK
        int application_id FK
        int interview_step_id FK
        int employee_id FK
        int interview_result_id FK
        date interview_date
        int score
        text notes
        datetime created_at
        datetime updated_at
    }
    INTERVIEW_RESULT {
        int interview_result_id PK
        string result_name
    }

    COMPANY ||--o{ EMPLOYEE : employs
    COMPANY ||--o{ POSITION : offers
    POSITION ||--|| INTERVIEW_FLOW : assigns
    POSITION ||--|| POSITION_STATUS : has_status
    POSITION ||--|| EMPLOYMENT_TYPE : defines_employment_type
    INTERVIEW_FLOW ||--o{ INTERVIEW_STEP : contains
    INTERVIEW_STEP ||--|| INTERVIEW_TYPE : uses
    POSITION ||--o{ APPLICATION : receives
    CANDIDATE ||--o{ APPLICATION : submits
    APPLICATION ||--o{ INTERVIEW : has
    APPLICATION ||--|| APPLICATION_STATUS : has_status
    INTERVIEW ||--|| INTERVIEW_STEP : consists_of
    INTERVIEW ||--|| INTERVIEW_RESULT : has_result
    EMPLOYEE ||--o{ INTERVIEW : conducts

    classDef primaryKey fill:#f9f,stroke:#333,stroke-width:2px;
    classDef foreignKey fill:#ccf,stroke:#333,stroke-width:1px;

    class COMPANY company_id primaryKey
    class EMPLOYEE employee_id primaryKey, company_id foreignKey
    class POSITION position_id primaryKey, company_id foreignKey, interview_flow_id foreignKey, position_status_id foreignKey, employment_type_id foreignKey
    class POSITION_STATUS position_status_id primaryKey
    class EMPLOYMENT_TYPE employment_type_id primaryKey
    class INTERVIEW_FLOW interview_flow_id primaryKey
    class INTERVIEW_STEP interview_step_id primaryKey, interview_flow_id foreignKey, interview_type_id foreignKey
    class INTERVIEW_TYPE interview_type_id primaryKey
    class CANDIDATE candidate_id primaryKey
    class APPLICATION application_id primaryKey, position_id foreignKey, candidate_id foreignKey, application_status_id foreignKey
    class APPLICATION_STATUS application_status_id primaryKey
    class INTERVIEW interview_id primaryKey, application_id foreignKey, interview_step_id foreignKey, employee_id foreignKey, interview_result_id foreignKey
    class INTERVIEW_RESULT interview_result_id primaryKey

    note for COMPANY
    Clave primaria: company_id
    Índice: name (para búsquedas por nombre de empresa)
    Fin de la nota

    note for EMPLOYEE
    Clave primaria: employee_id
    Clave foránea: company_id (índice automático)
    Índice: email (para búsqueda rápida por email), company_id, is_active (para filtrar empleados activos por empresa)
    Fin de la nota

    note for POSITION
    Clave primaria: position_id
    Claves foráneas: company_id, interview_flow_id, position_status_id, employment_type_id (índices automáticos)
    Índices: title, location, is_visible, application_deadline, position_status_id, employment_type_id, company_id (para filtros y búsquedas)
    Añadido: created_at, updated_at (para trazabilidad y auditoría)
    Fin de la nota

    note for POSITION_STATUS
    Clave primaria: position_status_id
    Índice: status_name (para búsqueda por nombre de estado)
    Tabla de lookup para los estados de la posición (Abierta, Cerrada, etc.)
    Fin de la nota

    note for EMPLOYMENT_TYPE
    Clave primaria: employment_type_id
    Índice: type_name (para búsqueda por tipo de empleo)
    Tabla de lookup para los tipos de empleo (Tiempo completo, Parcial, etc.)
    Fin de la nota

    note for INTERVIEW_FLOW
    Clave primaria: interview_flow_id
    Índice: descripción (para búsqueda por descripción del flujo)
    Fin de la nota

    note for INTERVIEW_STEP
    Clave primaria: interview_step_id
    Claves foráneas: interview_flow_id, interview_type_id (índices automáticos)
    Índice: interview_flow_id, order_index (para obtener los pasos en orden dentro de un flujo)
    Fin de la nota

    note for INTERVIEW_TYPE
    Clave primaria: interview_type_id
    Índice: name (para búsqueda por nombre del tipo de entrevista)
    Tabla de lookup para los tipos de entrevista (Técnica, RRHH, etc.)
    Fin de la nota

    note for CANDIDATE
    Clave primaria: candidate_id
    Índices: firstName, lastName, email (para búsqueda de candidatos), created_at (para ordenar por fecha de creación)
    Añadido: created_at, updated_at (para trazabilidad y auditoría)
    Fin de la nota

    note for APPLICATION
    Clave primaria: application_id
    Claves foráneas: position_id, candidate_id, application_status_id (índices automáticos)
    Índices: position_id, candidate_id, application_status_id, application_date (para filtros y búsquedas), created_at (para ordenar por fecha de creación)
    Añadido: created_at, updated_at (para trazabilidad y auditoría)
    Fin de la nota

    note for APPLICATION_STATUS
    Clave primaria: application_status_id
    Índice: status_name (para búsqueda por nombre de estado)
    Tabla de lookup para los estados de la aplicación (Pendiente, Entrevista, Rechazado, etc.)
    Fin de la nota

    note for INTERVIEW
    Clave primaria: interview_id
    Claves foráneas: application_id, interview_step_id, employee_id, interview_result_id (índices automáticos)
    Índices: application_id, interview_step_id, employee_id, interview_date (para filtros y búsquedas), created_at (para ordenar por fecha de creación)
    Añadido: created_at, updated_at (para trazabilidad y auditoría)
    Fin de la nota

    note for INTERVIEW_RESULT
    Clave primaria: interview_result_id
    Índice: result_name (para búsqueda por nombre del resultado)
    Tabla de lookup para los resultados de la entrevista (Aprobado, Rechazado, Pendiente, etc.)
    Fin de la nota