# Bank Loan Analysis Dashboard

<img src = "https://github.com/bayyangjie/Bank-Loan-Analysis/blob/main/images/dashboard%20image.png?raw=true" width="100%"/>

The following files are included in this repository:
* Dashboard (bank_loan_analysis__73207.twbr)
* SQL queries performed in the analysis (loan_analysis.sql)
* Dataset (bank_loan_queried.xls)

<br>

Explore the interactive dashboard on my Tableau Public profile: <br>
https://public.tableau.com/app/profile/bay.yang.jie/viz/bank_loan_analysis_17373723293010/Summary

# Background
Bank loans are a crucial financial tool that enables individuals and businesses to achieve their goals and manage financial needs. However, it's essential for borrowers to understand the terms, costs, and responsibilities associated with loans to make informed financial decisions.

Banks collect loan data through various channels and processes, including:

**Loan Applications**: When individuals or businesses apply for loans, they submit detailed applications that include personal and financial information. This data is collected electronically or in paper form.

**Credit Reports**: Banks often access credit reports from credit bureaus when assessing a borrower's creditworthiness. These reports contain information about a person's credit history, existing loans, and payment behaviour.

**Internal Records**: Banks maintain internal records of loan transactions, including disbursements, repayments, and loan status changes. These records are generated and stored in the bank's database.

**Online Portals**: Many banks offer online platforms where borrowers can apply for loans, make payments, and access account information. Data from these portals is collected and stored for analysis.

**Third-party Data Sources**: Some banks may use external data sources, such as income verification services, to gather additional information about borrowers.

# Reasons for analysing bank loan data

**Risk Assessment**: One of the primary purposes of analysing loan data is to assess the risk associated with lending to a particular individual or business. Banks use data to evaluate the creditworthiness of borrowers, predict default probabilities, and determine interest rates and lending terms.

**Decision-making**: Loan data analysis supports the decision-making process when evaluating loan applications. Banks use data-driven models and algorithms to make informed lending decisions, such as approving or denying loan requests.

**Portfolio Management**: Banks manage portfolios of loans, including mortgages, personal loans, and business loans. Data analysis helps banks monitor the health of these portfolios, identify underperforming loans, and optimize loan terms and pricing.

**Customer Insights**: Analysing loan data provides insights into customer behaviour, preferences, and needs. Banks can use these insights to tailor loan products and marketing strategies to specific customer segments.

**Profitability Analysis**: Banks assess the profitability of their loan portfolios by analysing data related to interest income, loan origination costs, default rates, and collection efforts.

**Credit Risk Management**: Banks continuously monitor and manage credit risk associated with their loans. Data analysis helps in setting risk management strategies, provisioning for potential losses, and stress testing loan portfolios.

**Customer Retention**: Banks use data analysis to identify opportunities for retaining existing customers, such as offering loan refinancing options or additional financial products.

# SQL querying

MySQL Workbench was the software used for writing the SQL queries.

The SQL queries were also performed to help verify values obtained from the aggregated calculations in Tableau. Data cleaning was also performed to ensure consistency in the format of the date values. 

There were varying formats of the date values in four date-related variables. The format of all the date values in those variables were then converted into the SQL default date format (YYYY/MM/DD).

# Dashboards

## Dashboard #1 - Summary

### Key Performance Indicators (KPIs) Requirements

1. **Total Loan Applications**: Calculates the total number of loan applications received during a specified period. Additionally, it is essential to monitor the Month-to-Date (MTD) Loan Applications and track changes Month-over-Month (MoM).

2. **Total Funded Amount**: Understanding the total amount of funds disbursed as loans is crucial. We also want to monitor the MTD Total Funded Amount and analyse the Month-over-Month (MoM) changes in this metric.

3. **Total Amount Received**: Tracking the total amount received from borrowers is essential for assessing the bank's cash flow and loan repayment. We should analyse the Month-to-Date (MTD) Total Amount Received and observe the Month-over-Month (MoM) changes.

4. **Average Interest Rate**: Calculating the average interest rate across all loans, MTD, and monitoring the Month-over-Month (MoM) variations in interest rates will provide insights into the lending portfolio's overall cost.

