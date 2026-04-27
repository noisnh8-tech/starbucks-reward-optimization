"""
transcript_clean.csv 생성 스크립트
원본 transcript.csv의 value 컬럼(딕셔너리 형태)에서
offer_id와 amount를 분리해 SQL 분석용 테이블로 저장합니다.
"""

import pandas as pd
import ast

# 원본 데이터 로드
df = pd.read_csv('../data/raw/transcript.csv')

def parse_value(row):
    try:
        d = ast.literal_eval(row['value'])
        offer_id = d.get('offer id') or d.get('offer_id')
        amount   = d.get('amount')
        reward   = d.get('reward')
    except Exception:
        offer_id, amount, reward = None, None, None
    return pd.Series({'offer_id': offer_id, 'amount': amount, 'reward': reward})

parsed = df.apply(parse_value, axis=1)
transcript_clean = pd.concat([df[['person', 'event', 'time']], parsed], axis=1)

# 저장
transcript_clean.to_csv('../data/processed/transcript_clean.csv', index=False)
print(f"저장 완료: {len(transcript_clean)}행")
print(transcript_clean.head())
