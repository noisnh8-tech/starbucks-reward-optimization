# Starbucks Reward 비용 구조 개선 프레임워크

스타벅스 리워드 오퍼 데이터를 분석해 구조적 비용 낭비를 정량화하고,  
Opt-in 전환 전략으로 $260,000 절감 구조를 도출한 마케팅 분석 프로젝트

---

## 1. 문제 정의

오퍼를 확인하지 않은 고객에게도 리워드가 자동 지급되는 구조가 반복된다.  
→ 전체 리워드 비용의 **16.5%** 가 마케팅 기여 없이 소진  
→ 오퍼 없이도 구매할 고객에게 불필요한 비용이 추가되는 구조

**핵심 질문:**  
> 리워드 지출이 실제 구매를 유도하는가, 아니면 기존 구매에 비용이 추가되는 구조인가?

분석 대상: 고객 17,000명 · 이벤트 306,534건 (시뮬레이션 1개월 데이터)

---

## 2. 핵심 인사이트

| 발견 | 결론 | 수치 |
|------|------|------|
| 세그먼트로 오퍼 전략 도출 가능 | ❌ | 인구통계 변수만으로는 예측력 낮음 |
| 우연완료 구조 존재 | ✅ | 전체 완료의 **16.5%** = view 없이 complete |
| 루틴형 고객 오퍼 없이도 구매 유지 | ✅ | 상위 **30%** = Routine Score 기준 |
| 고소득층 비용 잠식 구조 | ✅ | 잠식 매출이 순 증대 매출의 **3배** |
| Opt-in 전환 시 낭비 차단 | ✅ | 최대 **$260,000** 절감 |

**분석이 전환된 순간:**  
"누가 오퍼에 반응하는가" → **"누가 오퍼 없이 구매하는가"**

---

## 3. 분석 및 실행 파이프라인 (End-to-End)

리워드 비용을 '기여 매출 vs 낭비 비용'으로 분해하기 위해 다음 단계를 순차적으로 설계했습니다.

| 단계 | 파일 | 목적 |
|------|------|------|
| 01 | `01_data_preparation.ipynb` | 데이터 통합 및 정제 — 분석 기반 확보 |
| 02 | `02_funnel_analysis.ipynb` | 퍼널 구조 정의 — 우연완료(C유형) **16.5%** 정량화 |
| 03 | `03_routine_customer_analysis.ipynb` | 고객 행동 분석 — 오퍼 비의존 단골 고객(상위 **30%**) 식별 |
| 04 | `04_marketing_kpi.ipynb` | KPI 분석 — 마케팅 효율 **0.34** 및 비용 구조 규명 |
| 05 | `05_strategy.ipynb` | 전략 도출 — **$260,000** 절감 구조 설계 |

> 01 → 02: 마스터 테이블 기반으로 퍼널 구조 정의  
> 02 → 03: 우연완료 확인 후 고객 행동 패턴 분석으로 전환  
> 03 → 04: 루틴형 고객 분리 후 KPI로 비용 낭비 정량화  
> 04 → 05: 분석 결과를 실행 가능한 전략으로 연결

---

### 실행 방법

순서: `01_data_preparation` → `02_funnel_analysis` → `03_routine_customer_analysis` → `04_marketing_kpi` → `05_strategy`

> 순차 실행 시 전체 분석 재현 가능

### SQL 쿼리

Python 탐색 분석 후, 반복 모니터링이 필요한 핵심 지표를 SQL로 별도 정리.  
SQLite 기반으로 실행 가능하며 `sql/` 폴더에서 확인 가능.

| 파일 | 내용 |
|------|------|
| `01_prepare_transcript.py` | value 컬럼 파싱 → SQL 분석용 테이블 생성 |
| `02_funnel_conversion.sql` | 퍼널 단계별 전환율 (Receive → View → Complete) |
| `03_c_type_detection.sql` | C유형(우연완료) 식별 및 리워드 비용 집계 |
| `04_segment_cost.sql` | 오퍼 타입별 리워드 비용 분석 |

---

> ### ⚠️ 실행 안내 및 데이터 공지
>
> 1. **데이터 출처**
>    - Kaggle Starbucks Rewards ( transcript.csv, profile.csv는 개인정보로 제외)

> 2. **데이터 준비**
>    - [Kaggle Starbucks Rewards 데이터](https://www.kaggle.com/datasets/ihormuliar/starbucks-customer-data)
>    - 다운로드 후 `data/raw/` 경로에 추가

> 3. **실행 흐름**
>    - `01_data_preparation.ipynb` 실행 → `prep_master_table.csv` 생성
>    - 이후 노트북(02~05) 실행 가능

---

## 4. 결과

| KPI | 값 | 해석 |
|-----|----|------|
| 우연완료 비중 | **16.5%** | 마케팅 기여 없는 리워드 지급 비율 |
| 마케팅 효율 | **0.34** | $1 투자 시 $0.34 순 증대 매출 발생 |
| 잠식 매출 | 순 증대 매출의 **3배** | 고소득층 중심 비용 낭비 집중 |
| 루틴형 고객 비중 | 상위 **30%** | 오퍼 비의존 단골 — 오퍼 축소 대상 |
| Opt-in 전환 절감 | 최대 **$260,000** | C유형 자동 지급 차단 시 기대 절감액 |

**세그먼트별 오퍼 운영 전략:**

| 그룹 | 특성 | 오퍼 방식 |
|------|------|-----------|
| A: 고 Net Lift + 저 Cannibalization | 오퍼 효과 명확 | 확대 |
| B: 저 Net Lift + 저 Cannibalization | 관심은 있음 | 혜택 강화 |
| C: 고 Net Lift + 고 Cannibalization | 잠식 구조 | 오퍼 타입 변경 |
| D: 저 Net Lift + 고 Cannibalization | 낭비 집중 | **Opt-in 전환** |

---

## 5. 폴더 구조

```
starbucks-reward-optimization/
├── notebooks/
│   ├── 01_data_preparation.ipynb
│   ├── 02_funnel_analysis.ipynb
│   ├── 03_routine_customer_analysis.ipynb
│   ├── 04_marketing_kpi.ipynb
│   └── 05_strategy.ipynb
├── data/
│   ├── raw/               # portfolio.csv (profile.csv, transcript.csv 추가 필요)
│   └── processed/         # 분석용 데이터셋 (01 실행 시 prep_master_table.csv 생성)
└── README.md
```

---

## 6. 담당 역할

- **비즈니스 퍼널 기반 데이터 통합 구조 설계** — Receive → View → Complete inst_id 기반 1행 통합, 오퍼별 추적 가능한 마스터 테이블 구축
- **Net Lift / Cannibalization 기반 기여도 분석** — 리워드 지출을 '마케팅 기여 매출 vs 낭비 비용'으로 정량 분해, 마케팅 효율 0.34 도출
- **고객 유형 분류 및 행동 패턴 분석** — A/B/C/D 4유형 퍼널 분류 및 Routine Score 기반 오퍼 비의존 고객(상위 30%) 식별
- **비용 구조 분석 및 낭비 정량화** — 우연완료 16.5%, 고소득층 잠식 구조 확인, 세그먼트별 리워드 낭비 비중 산출
- **실행 전략 연결** — 분석 결과를 Opt-in 전환 시나리오로 연결, $260,000 절감 구조 도출

---

*데이터: Starbucks Rewards Mobile App 시뮬레이션 데이터 (Kaggle / Udacity 제공)*


