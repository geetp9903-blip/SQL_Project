-- Most in-demand skills for data analyst jobs  
SELECT skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS Demand_Count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skills
ORDER BY 
    Demand_Count DESC
LIMIT 5;