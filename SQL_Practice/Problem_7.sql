-- Top Skills for Remote Data Analyst Jobs 
WITH Remote_Job_skills AS (
    SELECT sjd.skill_id,
        COUNT(*) AS Skill_Count
    FROM skills_job_dim AS sjd
        INNER JOIN job_postings_fact AS jpf on sjd.job_id = jpf.job_id
    WHERE jpf.job_work_from_home = true
        AND jpf.job_title_short = 'Data Analyst'
    GROUP BY sjd.skill_id
)
SELECT skills_dim.skills,
    Remote_Job_skills.Skill_Count
FROM skills_dim
    INNER JOIN Remote_Job_skills ON skills_dim.skill_id = Remote_Job_skills.skill_id
ORDER BY Remote_Job_skills.Skill_Count DESC
LIMIT 10;