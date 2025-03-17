# Data Architecture Nanodegree Projects

This repository contains projects developed during the Data Architecture Nanodegree program, focusing on database design, data warehousing, and ETL processes.

## Projects Overview

### 1. HR Database Design Project
Located in: `01-Designing-and-HR-database/`

A comprehensive Human Resources database implementation project including:
- Database schema design and DDL scripts
- Data loading and ETL processes
- SQL analysis queries
- Database requirements documentation
- Docker configuration for local development

**Key Files:**
- `database-requirement-document.pptx`: Project requirements and design documentation
- `1.human_resources_ddl_version_1_0_0.sql`: Database schema creation
- `2.human_resource_dml_load_stage_table_version_1_0_0.sql`: Data loading scripts
- `3.human_resource_dml_etl_stage_version_1_0_0.sql`: ETL transformation scripts
- `4.human_resources_sql_questions_version_1_0_0.sql`: Analysis queries
- `docker-compose.yaml`: Docker configuration for local development

### 2. Data Warehouse Project (Snowflake)
Located in: `02-Data-Warehouse-Snowflake-Project/`

A data warehouse implementation project using Snowflake, following a three-layer architecture:
- Staging layer for raw data ingestion
- ODS (Operational Data Store) for data standardization
- Data Warehouse layer for analytical processing

**Project Structure:**
- `Staging/`: Staging layer implementation
- `ODS/`: Operational Data Store layer
- `DatawareHouse/`: Data Warehouse layer implementation
- `data_warehouse_snowflake.drawio`: Data warehouse architecture diagram
- `dw_yelp_project.zip`: Project resources and documentation

## Setup Instructions

### Prerequisites
- Docker Desktop
- PostgreSQL client (psql)
- Snowflake account
- Git

### HR Database Project Setup

1. Clone the repository:
```bash
git clone https://github.com/fapereira1/data-architecture-nanodegree.git
cd data-architecture-nanodegree/01-Designing-and-HR-database
```

2. Start the PostgreSQL container:
```bash
docker-compose up -d
```

3. Connect to the database:
```bash
psql -h localhost -p 5432 -U postgres
# Password: UdacityDataArch2021!
```

4. Execute the SQL scripts in order:
```sql
\i 1.human_resources_ddl_version_1_0_0.sql
\i 2.human_resource_dml_load_stage_table_version_1_0_0.sql
\i 3.human_resource_dml_etl_stage_version_1_0_0.sql
```

5. Run analysis queries:
```sql
\i 4.human_resources_sql_questions_version_1_0_0.sql
```

### Data Warehouse Project Setup

1. Navigate to the project directory:
```bash
cd ../02-Data-Warehouse-Snowflake-Project
```

2. Set up your Snowflake environment:
   - Log in to your Snowflake account
   - Create a new warehouse if needed
   - Set up the three-layer architecture:
     - Create Staging database
     - Create ODS database
     - Create Data Warehouse database

3. Extract the project resources:
```bash
unzip dw_yelp_project.zip
```

4. Follow the layer-specific setup instructions in:
   - `Staging/` directory
   - `ODS/` directory
   - `DatawareHouse/` directory

## Technologies Used

- PostgreSQL
- Snowflake
- Docker
- SQL
- Data Modeling Tools

## License

This project is created for educational purposes as part of the Data Architecture Nanodegree program.
