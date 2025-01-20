SELECT *
FROM bank_loan;

SELECT COUNT(*)
FROM bank_loan;

-- Adding new column 'con_issue_date' to the table --
ALTER TABLE bank_loan
ADD COLUMN con_issue_date DATE;

-- Converting the date values in the 'issue_date' column to a valid date format and add in the values into the column 'con_issue_date'
UPDATE bank_loan
SET con_issue_date = CASE
    WHEN issue_date LIKE '__-__-____' THEN STR_TO_DATE(issue_date, '%d-%m-%Y') -- DD-MM-YYYY
    WHEN issue_date LIKE '__/__/____' THEN STR_TO_DATE(issue_date, '%d/%m/%Y') -- DD/MM/YYYY
    WHEN issue_date LIKE '____-__-__' THEN STR_TO_DATE(issue_date, '%Y-%m-%d') -- YYYY-MM-DD
    ELSE NULL
END;

SELECT *
FROM bank_loan;

-- Dropping the existing column 'issue_date'
ALTER TABLE bank_loan
DROP COLUMN issue_date;

-- Renaming the column 'con_issue_date' that will replace the dropped column 'issue_date'
ALTER TABLE bank_loan
CHANGE COLUMN con_issue_date issue_date DATE;

-- Adding new column 'con_last_credit_pull_date' to the table --
ALTER TABLE bank_loan
ADD COLUMN con_last_credit_pull_date DATE; 

-- Converting the date values in the 'last_credit_pull_date' column to a valid date format and add in the values into the column 'con_last_credit_pull_date'
UPDATE bank_loan
SET con_last_credit_pull_date = CASE
    WHEN last_credit_pull_date LIKE '__-__-____' THEN STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y') -- DD-MM-YYYY
    WHEN last_credit_pull_date LIKE '__/__/____' THEN STR_TO_DATE(last_credit_pull_date, '%d/%m/%Y') -- DD/MM/YYYY
    WHEN last_credit_pull_date LIKE '____-__-__' THEN STR_TO_DATE(last_credit_pull_date, '%Y-%m-%d') -- YYYY-MM-DD
    ELSE NULL
END;

-- Dropping the existing column 'last_credit_pull_date'
ALTER TABLE bank_loan
DROP COLUMN last_credit_pull_date;

-- Renaming the column 'con_last_credit_pull_date' that will replace the dropped column 'last_credit_pull_date'
ALTER TABLE bank_loan
CHANGE COLUMN con_last_credit_pull_date last_credit_pull_date DATE;

-- Adding new column 'con_last_payment_date' to the table --
ALTER TABLE bank_loan
ADD COLUMN con_last_payment_date DATE;

-- Converting the date values in the 'last_payment_date' column to a valid date format and add in the values into the new column 'con_last_payment_date'
UPDATE bank_loan
SET con_last_payment_date = CASE
    WHEN last_payment_date LIKE '__-__-____' THEN STR_TO_DATE(last_payment_date, '%d-%m-%Y') -- DD-MM-YYYY
    WHEN last_payment_date LIKE '__/__/____' THEN STR_TO_DATE(last_payment_date, '%d/%m/%Y') -- DD/MM/YYYY
    WHEN last_payment_date LIKE '____-__-__' THEN STR_TO_DATE(last_payment_date, '%Y-%m-%d') -- YYYY-MM-DD
    ELSE NULL
END;

-- Dropping the existing column 'last_payment_date'
ALTER TABLE bank_loan
DROP COLUMN last_payment_date;

-- Renaming the new column 'con_last_payment_date' that will replace the dropped column 'last_payment_date'
ALTER TABLE bank_loan
CHANGE COLUMN con_last_payment_date last_payment_date DATE;

-- Adding new column 'con_next_payment_date' to the table --
ALTER TABLE bank_loan
ADD COLUMN con_next_payment_date DATE;

-- Converting the date values in the 'next_payment_date' column to a valid date format and add in the values into the new column 'con_next_payment_date'
UPDATE bank_loan
SET con_next_payment_date = CASE
    WHEN next_payment_date LIKE '__-__-____' THEN STR_TO_DATE(next_payment_date, '%d-%m-%Y') -- DD-MM-YYYY
    WHEN next_payment_date LIKE '__/__/____' THEN STR_TO_DATE(next_payment_date, '%d/%m/%Y') -- DD/MM/YYYY
    WHEN next_payment_date LIKE '____-__-__' THEN STR_TO_DATE(next_payment_date, '%Y-%m-%d') -- YYYY-MM-DD
    ELSE NULL
