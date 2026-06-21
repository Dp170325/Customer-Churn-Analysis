/*create database db_churn;
select * from dbo.Customer_Data */

/*Step 1: Understand the Dataset*/
SELECT TOP 10 *
FROM dbo.Customer_Data;
SELECT COUNT(*) AS Total_Rows
FROM dbo.Customer_Data;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customer_Data';


/*Data Exploration – Check Distinct Values*/

SELECT Gender,
       COUNT(*) AS TotalCount,
       ROUND(
           COUNT(*) * 100.0 /
           (SELECT COUNT(*) FROM dbo.Customer_Data),
           2
       ) AS Percentage
FROM dbo.Customer_Data
GROUP BY Gender;

SELECT Gender,
       COUNT(*) AS TotalCount,
       ROUND(
           COUNT(*) * 100.0 /
           (SELECT COUNT(*) FROM dbo.Customer_Data),
           2
       ) AS Percentage
FROM dbo.Customer_Data
GROUP BY Gender;

SELECT Customer_Status,
       COUNT(*) AS TotalCount,
       SUM(Total_Revenue) AS TotalRev,
       ROUND(
           SUM(Total_Revenue) * 100.0 /
           (SELECT SUM(Total_Revenue)
            FROM dbo.Customer_Data),
           2
       ) AS RevPercentage
FROM dbo.Customer_Data
GROUP BY Customer_Status;

SELECT Customer_Status,
       COUNT(*) AS TotalCustomers
FROM dbo.Customer_Data
GROUP BY Customer_Status;

SELECT Gender,
       COUNT(*) AS TotalCustomers
FROM dbo.Customer_Data
GROUP BY Gender;

SELECT MIN(Age) AS MinAge,
       MAX(Age) AS MaxAge,
       AVG(Age) AS AvgAge
FROM dbo.Customer_Data;

SELECT COUNT(*)
FROM dbo.Customer_Data
WHERE Value_Deal IS NULL;  /* null 3548 and total rows = 6418 so,55.28% (of customers have NULL values in Value_Deal column.)*/


/* DATA CLEANING*/
/* handling null values*/


SELECT Value_Deal,
       COUNT(*) AS CountCustomers
FROM dbo.Customer_Data
GROUP BY Value_Deal;

SELECT
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM dbo.Customer_Data;


/* here we get countof nulls now make it into production table (new table) to work on it and get change in our master table*/
/* remove null and change to new table */
SELECT 
    Customer_ID,

    Gender,

    Age,

    Married,

    State,

    Number_of_Referrals,

    Tenure_in_Months,

    ISNULL(Value_Deal, 'None') AS Value_Deal,

    Phone_Service,

    ISNULL(Multiple_Lines, 'No') As Multiple_Lines,

    Internet_Service,

    ISNULL(Internet_Type, 'None') AS Internet_Type,

    ISNULL(Online_Security, 'No') AS Online_Security,

    ISNULL(Online_Backup, 'No') AS Online_Backup,

    ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,

    ISNULL(Premium_Support, 'No') AS Premium_Support,

    ISNULL(Streaming_TV, 'No') AS Streaming_TV,

    ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,

    ISNULL(Streaming_Music, 'No') AS Streaming_Music,

    ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,

    Contract,

    Paperless_Billing,

    Payment_Method,

    Monthly_Charge,

    Total_Charges,

    Total_Refunds,

    Total_Extra_Data_Charges,

    Total_Long_Distance_Charges,

    Total_Revenue,

    Customer_Status,

    ISNULL(Churn_Category, 'Others') AS Churn_Category,

    ISNULL(Churn_Reason , 'Others') AS Churn_Reason

 

INTO [db_Churn].[dbo].[prod_Churn]

FROM [db_Churn].[dbo].[Customer_Data];


/* check new table*/
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'prod_Churn';

SELECT COUNT(*) AS TotalRows
FROM dbo.prod_Churn; --6418

SELECT COUNT(*) AS TotalRows
FROM dbo.prod_Churn;

SELECT
    COUNT(*) AS Null_ValueDeal
FROM dbo.prod_Churn
WHERE Value_Deal IS NULL;

