# E-Commerce Customer Value Intelligence

**E-Commerce Data Analysis Case Study**

## Business Problem

How can an e-commerce business better understand its sales and profitability, customer value and retention, and commercial and operational performance? This case study uses Python, MySQL, and Power BI to analyze these areas and identify opportunities for improvement.

## Project Overview

This case study analyzes e-commerce transaction, customer, product, and order data covering January 2021 to December 2025.

The analysis focuses on sales and profitability, RFM-based customer segmentation, cohort retention, discount performance, and operational measures such as returns, cancellations, ratings, and delivery performance.

## Dataset

The project uses the **E-Commerce Sales Analytics Dataset** sourced from Kaggle.

Five CSV datasets cover customer information, sales transactions, order items, product details, and dataset statistics.

Main analytical dataset: 138,116 records and 46 fields

Customers represented: 24,911

Currencies: USD, GBP, EUR, CAD, AUD, INR, and AED

Currency values were retained in their original form without exchange-rate conversion.

## Tools & Technologies

Python: Pandas, NumPy, Matplotlib

SQL: MySQL

Business Intelligence: Power BI, DAX

Environment: Google Colab

## Analytical Approach

**Data Preparation & Validation —** Reviewed data types, missing values, duplicates, key relationships, date fields, and sales and profit consistency.

**Sales & Profitability Analysis —** Analyzed sales trends, profit margins, discount levels, and product performance.

**Customer Value & Retention —** Applied RFM segmentation and cohort retention analysis to examine customer value and retention patterns.

**Commercial & Operations Analysis —** Examined discounts, marketing channels, returns, cancellations, ratings, and delivery performance.

**Power BI Reporting —** Consolidated the analysis into four dashboards for business performance, customer intelligence, commercial performance, and operations.

## Key Findings

**Discounts and profitability:** Average profit margin declined from **52.09% in the low-discount group to 25.06% in the very-high-discount group**, showing a clear association between higher discount levels and lower margins.

**Customer segmentation:** RFM analysis identified Total Customer, Champions, At Risk and Low Engagement Customers. **At Risk customes represented 17.70% of the customer base, while Low Engagement customers accounted for 26.16%.**

**Returns and cancellations:** The analysis recorded a **6.85% return rate**.

**Delivery performance:** Approximately **67% of orders were delivered on time**. Delayed orders arrived around **2.53 days late on average**.

**Commercial and customer experience indicators:** The data showed an **average discount rate of 15.1%**.

## Recommendations

**Review discount effectiveness:** Evaluate discount strategies alongside profit margins to identify where promotions support sales without unnecessarily reducing profitability.

**Prioritize customer retention:** Develop targeted re-engagement efforts for At Risk and Low Engagement customers, while monitoring repeat activity among higher-value segments.

**Investigate returns and cancellations:** Break down these rates by relevant product and order categories to identify patterns that may require further investigation.

**Improve delivery monitoring:** Track on-time delivery and delivery delays to help identify operational areas that may benefit from closer review.

**Monitor commercial and customer experience measures together:** Review discounting, ratings, returns, and product performance to identify areas requiring further analysis.

## Power BI Dashboards

The Power BI report contains four dashboards:

**Executive Overview —** Business performance and key metrics

**Customer Intelligence —** Customer value, RFM segments, and cohort retention

**Commercial Performance —** Discounting and profitability analysis

**Operations & Returns —** Returns, cancellations, ratings, and delivery performance

Screenshots of the completed dashboards are included in the repository.

## Project Workflow

Data Preparation → Data Validation → SQL Analysis → Customer & Commercial Analysis → Power BI Reporting

## Repository Structure

```text
E-Commerce-Customer-Value-Intelligence/
├── data/
│   ├── raw/
│   └── processed/
├── notebooks/
├── sql/
├── powerbi/
│   └── screenshots/
└── README.md
```

## Project Deliverables

Original Google Colab notebooks (.ipynb)

MySQL database setup, validation, and analysis scripts

Processed customer RFM and cohort retention datasets

Power BI report (.pbix)

## Conclusion

This case study combines sales, customer, commercial, and operational analysis to provide a broader view of e-commerce performance. It demonstrates how Python, SQL, and Power BI can be used to prepare and analyze data, identify business-relevant patterns, and communicate findings through stakeholder-focused reporting.
