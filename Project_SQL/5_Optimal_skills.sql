-- WITH skills_demand AS(
--     SELECT 
--         skills_dim.skill_id,
--         skills_dim.skills,
--         COUNT(skills_job_dim.job_id) AS Demand_Count
--     FROM 
--         job_postings_fact
--         INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--         INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE 
--         job_postings_fact.job_title_short = 'Data Analyst'
--         AND job_postings_fact.salary_year_avg IS NOT NULL
--     GROUP BY skills_dim.skill_id
-- ), Avg_Salary AS(
--     SELECT 
--         skills_dim.skill_id,
--         skills_dim.skills,
--         ROUND(AVG(salary_year_avg), 0) AS Average_Salary
--     FROM job_postings_fact
--         INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--         INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE job_postings_fact.job_title_short = 'Data Analyst'
--         AND job_postings_fact.salary_year_avg IS NOT NULL
--     GROUP BY skills_dim.skill_id
-- )

-- SELECT 
--     skills_demand.skill_id,
--     skills_demand.skills,
--     skills_demand.Demand_Count,
--     Avg_Salary.Average_Salary
-- FROM skills_demand

-- INNER JOIN Avg_Salary ON skills_demand.skill_id = Avg_Salary.skill_id
-- WHERE 
--     skills_demand.Demand_Count > 10
-- ORDER BY 
--     Avg_Salary.Average_Salary DESC,
--     skills_demand.Demand_Count DESC
-- LIMIT 25;

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS Demand_Count,
    ROUND(AVG(salary_year_avg), 0) AS Average_Salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    -- AND job_work_from_home = True
GROUP BY skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    Demand_Count DESC,
    Average_Salary DESC
LIMIT 25;