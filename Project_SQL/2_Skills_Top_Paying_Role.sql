-- Use the top paying jobs from the previous query to get the skills required for each job 
WITH Top_Paying_Jobs AS (
    SELECT job_id,
        job_title,
        company_dim.name AS Company,
        salary_year_avg
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title LIKE '%Data Analyst%'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT Top_Paying_Jobs.*,
    skills_dim.skills
FROM Top_Paying_Jobs
    INNER JOIN skills_job_dim ON Top_Paying_Jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY Top_Paying_Jobs.salary_year_avg DESC;