# Data Analytics Job Postings Case Study

🔎 Check all the SQL queries in [HERE](/project_sql/).

First of all, it is important to know how many job postings are being researched:

```sql
SELECT
    COUNT(*)
FROM 
    job_postings_fact
```

<img src="https://github.com/fernandoprim/Assets/blob/main/job_posting_project/Total.png"/>

Great! We got a total of 787,686 job postings.
Now into the questions!

## 1. What are the top paying Data Analyst jobs?

```sql
SELECT
    jpf.job_id,
    cd.name AS company_name,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date
FROM
    job_postings_fact jpf
    JOIN company_dim cd ON cd.company_id = jpf.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```

### Outcome:

<img src="https://github.com/fernandoprim/Assets/blob/main/job_posting_project/Q1.png"/>

## 2. What are the most demanded skills for Data Analysts?

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS skill_demand
FROM job_postings_fact jpf
INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    skill_demand DESC
LIMIT 5
```

### Outcome:

<img src="https://github.com/fernandoprim/Assets/blob/main/job_posting_project/Q2.png"/>

## 3. What are the top Paying skills?

```sql
SELECT
    skills,
    TRUNC(AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact jpf
INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 10
```

### Outcome:

<img src="https://github.com/fernandoprim/Assets/blob/main/job_posting_project/Q3.png"/>

## 4. What are the most optimal skills to learn for the area?

The objective with this query is to find what are the skills that have both a high demand and salary inside the Data Analyst job market.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 50
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

### Outcome:

<img src="https://github.com/fernandoprim/Assets/blob/main/job_posting_project/Q4.png"/>

# Conclusions

This project strengthened my SQL expertise and offered valuable perspectives on the data analyst job market. The insights gained from the analysis help in prioritizing skill development and job-hunting strategies. I can say that this exploration underscores the necessity of ongoing learning and staying adaptable to evolving trends.
