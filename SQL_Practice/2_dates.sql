-- Handling Dates ::Date , AT TIME ZONE , EXTRACT 
-- SELECT  
--     jpf.salary_hour_avg AS Hourly_Avg,
--     jpf.salary_year_avg AS Yearly_Avg
-- FROM 
--     job_postings_fact AS jpf 
-- WHERE
--     jpf.job_posted_date ::DATE > '2023-06-01' -- After June 1, 2023
-- -- GROUP BY 
-- --     jpf.job_schedule_type
-- ORDER BY 
--     Yearly_Avg DESC;
-- 1. Average Yearly & Hourly Salary by Job Schedule Type 
SELECT job_schedule_type,
    AVG(salary_year_avg) AS yearly_avg,
    AVG(salary_hour_avg) AS hourly_avg
FROM job_postings_fact
WHERE job_posted_date::DATE > '2023-06-01'
GROUP BY job_schedule_type
HAVING AVG(salary_year_avg) > 0
    OR AVG(salary_hour_avg) > 0
ORDER BY yearly_avg;
-- 2. Job Postings per month, with dates in EST time zone, Group & Order by Month 
SELECT EXTRACT(
        Month
        FROM job_posted_date AT TIME ZONE 'EST'
    ) AS month,
    COUNT(*) AS job_postings
FROM job_postings_fact
GROUP BY month
ORDER BY month;
-- 3. Company Names that posted jobs with health insurance True in 2nd Quarter of 2023  
SELECT company_dim.name,
    COUNT(job_postings_fact.job_id) AS job_postings
FROM company_dim
    JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
WHERE job_postings_fact.job_posted_date::DATE BETWEEN '2023-04-01' AND '2023-06-30'
    AND job_postings_fact.job_health_insurance = true
GROUP BY company_dim.name
ORDER BY job_postings DESC;