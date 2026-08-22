-- Databricks notebook source
-------------checking the dataset
SELECT * 
FROM `banktransaction`.`frauddetection`.`loan_default`
LIMIT 10;

-----CHECKING FOR NULL
SELECT * 
FROM `banktransaction`.`frauddetection`.`loan_default`
WHERE person_age IS NULL
OR person_gender IS NULL
OR person_education IS NULL
OR person_income IS NULL
OR person_emp_exp IS NULL
OR person_home_ownership IS NULL
OR loan_amnt IS NULL
OR loan_intent IS NULL
OR loan_int_rate IS NULL
OR loan_percent_income IS NULL
OR cb_person_cred_hist_length IS NULL
OR credit_score IS NULL
OR previous_loan_defaults_on_file IS NULL
OR loan_status IS NULL;
---------CHecking for dulipacate in my data
SELECT *,
COUNT(*) AS duplicate_count
FROM  `banktransaction`.`frauddetection`.`loan_default`
GROUP BY person_age, person_gender, person_education, person_income, person_emp_exp, person_home_ownership, loan_amnt, loan_intent, loan_int_rate, loan_percent_income, cb_person_cred_hist_length, credit_score, previous_loan_defaults_on_file, loan_status
HAVING COUNT(*) > 1;
----------------Classifiying person age
SELECT person_age,
CASE
WHEN person_age BETWEEN 18 AND 21 THEN 'Youth'
WHEN person_age BETWEEN 22 AND 35 THEN 'Young Adult'
WHEN person_age BETWEEN 36 AND 50 THEN 'Adult'
WHEN person_age BETWEEN 51 AND 60 THEN 'Elder'
WHEN person_age > 60 THEN 'Pensioner'
END AS `Age bracket`
FROM `banktransaction`.`frauddetection`.`loan_default`;
------Checking Distinct gender
SELECT DISTINCT person_gender
FROM `banktransaction`.`frauddetection`.`loan_default`;
-------------checking distinct person_education
SELECT DISTINCT person_education
FROM `banktransaction`.`frauddetection`.`loan_default`;
------------------Checking person_income
SELECT MIN(person_income) AS `Min income`,
MAX(person_income) AS `Max income`,
AVG(person_income) AS `Avg income`
FROM `banktransaction`.`frauddetection`.`loan_default`;
SELECT
person_income,
CASE
WHEN person_income < 30000 THEN 'Low Income'
WHEN person_income BETWEEN 30000 AND 60000 THEN 'Lower-Middle Income'
WHEN person_income BETWEEN 60001 AND 100000 THEN 'Middle Income'
WHEN person_income BETWEEN 100001 AND 200000 THEN 'Upper-Middle Income'
ELSE 'High Income'
END AS income_bracket
FROM `banktransaction`.`frauddetection`.`loan_default`;
----------------------Checking  person_emp_exp
SELECT DISTINCT  person_emp_exp
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT MIN(person_emp_exp),
MAX(person_emp_exp)
FROM `banktransaction`.`frauddetection`.`loan_default`;
--------Comparing age vs emp exp
SELECT person_age,
person_emp_exp
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT  person_emp_exp,
CASE 
WHEN person_emp_exp BETWEEN 0 AND 1 THEN 'Entry'
WHEN person_emp_exp BETWEEN 2 AND 4 THEN 'Junior'
WHEN person_emp_exp BETWEEN 5 AND 9 THEN 'Experinced'
ELSE 'Veteran'
END AS `Exp Bracket`
FROM `banktransaction`.`frauddetection`.`loan_default`;
-------------Checking person_home_ownership
SELECT DISTINCT person_home_ownership
FROM `banktransaction`.`frauddetection`.`loan_default`;
---------------------CHECKING loan_amnt
SELECT MIN(loan_amnt),
MAX(loan_amnt)
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT loan_amnt,
CASE
WHEN loan_amnt <=5000 THEN 'Micro'
WHEN loan_amnt <=10000 THEN 'Small'
WHEN loan_amnt <=20000 THEN 'Medium'
ELSE 'Large'
END AS Loan_bracket
FROM `banktransaction`.`frauddetection`.`loan_default`;

-----------------CHECKING loan_intent
SELECT DISTINCT loan_intent
FROM `banktransaction`.`frauddetection`.`loan_default`;
----------------------CHECKING loan_int_rate
SELECT MIN(loan_int_rate),
MAX(loan_int_rate)
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT loan_int_rate,
CASE
WHEN loan_int_rate < 10 THEN 'Low Rate'
WHEN loan_int_rate < 15 THEN 'Medium Rate'
ELSE 'High Rate'
END AS Rate_Bracket
FROM `banktransaction`.`frauddetection`.`loan_default`;
--------------------CHECKING loan_percent_income
SELECT MIN(loan_percent_income) AS `MIN loan_percent_income`,
MAX(loan_percent_income) AS `MAX loan_percent_income`
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT loan_percent_income,
CASE
WHEN loan_percent_income <=0.20 THEN 'Afforadable'
WHEN loan_percent_income <=0.40 THEN 'Moderate'
ELSE 'Over Indebted'
END AS Afforadability
FROM `banktransaction`.`frauddetection`.`loan_default`;

