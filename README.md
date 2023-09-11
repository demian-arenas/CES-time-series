# Employee Evolution Analysis

This project provides insights into the evolution of employment dynamics. Specifically, it answers the following questions:

- How was the evolution of women in government over time?
- How was the evolution of the ratio "production employees/supervisory employees" during time?

## Prerequisites

- Docker

## Setup

1. **Clone the Repository**

    Clone this repository to your local machine.

    ```bash
    git clone git@github.com:demian-arenas/CES-time-series.git
    cd CES-time-series/
    ```

2. **Environment Variables**

    Before starting the services, you'll need to set up your environment variables:

    - Copy the `.env.example` file to a new file named `.env`:

        ```bash
        cp .env.example .env
        ```

    - Edit the `.env` file and set your desired values for the environment variables. This file will contain configuration details like the Postgres user, password, and other related settings.

3. **Start the Services**

    Start the services using Docker Compose:

    ```bash
    docker-compose up
    ```

    Wait for the services to fully initialize. This might take a few minutes.

## Usage

Once the services are up and running, you can query the provided endpoints to get the desired insights:

### Women in Government Over Time

```bash
curl http://localhost:3000/women_in_government
```

Example output:

```json
[
    {
        "response": [
            {
                "date": "January 1964",
                "valueInThousands": 37173.4
            },
            {
                "date": "February 1964",
                "valueInThousands": 37494
            },
            ...
            {
                "date": "July 2023",
                "valueInThousands": 175971.2
            },
            {
                "date": "August 2023",
                "valueInThousands": 51480
            }
        ]
    }
]
```

### Ratio of Production Employees to Supervisory Employees

```bash
curl http://localhost:3000/production_supervisory_ratio
```

Example output:

```json
[
    {
        "response": {
            "result": [
                {
                    "date": "January 1964",
                    "valueInThousands": 37173.4
                },
                {
                    "date": "February 1964",
                    "valueInThousands": 37494
                },
                ...
                {
                    "date": "July 2023",
                    "valueInThousands": 175971.2
                },
                {
                    "date": "August 2023",
                    "valueInThousands": 51480
                }
            ]
        }
    }
]
```

## SQL Scripts Structure

Our project is backed by several SQL scripts, each serving a distinct purpose. Here's a brief overview:

- **`01_table_creation/`**: Contains scripts for creating necessary tables.
- **`02_data_ingestion/`**: Scripts related to data ingestion.
- **`03_data_cleaning/`**: Scripts for cleaning and refining the ingested data.
- **`04_view_creation/`**: Scripts for creating views that provide insights.
- **`05_postgrest.sql`**: A special script for PostgREST configurations.

## Contributing

If you have suggestions, improvements, or encounter any issues, please feel free to open an issue or a pull request.
