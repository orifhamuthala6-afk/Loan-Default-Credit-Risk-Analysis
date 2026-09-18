-- Databricks notebook source
-- DBTITLE 1,Data Injection
-- MAGIC %python
-- MAGIC loan=spark.table( "`banktransaction`.`frauddetection`.`loan_default`")
-- MAGIC loan = loan.toPandas()
-- MAGIC import pandas as pd
-- MAGIC import numpy as np
-- MAGIC display(loan)
-- MAGIC

-- COMMAND ----------

-- DBTITLE 1,checking the size of the table
-- MAGIC %python
-- MAGIC loan.shape

-- COMMAND ----------

-- DBTITLE 1,checking the  data type in the tablw
-- MAGIC %python
-- MAGIC loan.dtypes

-- COMMAND ----------

-- DBTITLE 1,Checking for null
-- MAGIC %python
-- MAGIC loan.isnull().sum()

-- COMMAND ----------

-- DBTITLE 1,checking for dupilicate
-- MAGIC %python
-- MAGIC loan.duplicated().sum()

-- COMMAND ----------

-- DBTITLE 1,Checking the statical summary
-- MAGIC %python
-- MAGIC loan.describe()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC conditions = [
-- MAGIC loan["person_age"].between(18, 21),
-- MAGIC loan["person_age"].between(22, 35),
-- MAGIC loan["person_age"].between(36, 50),
-- MAGIC loan["person_age"].between(51, 60),
-- MAGIC loan["person_age"] > 60
-- MAGIC ]
-- MAGIC choices = [
-- MAGIC "Youth",
-- MAGIC "Young Adult",
-- MAGIC "Adult",
-- MAGIC "Elder",
-- MAGIC "Pensioner"
-- MAGIC ]
-- MAGIC
-- MAGIC loan["Age bracket"] = np.select(
-- MAGIC conditions,
-- MAGIC choices,
-- MAGIC default="Unknown"
-- MAGIC )
-- MAGIC display(loan[["person_age", "Age bracket"]])
-- MAGIC

-- COMMAND ----------

-- MAGIC %python
-- MAGIC loan = loan.rename(columns={"previous_loan_defaults_on_file": "Default Rate"})
-- MAGIC display(loan[["Default Rate"]])