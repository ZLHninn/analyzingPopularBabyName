--Classic Latin American Names: Identify names that have consistently been popular over the years.
SELECT Child_s_First_Name, SUM(Count) Total_value
FROM [dbo].[Popular_Baby_Names]
WHERE Ethnicity='HISPANIC'
GROUP BY Child_s_First_Name
HAVING COUNT(Child_s_First_Name) > 50
ORDER BY SUM(Count) DESC;

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

--Top-ranked Female Names since 1920: Rank female names by the total number of babies given that name.

SELECT TOP 10 RANK() OVER (ORDER BY SUM(Count) DESC) AS name_rank, Child_s_First_Name, SUM(Count) Total_value
FROM [dbo].[Popular_Baby_Names]
WHERE Gender = 'FEMALE'
GROUP BY Child_s_First_Name
;

--Picking a Baby Name: Select female names from 2016 onwards that end in ‘a’, and order them by popularity.
SELECT Child_s_First_Name
FROM [dbo].[Popular_Baby_Names]
WHERE Gender = 'FEMALE' AND Year_of_Birth > 2015 AND Upper(Child_s_First_Name) LIKE '%A'
GROUP BY Child_s_First_Name
ORDER BY SUM(Count) DESC;


