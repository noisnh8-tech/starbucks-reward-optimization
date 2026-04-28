-- 오퍼 받은 사람 중 실제로 확인하고 완료까지 간 비율이 얼마나 되는지 보려고 만든 쿼리
-- 각 단계별 건수 세고 비율 계산

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