/* eda*/
SELECT Customer_Status,
       COUNT(*) AS TotalCustomers
FROM dbo.prod_Churn
GROUP BY Customer_Status
ORDER BY TotalCustomers DESC; -- analysis : stayed- 4275 churned - 1732  joined - 411


/* 
Insight 1
66.61% of customers are retained, indicating a reasonably stable customer base.

Insight 2
26.99% of customers have churned, which is a significant percentage and should be investigated further.

Insight 3
Only 6.40% are newly joined customers, suggesting customer acquisition may not be growing fast enough to offset churn.*/

/*Why are customers leaving?*/
SELECT
    Churn_Category,
    COUNT(*) AS TotalCustomers
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned'
GROUP BY Churn_Category
ORDER BY TotalCustomers DESC;

/*Insight 1
Competitor is the biggest churn reason, responsible for nearly 44% of all churned customers.

Insight 2
Customer experience issues (Attitude + Dissatisfaction) account for: 301 + 300 = 601 customers
which is about 34.7% of all churn.*/

/*loss revenue*/
SELECT
    SUM(Total_Revenue) AS RevenueLost
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned';--Revenue Lost = 3,411,960.58


SELECT
    Customer_Status,
    SUM(Total_Revenue) AS Revenue
FROM dbo.prod_Churn
GROUP BY Customer_Status;       --Joined- 49,281.56   ,Churned - 3,411,960.58  Stayed-16,010,148.26 

/*  Customer Status Distribution */
SELECT
    Customer_Status,
    COUNT(*) AS TotalCustomers
FROM dbo.prod_Churn
GROUP BY Customer_Status
ORDER BY TotalCustomers DESC;


/* Revenue by Customer Status */
SELECT
    Customer_Status,
    SUM(Total_Revenue) AS Revenue
FROM dbo.prod_Churn
GROUP BY Customer_Status;


/* Churn Category Analysis */
SELECT
    Churn_Category,
    COUNT(*) AS TotalCustomers
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned'
GROUP BY Churn_Category
ORDER BY TotalCustomers DESC;


/* Churn by Contract Type */
SELECT
    Contract,
    Customer_Status,
    COUNT(*) AS TotalCustomers
FROM dbo.prod_Churn
GROUP BY Contract, Customer_Status
ORDER BY Contract;


/*  Churn by Payment Method */
SELECT
    Payment_Method,
    COUNT(*) AS ChurnedCustomers
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned'
GROUP BY Payment_Method
ORDER BY ChurnedCustomers DESC;


/*  Churn by Internet Type */
SELECT
    Internet_Type,
    COUNT(*) AS ChurnedCustomers
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned'
GROUP BY Internet_Type
ORDER BY ChurnedCustomers DESC;


/* Churn by Age Group */
SELECT
    CASE
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 50 THEN 'Middle Age'
        ELSE 'Senior'
    END AS Age_Group,
    COUNT(*) AS ChurnedCustomers
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned'
GROUP BY
    CASE
        WHEN Age < 30 THEN 'Young'
        WHEN Age BETWEEN 30 AND 50 THEN 'Middle Age'
        ELSE 'Senior'
    END;


/*  Top Churn Reasons */
SELECT
    Churn_Reason,
    COUNT(*) AS TotalCustomers
FROM dbo.prod_Churn
WHERE Customer_Status = 'Churned'
GROUP BY Churn_Reason
ORDER BY TotalCustomers DESC;


/*  Revenue Ranking (Window Function) */
SELECT
    Customer_ID,
    Total_Revenue,
    RANK() OVER (ORDER BY Total_Revenue DESC) AS RevenueRank
FROM dbo.prod_Churn;


DROP VIEW vw_ChurnedCustomers;
GO

CREATE VIEW vw_ChurnedCustomers AS
SELECT *
FROM dbo.prod_Churn
WHERE Customer_Status IN ('Churned','Stayed');
GO

SELECT *
FROM INFORMATION_SCHEMA.VIEWS; -- check done

                                                /*  eda done*/
                                                      /* thank you*/

select @@SERVERNAME;  
SELECT *
FROM dbo.prod_Churn;