-- Subqueries - query within a query 

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
SELECT 
    company_id
FROM 
    job_postings_fact
WHERE 
    job_no_degree_mention = true
)

-- CTEs - temporary result set that can be referenced multiple times within SELECT, INSERT, UPDATE, DELETE  

WITH company_job_count AS (
SELECT 
    company_id,
    COUNT(*) AS Total_Jobs
FROM 
    job_postings_fact
GROUP BY
    company_id 
) 

-- SELECT * 
-- FROM company_job_count 
-- ORDER BY 
--     company_id;

SELECT 
    company_dim.name,
    company_job_count.Total_Jobs
FROM company_dim 
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    Total_Jobs DESC;

-- Top 5 skills with skill names 

WITH skill_count AS (
    SELECT 
        skills_job_dim.skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim
    GROUP BY 
        skills_job_dim.skill_id
    ORDER BY 
    skill_count DESC
)

SELECT 
    skills_dim.skills,
    skill_count.skill_count
FROM 
    skills_dim
LEFT JOIN skill_count ON skill_count.skill_id = skills_dim.skill_id

LIMIT 5;


-- Aggregate Companies into Small, Medium or Large based on number of jobs  (less than 10, 10-50, above 50)
SELECT 
    company_dim.name,
    company_job_count.Total_Jobs,
    CASE
        WHEN COUNT(*) < 10 THEN 'Small'
        WHEN COUNT(*) BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS Company_Size
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    Total_Jobs DESC;

WITH Company_Job_Count AS (
SELECT 
    company_id,
    COUNT(*) AS Total_Jobs,
    CASE
        WHEN COUNT(*) < 10 THEN 'Small'
        WHEN COUNT(*) BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS Company_Size
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
)

SELECT 
    company_dim.name,
    Company_Job_Count.Total_Jobs,
    Company_Job_Count.Company_Size
FROM 
    company_dim
LEFT JOIN Company_Job_Count ON Company_Job_Count.company_id = company_dim.company_id;
