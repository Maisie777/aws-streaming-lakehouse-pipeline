# AWS Streaming Lakehouse Pipeline

This repository showcases a complete end-to-end data engineering pipeline on AWS, including real-time streaming ingestion, Data Lakehouse analytics, and interactive visualization.

## 📁 Project Structure

```plaintext
aws-streaming-lakehouse-pipeline/
│
├── terraform/                  # Terraform IaC configuration
│   ├── main.tf                 # Terraform main config
│   └── variables.tf            # Terraform variables
│
├── scripts/                    # Data ingestion and processing scripts
│   ├── data_producer.py        # Real-time data producer (Kinesis)
│   └── glue_etl_job.py         # AWS Glue ETL PySpark job script
│
├── notebooks/                  # Databricks analytics notebooks
│   └── databricks_demo.ipynb   # Databricks Lakehouse analytics example
│
├── docs/                       # Project documentation and diagrams
│   └── README.md               # Detailed project documentation
│
├── .gitignore                  # Git ignored files
└── README.md                   # Main project README
