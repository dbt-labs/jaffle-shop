
select  *, 
DATEDIFF ('day',SUBMISSION_DATE,REVIEW_START_DATE) AS  Submission_to_review,
DATEDIFF ('day',REVIEW_START_DATE, REVIEW_END_DATE) AS Review_duration,
DATEDIFF ('day',REVIEW_END_DATE,PRODUCTION_START_DATE) AS Review_to_production,
DATEDIFF ('day',PRODUCTION_START_DATE,PRODUCTION_END_DATE) AS Production_duration,
DATEDIFF ('day',SUBMISSION_DATE,PUBLICATION_DATE) AS Submission_to_publication,

from {{ ref('seed') }}