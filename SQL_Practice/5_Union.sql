SELECT 
    job_title_short,
    company_id,
    job_location
    
FROM january_jobs

UNION ALL 

SELECT 
    job_title_short,
    company_id,
    job_location
    
FROM february_jobs

UNION ALL

SELECT 
    job_title_short,
    company_id,
    job_location
    
FROM  march_jobs;


-- Skill and skill type for Q1 Jobs where salary > 70000
WITH Q1_Jobs AS (
(SELECT 
    skills_dim.skills,
    skills_dim.type,
    COUNT(*) AS skill_count
FROM january_jobs
    LEFT JOIN skills_job_dim ON skills_job_dim.job_id = january_jobs.job_id
    LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE january_jobs.salary_year_avg > 70000
GROUP BY skills_dim.skills,
    skills_dim.type)
UNION

(SELECT 
    skills_dim.skills,
    skills_dim.type,
    COUNT(*) AS skill_count
FROM february_jobs
    LEFT JOIN skills_job_dim ON skills_job_dim.job_id = february_jobs.job_id
    LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE february_jobs.salary_year_avg > 70000
GROUP BY skills_dim.skills,
    skills_dim.type)
UNION 

(SELECT 
    skills_dim.skills,
    skills_dim.type,
    COUNT(*) AS skill_count
FROM march_jobs
    LEFT JOIN skills_job_dim ON skills_job_dim.job_id = march_jobs.job_id
    LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE march_jobs.salary_year_avg > 70000
GROUP BY skills_dim.skills,
    skills_dim.type)
)

SELECT * 
FROM Q1_Jobs
ORDER BY skill_count DESC;
