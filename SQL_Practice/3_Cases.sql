-- Create Tables for January, February, March Jobs
CREATE TABLE January_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date AT TIME ZONE 'EST'
    ) = 1;
CREATE TABLE February_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date AT TIME ZONE 'EST'
    ) = 2;
CREATE TABLE March_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date AT TIME ZONE 'EST'
    ) = 3;
SELECT *
FROM January_jobs;
-- CASE , WHEN , THEN (if true), ELSE (optional if false), END
SELECT COUNT(job_id) AS Number_of_Jobs,
    AVG(salary_year_avg) AS Average_Salary,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS Location_Category -- sets the name of new column 
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY Location_Category;
-- Create New Column with CASE: Anywhere Jobs as Remote, New York, NY as Local, Otherwise Onsite
-- NEW CASE: Salary Category (Above, Below Average and NULL Category along with location category)
SELECT COUNT(job_id) AS Number_of_Jobs,
    CASE
        WHEN salary_year_avg > (
            SELECT AVG(salary_year_avg)
            FROM job_postings_fact
        ) THEN 'Above Average'
        WHEN salary_year_avg < (
            SELECT AVG(salary_year_avg)
            FROM job_postings_fact
        ) THEN 'Below Average'
        WHEN salary_year_avg = 0 THEN 'No Data'
        WHEN salary_year_avg = (
            SELECT AVG(salary_year_avg)
            FROM job_postings_fact
        ) THEN 'Average'
    END AS Salary_Category,
    -- sets the name of new column 
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS Location_Category -- sets the name of new column 
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY Location_Category,
    Salary_Category
ORDER BY Location_Category;