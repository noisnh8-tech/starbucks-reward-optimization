-- 오퍼 확인 없이 완료된 케이스(C유형)를 식별하고,
-- 해당 건에서 발생한 리워드 비용을 집계하기 위한 쿼리

WITH viewed AS (
  SELECT DISTINCT person, offer_id
  FROM transcript
  WHERE event = 'offer viewed'
),
completed AS (
  SELECT person, offer_id, reward
  FROM transcript
  WHERE event = 'offer completed'
),
classified AS (
  SELECT
    c.person,
    c.offer_id,
    c.reward,
    CASE
      WHEN v.person IS NULL THEN 'C유형(우연완료)'
      ELSE '정상완료'
    END AS completion_type
  FROM completed c
  LEFT JOIN viewed v
    ON c.person = v.person
    AND c.offer_id = v.offer_id
)
SELECT
  completion_type,
  COUNT(*) AS count,
  ROUND(SUM(reward), 0) AS total_reward_cost
FROM classified
GROUP BY completion_type;



