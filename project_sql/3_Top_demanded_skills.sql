-- What are the most demanded skills for a Data Analyst worldwide?

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
