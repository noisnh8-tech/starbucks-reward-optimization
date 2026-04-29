-- 오퍼 타입(bogo / discount)별 완료 건수와 리워드 비용을 집계해
-- 비용 집중 구조를 확인하기 위한 쿼리

SELECT
  p.offer_type,
  COUNT(*) AS completed_count,
  ROUND(SUM(t.reward), 0) AS total_reward_cost,
  ROUND(AVG(t.reward), 1) AS avg_reward_per_offer,
  ROUND(
    SUM(t.reward) * 100.0
    / (SELECT SUM(reward) FROM transcript WHERE event = 'offer completed'), 1
  ) AS cost_share_pct
FROM transcript t
JOIN portfolio p ON t.offer_id = p.offer_id
WHERE t.event = 'offer completed'
GROUP BY p.offer_type
ORDER BY total_reward_cost DESC;

-- 실행 결과:
-- | offer_type | completed_count | total_reward_cost | avg_reward_per_offer | cost_share_pct |
-- |------------|-----------------|-------------------|----------------------|----------------|
-- | bogo       | 15,669          | 113,440           | 7.2                  | 68.9           |
-- | discount   | 17,910          | 51,236            | 2.9                  | 31.1           |





