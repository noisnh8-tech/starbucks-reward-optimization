-- 오퍼 확인 안 하고 완료한 케이스 (C유형) 찾기
-- view 기록 없이 complete된 경우 = 마케팅 기여 없는 리워드 지급
-- 오퍼 확인 안 했는데 완료된 경우가 얼마나 되는지, 거기서 나간 비용이 얼마인지 보려고 만든 쿼리

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
