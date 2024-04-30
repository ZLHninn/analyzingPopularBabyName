# AnalyzingPopularBabyName
# Proposal for Analyzing the Popular Baby Names Dataset
# Introduction
The Popular Baby Names dataset is a rich source of information that can provide insights into trends in baby names over time. This proposal outlines a plan to analyze this dataset using SQL, a powerful tool for data manipulation and analysis.

# Objectives
The main objectives of this analysis are:
Identify the most popular baby names over time.
Understand the distribution of baby names by sex and ethnic group.
Identify trends in baby names.

# Methodology
We propose to use SQL for this analysis due to its powerful data manipulation and querying capabilities. Here are some of the SQL queries we plan to use:
1. Classic American Names: Identify names that have consistently been popular over the years.

# SQL Code
--Classic Latin American Names: Identify names that have consistently been popular over the years.
SELECT Child_s_First_Name, SUM(Count) Total_value
FROM [dbo].[Popular_Baby_Names]
WHERE Ethnicity='HISPANIC'
GROUP BY Child_s_First_Name
HAVING COUNT(Child_s_First_Name) > 50
ORDER BY SUM(Count) DESC;

2. Timeless or Trendy: Classify names based on their popularity over time.

# SQL Code
-- Timeless or Trendy: Classify names based on their popularity over time.
SELECT Upper(Child_s_First_Name), SUM(Count) Total_value,
CASE
    WHEN COUNT(Upper(Child_s_First_Name)) > 80 THEN 'Classic'
    WHEN COUNT(Upper(Child_s_First_Name)) > 50 THEN 'Semi-classic'
    WHEN COUNT(Upper(Child_s_First_Name)) > 20 THEN 'Semi-trendy'
    ELSE 'Trendy'
END AS popularity_type
FROM [dbo].[Popular_Baby_Names]
GROUP BY Child_s_First_Name
ORDER BY Child_s_First_Name ASC;

3. Top-ranked Female Names since 1920: Rank female names by the total number of babies given that name.

#SQL Code
--Top-ranked Female Names since 1920: Rank female names by the total number of babies given that name.
SELECT TOP 10 RANK() OVER (ORDER BY SUM(Count) DESC) AS name_rank, Child_s_First_Name, SUM(Count) Total_value
FROM [dbo].[Popular_Baby_Names]
WHERE Gender = 'FEMALE'
GROUP BY Child_s_First_Name
;

4. Picking a Baby Name: Select female names from 2016 onwards that end in ‘a’, and order them by popularity.

# SQL Code
--Picking a Baby Name: Select female names from 2016 onwards that end in ‘a’, and order them by popularity.
SELECT Child_s_First_Name
FROM [dbo].[Popular_Baby_Names]
WHERE Gender = 'FEMALE' AND Year_of_Birth > 2015 AND Upper(Child_s_First_Name) LIKE '%A'
GROUP BY Child_s_First_Name
ORDER BY SUM(Count) DESC;