------------------------------checking cb_person_cred_hist_length
SELECT MIN(cb_person_cred_hist_length) AS `MIN cb_person_cred_hist_length`,
MAX(cb_person_cred_hist_length) AS `MAX cb_person_cred_hist_length`
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT cb_person_cred_hist_length,
CASE 
WHEN cb_person_cred_hist_length<=5 THEN 'New'
WHEN cb_person_cred_hist_length<=15 THEN 'Exprinced'
ELSE 'Very Exprinced'
END AS `Credir HIistory Bucket`
FROM `banktransaction`.`frauddetection`.`loan_default`;

-------------------------------Checking credit_score
SELECT MIN(credit_score) AS `MIN credit_score`,
MAX(credit_score) AS `MAX credit_score`
FROM `banktransaction`.`frauddetection`.`loan_default`;

SELECT credit_score,
CASE 
WHEN credit_score<580 THEN 'Poor'
WHEN credit_score<670 THEN 'Fair'
WHEN credit_score<740 THEN 'Good'
ELSE 'Exceptional'
END AS Credit_Score_Bucket
FROM `banktransaction`.`frauddetection`.`loan_default`;
--------------------checking previous_loan_defaults_on_file
SELECT DISTINCT previous_loan_defaults_on_file
FROM `banktransaction`.`frauddetection`.`loan_default`;
------------------------------CHECKING loan_status
SELECT DISTINCT loan_status
FROM `banktransaction`.`frauddetection`.`loan_default`;
-----------------------creating a temp table
CREATE OR REPLACE TEMP VIEW loan_default AS
SELECT
person_age,
CASE
WHEN person_age BETWEEN 18 AND 21 THEN 'Youth'
WHEN person_age BETWEEN 22 AND 35 THEN 'Young Adult'
WHEN person_age BETWEEN 36 AND 50 THEN 'Adult'
WHEN person_age BETWEEN 51 AND 60 THEN 'Elder'
WHEN person_age > 60 THEN 'Pensioner'
END AS `Age bracket`,
person_gender,
person_education,
person_income,
CASE
WHEN person_income < 30000 THEN 'Low Income'
WHEN person_income BETWEEN 30000 AND 60000 THEN 'Lower-Middle Income'
WHEN person_income BETWEEN 60001 AND 100000 THEN 'Middle Income'
WHEN person_income BETWEEN 100001 AND 200000 THEN 'Upper-Middle Income'
ELSE 'High Income'
END AS income_bracket,
person_emp_exp,
CASE 
WHEN person_emp_exp BETWEEN 0 AND 1 THEN 'Entry'
WHEN person_emp_exp BETWEEN 2 AND 4 THEN 'Junior'
WHEN person_emp_exp BETWEEN 5 AND 9 THEN 'Experinced'
ELSE 'Veteran'
END AS `Exp Bracket`,
person_home_ownership,
loan_amnt,
CASE
WHEN loan_amnt <=5000 THEN 'Micro'
WHEN loan_amnt <=10000 THEN 'Small'
WHEN loan_amnt <=20000 THEN 'Medium'
ELSE 'Large'
END AS Loan_bracket,
loan_intent,
loan_int_rate,
CASE
WHEN loan_int_rate < 10 THEN 'Low Rate'
WHEN loan_int_rate < 15 THEN 'Medium Rate'
ELSE 'High Rate'
END AS Rate_Bracket,
loan_percent_income,
CASE
WHEN loan_percent_income <=0.20 THEN 'Afforadable'
WHEN loan_percent_income <=0.40 THEN 'Moderate'
ELSE 'Over Indebted'
END AS Afforadability,
cb_person_cred_hist_length,
CASE 
WHEN cb_person_cred_hist_length<=5 THEN 'New'
WHEN cb_person_cred_hist_length<=15 THEN 'Exprinced'
ELSE 'Very Exprinced'
END AS `Credir HIistory Bucket`,
credit_score,
CASE 
WHEN credit_score<580 THEN 'Poor'
WHEN credit_score<670 THEN 'Fair'
WHEN credit_score<740 THEN 'Good'
ELSE 'Exceptional'
END AS Credit_Score_Bucket,
previous_loan_defaults_on_file,
loan_status
FROM `banktransaction`.`frauddetection`.`loan_default`;
SELECT*
FROM  loan_default temp;