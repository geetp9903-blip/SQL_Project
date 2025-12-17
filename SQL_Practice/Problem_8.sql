
SELECT
    Q1_Jobs.job_title_short,
    Q1_Jobs.job_location,
    Q1_Jobs.job_posted_date::Date,
    Q1_Jobs.salary_year_avg
    FROM (SELECT * 
        FROM january_jobs
        UNION ALL
        SELECT * 
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
        ) AS Q1_Jobs
WHERE Q1_Jobs.salary_year_avg > 70000 AND Q1_Jobs.job_title_short = 'Data Analyst'
ORDER BY Q1_Jobs.salary_year_avg DESC;
