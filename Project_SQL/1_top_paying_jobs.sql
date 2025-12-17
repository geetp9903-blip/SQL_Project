/*
 Question: What are the top paying data analyst jobs ? 
 - Identify the top 10 highest-paying data analyst jobs
 - Focus on job postings with specificed salaries (remove nulls) 
 */
SELECT job_id,
    job_title,
    company_dim.name AS Company,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title LIKE '%Data Analyst%'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10