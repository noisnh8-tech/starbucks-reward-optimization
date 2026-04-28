-- bogo랑 discount 중 어디서 비용이 더 많이 나가는지 확인하려고 만든 쿼리
-- 오퍼 타입별 완료 건수랑 리워드 비용 집계
-- bogo / discount 중 어디서 비용이 더 나가는지 확인

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





