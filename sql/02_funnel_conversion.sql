-- 오퍼를 받은 이후 확인과 완료까지 이어지는 흐름을 보고,
-- 각 단계별 전환율을 확인하기 위한 퍼널 분석 쿼리

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



