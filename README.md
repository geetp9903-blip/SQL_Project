# Data Analyst Job Market Analysis (PostgreSQL)

This project analyzes the **Data Analyst job market** using **PostgreSQL queries** and **CSV-based outputs** derived from real-world job postings.  
The objective is to uncover **salary trends, skill demand, and optimal skill combinations** that maximize both compensation and employability.

The project demonstrates an end-to-end analytics workflow:
- Translating business questions into SQL queries
- Extracting insights from relational data
- Visualizing results using Python
- Communicating findings through a professional README

---

### 🛠 Technologies Used
- PostgreSQL  
- SQL (JOIN, WHERE, ORDER BY, LIMIT)  
- Python (Matplotlib)  
- Git & GitHub  

---

## 1. Top Paying Data Analyst Jobs
![Top Paying Jobs](assets\chart_top_paying_jobs.png)

### 🔍 Key Insights
- The highest-paying Data Analyst roles are typically **senior or specialized positions**, showing strong salary growth with experience.
- **Large tech and enterprise companies** dominate the top salary brackets.
- High compensation is not limited to on-site roles—**remote and flexible jobs** also appear among the top-paying positions.

///

SELECT
    job_id,
    job_title,
    company_dim.name AS company,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title LIKE '%Data Analyst%'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

///
---

## 2. Skills Required for Top Paying Roles
![Top Paying Job Skills](assets\chart_top_paying_job_skills.png)

### 🔍 Key Insights

- SQL is a universal requirement across all **top-paying Data Analyst roles**.
- **High-paying roles** demand skill stacking, not single-tool expertise.
- Advanced tools such as **Python, BI tools, and cloud technologies** are strongly associated with higher salaries.

///

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title LIKE '%Data Analyst%'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.job_title,
    top_paying_jobs.company,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY top_paying_jobs.salary_year_avg DESC;

///
---

## 3. Most In-Demand Data Analyst Skills
![Most In-Demand Skills](assets\chart_demand_skills.png)

### 🔍 Key Insights

- **SQL** is the most in-demand skill, making it foundational for analytics careers.
- **Excel and Python** continue to be core tools in the job market.
- **Data visualization skills** highlight the importance of storytelling and communication.

///

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;
///
---

## 4. Skills with the Highest Average Salary
![Highest Paying Skills](assets\chart_paying_skills.png)

### 🔍 Key Insights

- **Specialized and less common skills** command higher average salaries, reflecting scarcity value.
- **Salary premiums increase with technical depth and complexity**.
- **High-paying skills** often appear in fewer postings, making them valuable but competitive.

///

SELECT
    skills_dim.skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
ORDER BY
    average_salary DESC
LIMIT 25;

///
---

## 5. Optimal Skills: Demand vs Salary
![Optimal Skills](assets\chart_optimal_skills.png)

### 🔍 Key Insights

- SQL offers the strongest **balance of demand and salary**, making it the most strategic skill.
- **Python and BI tools** provide strong secondary leverage.
- Extremely niche skills may offer **high pay but pose higher career risk due to low demand**.

///

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT 25;

///
---

## Tools
- PostgreSQL
- Advanced SQL (CTEs, JOINs, Aggregations)
- Python (Pandas, Matplotlib)

### 🚀 Final Takeaway

#### This project demonstrates my ability to:

- Translate business questions into SQL queries
- Analyze real-world job market data
- Visualize insights clearly and effectively
- Connect technical findings to career and market strategy