END;

-- Dropping the existing column 'next_payment_date'
ALTER TABLE bank_loan
DROP COLUMN next_payment_date;

-- Renaming the new column 'con_next_payment_date' that will replace the dropped column 'next_payment_date'
ALTER TABLE bank_loan
CHANGE COLUMN con_next_payment_date next_payment_date DATE;

SELECT *
FROM bank_loan;

-- =============================================================================================================
-- ============================================Dashboard 1: Summary ============================================
-- =============================================================================================================

-- =========== KPI Requirements ===========

-- Calculating the total applications received 
SELECT COUNT(id) AS total_Loan_Applications
FROM bank_loan;

-- Calculating MTD Total Loan Applications
SELECT COUNT(id) AS MTD_total_Loan_Applications
FROM bank_loan 
WHERE month(issue_date) =12 AND YEAR(issue_date) = 2021;  -- 4314

-- Calculating PMTD Total Loan Applications
SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan 
WHERE month(issue_date) =11 AND YEAR(issue_date) = 2021;  -- 4035

-- Calculating the MOM Total Loan Applications change
WITH MTD_app AS (
SELECT COUNT(id) AS MTD_total_Loan_Applications
FROM bank_loan 
WHERE month(issue_date) =12 AND YEAR(issue_date) = 2021),
PMTD_app AS (
SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan 
WHERE month(issue_date) =11 AND YEAR(issue_date) = 2021)

SELECT ((MTD_app.MTD_total_Loan_Applications - PMTD_app.PMTD_Total_Loan_Applications)/ PMTD_app.PMTD_Total_Loan_Applications*100) AS MOM_Total_Loan_Applications 
FROM MTD_app, PMTD_app;

-- Calculating the Total Funded Amount -- 
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan; -- 435757075 (Total amount lent out by the bank)

-- Calculating the MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan
WHERE month(issue_date) = 12 AND YEAR(issue_date) = 2021; -- 53981425 (Total loaned out amount for the month of December)

-- Calculating the PMTD Total Funded Amount 
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM bank_loan
WHERE month(issue_date) = 11 AND YEAR(issue_date) = 2021; -- 47754825 (Total loaned out amount for the month of November)

-- Calculating the MOM Total Funded Amount change
WITH MTD_funded AS (
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan
WHERE month(issue_date) = 12 AND YEAR(issue_date) = 2021),
PMTD_funded AS (
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan
WHERE month(issue_date) = 11 AND YEAR(issue_date) = 2021)

SELECT ((MTD_funded.MTD_Total_Funded_Amount - PMTD_funded.PMTD_Total_Funded_Amount)/ PMTD_funded.PMTD_Total_Funded_Amount*100) AS MOM_Total_Funded_Amount 
FROM MTD_funded, PMTD_funded;


-- Calculating the Total Amount Received -- 
SELECT SUM(total_payment) AS Total_Amount_Received
FROM bank_loan; -- 473070933 (Total amount of repayment received)

-- Calculating the MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan
WHERE month(issue_date) = 12 AND YEAR(issue_date) = 2021; -- 58074380 (Total amount of repayment received in December)

-- Calculating the PMTD Total Amount Received 
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received 
FROM bank_loan
WHERE month(issue_date) = 11 AND YEAR(issue_date) = 2021; -- 50132030 (Total amount of repayment received in November)

-- Calculating the MOM Total Amount Received change
WITH MTD_payment AS (
SELECT SUM(total_payment) AS MTD_Total_Amount_Received
FROM bank_loan
WHERE month(issue_date) = 12 AND YEAR(issue_date) = 2021),
PMTD_payment AS (
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan
WHERE month(issue_date) = 11 AND YEAR(issue_date) = 2021)

SELECT ((MTD_payment.MTD_Total_Amount_Received - PMTD_payment.PMTD_Total_Amount_Received)/ PMTD_payment.PMTD_Total_Amount_Received*100) AS MOM_Total_Amount_Received
FROM MTD_payment, PMTD_payment;



-- Calculating the Avg Int Rate --
SELECT (AVG(int_rate)*100) as Avg_interest_rate
FROM bank_loan;

