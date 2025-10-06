# Order-Details-SQL-Report
SQL-based report containing order details for analysis of sales, order trends, and customer behavior.
## Dataset
- <a href = "https://github.com/bsyamini/Order-Details-SQL-Report/tree/main/data"> Dataset </a>
## SQL Queries uesd to pull the data
- <a href = "https://github.com/bsyamini/Order-Details-SQL-Report/tree/main/sql_scripts"> Queries List </a>

# Project Overview: Order Details Data Analysis

This project focuses on managing and analyzing detailed order transaction data typically found in e-commerce, retail, or inventory systems. The dataset contains order-level transaction details including:
- Unique order detail IDs (`order_details_id`)
- Associated order IDs (`order_id`)
- Order dates and times (`order_date`, `order_time`)
- Item identifiers (`item_id`)

## Core Components:
- **Order Details Table**: Stores granular information about each order line item.
- **Time-based Analysis**: Tracks order trends and volumes by date and time to identify peak order times or seasonal patterns.
- **Item-Level Insights**: Analyzes item popularity, sales quantities, and inventory movements.
- **Data Completeness**: Addresses challenges in data quality, especially regarding NULL values in `item_id` which indicate missing or untracked items.
- **Batch Data Processing**: Facilitates efficient bulk insert and update operations for large volumes of order data.

## Project Applications:
- Sales and order volume reporting by date, time, and item categories
- Operational insights for inventory restocking and order fulfillment
- Customer purchase pattern analysis through consolidated order summaries
- Time series analysis such as moving averages to smooth out fluctuations
- Data quality checks to identify and rectify missing or inconsistent data points

## Tools and Techniques:
- SQL for querying, aggregation, and data manipulation
- Bulk insert operations for efficient large data loads
- Window functions for trend and moving average calculations
- Data validation and cleaning strategies

This project provides a foundational dataset and analysis platform for businesses aiming to optimize order management and extract actionable insights into sales performance and customer demand.

## Project Requirements  
Develop a comprehensive order details data analysis project focusing on transaction-level data common in e-commerce or retail environments.

## Building the Data Warehouse (Data Engineering)  

### Objective  
Consolidate order transaction data into a well-structured table capturing detailed order lines with fields like order_details_id, order_id, order_date, order_time, and item_id for analysis and reporting.

### Specifications  
- **Data Sources**: Import order data records containing order details and item information.  
- **Data Quality**: Handle NULL values in item_id to ensure clean, reliable item-level data.  
- **Integration**: Structure data to enable linking orders to multiple items and timestamps for accurate time series analysis.  
- **Scope**: Cover transactional data spanning multiple dates to support time-based sales insights.  
- **Documentation**: Provide detailed schema and data dictionary for clarity and maintenance.

## BI: Analytics & Reporting (Data Analysis)  

### Objective  
Use SQL analytics and window functions to produce actionable insights including:  
- Time-based order trend analysis (daily, moving averages)  
- Item popularity and sales volume reporting  
- Detection and management of data anomalies such as missing item_id entries  
- Support business stakeholders in strategic inventory and sales planning  

# Project Repository Structure


 ```
 Order_Details_Analysis_Project/
│
├── Data/
│ ├── Raw_Data/
│ │ └── order_details.xlsx                # Raw dataset of order details in XLSX format
│ │
│ └── Cleaned_Data/
│ └── Order_Details_Report.xlsx            # Cleaned dataset with pivot tables and sorted data
│
├── SQL_Scripts/
│ ├── create_tables.sql                    # SQL script for creating database tables
│ ├── Data_Insertion.sql                   # SQL script for inserting data into tables
│ ├── analysis_queries.sql                 # SQL queries for data analysis and reporting, additional queries for summary or report generation
│ └── questions_used_to_pull_the_data      # Data through the queries pulled from dataset
│
├── Reports/
│ ├── order_report.ppt                     # PowerPoint presentation for order analysis report
│ └── README.md                            # Markdown file explaining project structure and instructions
│
└── README.md                              # Main documentation for the entire project including overview, setup, and usage 
 ``` 



## Explanation:

- **Data folder:** Stores all raw and cleaned datasets, with clear separation.
- **SQL_Scripts folder:** Contains all SQL-related scripts, categorized by purpose.
- **Reports folder:** Includes presentation files and documentation that summarize findings.
- The `README.md` files serve as documentation for understanding the structure, project overview, and instructions on how to set up and execute scripts.
