-- C유형(우연완료) 식별: 오퍼 미확인 완료 건수 및 리워드 비용 집계

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

-- 실행 결과:
-- | completion_type  | count  | total_reward_cost |
-- |-----------------|--------|-------------------|
-- | C유형(우연완료)   | 4,855  | 22,356            |
-- | 정상완료          | 28,724 | 142,320           |