-- Calculating the MTD Avg Int Rate
SELECT (AVG(int_rate)*100) as MTD_Avg_interest_rate
FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Calculating the PMTD Avg Int Rate
SELECT (AVG(int_rate)*100) as PMTD_Avg_interest_rate
FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Calculate the MOM Avg Int Rate change
WITH MTD_avg_int AS (
SELECT (AVG(int_rate)*100) as MTD_Avg_interest_rate
FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021),
PMTD_avg_int AS (
SELECT (AVG(int_rate)*100) as PMTD_Avg_interest_rate
FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021)

SELECT ((MTD.MTD_Avg_interest_rate - PMTD.PMTD_Avg_interest_rate)/ PMTD.PMTD_Avg_interest_rate*100) AS MOM_Avg_Int_Rate
FROM MTD_avg_int MTD, PMTD_avg_int PMTD;

-- Calculating the Avg Debt To Income Ratio --
SELECT (AVG(dti)*100) as Avg_DTI
FROM bank_loan;

-- Calculating the MTD avg DTI
SELECT (AVG(dti)*100) as MTD_Avg_DTI
FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

-- Calculating the PMTD avg DTI
SELECT (AVG(dti)*100) as PMTD_Avg_DTI
FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Calculate the MOM Avg DTI change
WITH MTD_avg_dti AS (
SELECT AVG(dti) as MTD_Avg_DTI
FROM bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021),
PMTD_avg_dti AS (
SELECT AVG(dti) as PMTD_Avg_DTI
FROM bank_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021)

SELECT ((MTD.MTD_Avg_DTI - PMTD.PMTD_Avg_DTI)/ PMTD.PMTD_Avg_DTI*100) AS MOM_Avg_DTI
FROM MTD_avg_dti MTD, PMTD_avg_dti PMTD;


-- Calculating the Good Loan Application Percentage --
SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100/COUNT(id)) AS Good_Loan_Percentage
FROM bank_loan;

-- Calculating the total number of Good Loan applications
SELECT COUNT(id) as Good_Loan_Applications
FROM bank_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

-- Calculating the Good Loan Funded Amount 
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';

-- Calculating the Good Loan Total Amount Received
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan
WHERE loan_status = 'Fully Paid' or loan_status = 'Current';


-- Calculating the Bad Loans Application Percentage --
SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100 / COUNT(id)) AS Bad_Loan_Percentage
FROM bank_loan;

-- Calculating the total number of Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan
WHERE loan_status = 'Charged Off';

-- Calculating the Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan
WHERE loan_status = 'Charged Off'; 

-- Calculating the Bad Loan Total Amount Received
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan
WHERE loan_status = 'Charged Off';

-- =========== Loan Status Grid View ===========
SELECT 
	loan_status,
    COUNT(id) AS Loan_Count,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti*100) AS DTI
FROM 
	bank_loan 
GROUP BY loan_status;

-- Calculating MTD_Total_Amount_Received, MTD_Total_Funded_Amount on the basis of loan_status
SELECT 
	loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM
	bank_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status; -- Larger value for MTD_Total_Amount_Received > MTD_Total_Funded_Amount could be due to late repayments from previous month

-- ========================================================================================================================================
-- ============================================ Dashboard 2: Bank Loan Report Overview - Month ============================================
-- ========================================================================================================================================

-- Bank Loan Report Overview - Issue Date (Month)
SELECT 
	MONTH(issue_date) AS Month_Number,
    MONTHNAME(issue_date) AS Month_Name,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY Month_Number, Month_Name -- can use the alias name here because the alias involves a calculated expression that is directly derived from the orginal column name
ORDER BY Month_Number;

-- Bank Loan Report Overview - State
SELECT 
	address_state AS State, -- Alias name can be used here but not in GROUP BY clause
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY address_state 
ORDER BY address_state;

-- Bank Loan Report Overview - Term
SELECT 
	term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY term 
ORDER BY term;

-- Bank Loan Report Overview - Employment Length
SELECT 
	emp_length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY emp_length 
ORDER BY emp_length;

-- Bank Loan Report Overview - Loan Purpose
SELECT 
	purpose, 
    COUNT(id) AS Purpose_Of_Loan,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY purpose 
ORDER BY purpose;

-- Bank Loan Report Overview - Home Ownership
SELECT 
	home_ownership AS Home_Ownership, 
    COUNT(id) AS Purpose_Of_Loan,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan
GROUP BY Home_Ownership 
ORDER BY Home_Ownership;

SELECT *
FROM bank_loan;
