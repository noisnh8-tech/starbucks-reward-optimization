-- 퍼널 전환율: Receive → View → Complete 단계별 전환율 집계

SELECT
  COUNT(CASE WHEN event = 'offer received' THEN 1 END) AS received_count,
  COUNT(CASE WHEN event = 'offer viewed' THEN 1 END) AS viewed_count,
  COUNT(CASE WHEN event = 'offer completed' THEN 1 END) AS completed_count,
  ROUND(
    COUNT(CASE WHEN event = 'offer viewed' THEN 1 END) * 100.0
    / COUNT(CASE WHEN event = 'offer received' THEN 1 END), 1
  ) AS view_rate_pct,
  ROUND(
    COUNT(CASE WHEN event = 'offer completed' THEN 1 END) * 100.0
    / COUNT(CASE WHEN event = 'offer received' THEN 1 END), 1
  ) AS complete_rate_pct
FROM transcript
WHERE event IN ('offer received', 'offer viewed', 'offer completed');

-- 실행 결과:
-- | received_count | viewed_count | completed_count | view_rate_pct | complete_rate_pct |
-- |----------------|--------------|-----------------|---------------|-------------------|
-- | 76,277         | 57,725       | 33,579          | 75.7          | 44.0              |