5. **Average Debt-to-Income Ratio (DTI)**: Evaluating the average DTI for borrowers helps to gauge overall financial health. We need to compute the average DTI for all loans, MTD, and track Month-over-Month (MoM) fluctuations.


### Good Loan v Bad Loan KPI’s

In order to evaluate the performance of all lending activities and assess the quality of the loan portfolio, we need to create a comprehensive report that distinguishes between 'Good Loans' and 'Bad Loans' based on specific loan status criteria

#### Good Loan KPIs

1. **Good Loan Application Percentage**: We need to calculate the percentage of loan applications classified as 'Good Loans.' This category includes loans with a loan status of 'Fully Paid' and 'Current.'

2. **Good Loan Applications**: Identifying the total number of loan applications falling under the 'Good Loan' category, which consists of loans with a loan status of 'Fully Paid' and 'Current'

3. **Good Loan Funded Amount**: Determining the total amount of funds disbursed as 'Good Loans.' This includes the principal amounts of loans with a loan status of 'Fully Paid' and 'Current'

4. **Good Loan Total Received Amount**: Tracking the total amount received from borrowers for 'Good Loans' , which encompasses all payments made on loans with a loan status of 'Fully Paid' and 'Current'

#### Bad Loan KPIs
  
1. **Bad Loan Application Percentage**: Calculating the percentage of loan applications categorized as 'Bad Loans' . This category specifically includes loans with a loan status of 'Charged Off'.

2. **Bad Loan Applications**: Identifying the total number of loan applications categorized as 'Bad Loans' , which consists of loans with a loan status of 'Charged Off'.

3. **Bad Loan Funded Amount**: Determining the total amount of funds disbursed as 'Bad Loans'. This comprises the principal amounts of loans with a loan status of 'Charged Off'.

4. **Bad Loan Total Received Amount**: Tracking the total amount received from borrowers/repayed for 'Bad Loans' which includes all payments made on loans with a loan status of 'Charged Off'.

### Loan Status Grid View

In order to gain a comprehensive overview of the lending operations and monitor the performance of loans, we aim to create a grid view report categorized by 'Loan Status'. This report will serve as a valuable tool for analysing and understanding the key indicators associated with different loan statuses. By providing insights into metrics such as 'Total Loan Applications', 'Total Funded Amount', 'Total Amount Received', 'Month-to-Date (MTD) Funded Amount', 'MTD Amount Received', 'Average Interest Rate' and 'Average Debt-to-Income Ratio (DTI)', this grid view helps to drive data-driven decisions and assess the overall health of the loan portfolio.

## Dashboard #2 - Overview

The aim of this dashboard is to visually represent critical loan-related metrics and trends using a variety of chart types. These charts will provide a clear and insightful view of our lending operations, facilitating data-driven decision-making and enabling us to gain valuable insights into various loan parameters.

1. Monthly Trends by Issue Date (Line Chart):
Objective: This line chart showcases how 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received' vary over time, allowing us to identify seasonality and long-term trends in lending activities.

2. Regional Analysis by State (Filled Map):
This filled map will visually represent lending metrics categorized by state, enabling us to identify regions with significant lending activity and assess regional disparities.

3. Loan Term Analysis (Donut Chart):
This donut chart depicts loan statistics based on different loan terms, allowing us to understand the distribution of loans across various term lengths.

4. Employee Length Analysis (Bar Chart):
This bar chart illustrates how lending metrics are distributed among borrowers with different employment lengths, helping us assess the impact of employment history on loan applications.

5. Loan Purpose Breakdown (Bar Chart):
This bar chart provides a visual breakdown of loan metrics based on the stated purposes of loans, aiding in the understanding of the primary reasons borrowers seek financing.

6. Home Ownership Analysis (Tree Map):
This tree map displays loan metrics categorized by different home ownership statuses providing a hierarchical view of how home ownership impacts loan applications and disbursements.

## Dashboard #3 - Details
The primary objective of the Details Dashboard is to provide a comprehensive and user-friendly interface for accessing vital loan data. It will serve as a one-stop solution for users seeking detailed insights into our loan portfolio, borrower profiles, and loan performance.
