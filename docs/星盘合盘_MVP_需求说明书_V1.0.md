## 星盘合盘 MVP 需求说明书 V1.0

### 1. 背景与目标
- **背景**: 旅行匹配可扩展性差；引入“星盘合盘”作为底层语义，统一叙事与体验。
- **业务目标**
  - 提升安装→注册转化、首条回复率、D1 有效对话率
  - 形成可持续内容节律（每日/每周“缘分”），提升回流与付费触达
- **技术目标**
  - 在不牺牲“附近/活跃”的实时性前提下，有机融合“天选匹配”

### 2. 范围与不做
- **本期范围（MVP）**
  - Onboarding 采集出生信息（允许近似）
  - 首页双通道（天选/附近）与卡片“缘分徽章+轻报告”
  - 会话页顶部建议条与“合盘开场白”
  - 深报告并入订阅权益；可选一次性解锁
  - 埋点、实验与基础推送节律
- **不做**
  - 复杂占星解释 UI、长篇图文生成
  - 社交关系链/群聊等非核心改造

### 3. 用户与核心场景
- **用户画像**: 18–34 岁都市单身；对“命定/缘分/星座”有兴趣；重即时反馈
- **关键用户故事**
  - 作为新用户，我输入生日（时间不清楚也可），即可获得“天选推荐”与可用的开场白
  - 作为已有用户，我在聊天页获得“今日建议与雷区”，减少尬聊与误解
  - 作为有付费意愿的用户，我在高心动时刻看到“深度合盘报告与命定曝光”权益

### 4. 信息架构与主流程
- 首页（Match 重构）：顶部 Segment 切换
  - 今日天选 Destiny Today（少量精挑）
  - 附近可聊 Nearby Active（实时供给）
- 会话（Conversation）：顶部横条（建议/雷区），输入区开场白按钮
- 个人（Persona → 星语助理）：我的命盘预览、运势与问答
- 引导（Onboarding）：出生日期/时间/城市采集 → 生成“我的缘分画像”

### 5. 功能需求（按模块）
- **5.1 Onboarding 采集页（新增 `account/screens/astro_onboarding.dart`）**
  - 字段：birthDate(必填)、birthTime(可空)、timeAccuracy(enum)、birthPlace(city/country/lat/lng)
  - 交互：未知时间→“中午12点/大致时段”近似；完成后可在个人页补全
  - 校验：日期合法；城市搜索联想；可跳过
  - 成功提示：生成“缘分画像已就绪”
  - 埋点：astro_onboarding_view/submit/skip（参数：has_birth_time, accuracy）

- **5.2 首页双通道（改造 `core/home.dart` + `core/match/screens/match.dart`）**
  - 顶部 Segment：“天选/附近”
  - 卡片展示：右上“缘分徽章”（fate/harmony/risk 简要）；点击弹“轻报告”
  - 列表策略：
    - 天选：分桶(A/B/C) + 活跃 + 距离（控制数量与频次）
    - 附近：保持原逻辑；对 A 档对象提升曝光频次（不强插）
  - 轻报告弹层（新增 `core/astro/widgets/astro_light_report_sheet.dart`）
    - 内容：3–5 条一句话洞察 + 今日宜聊话题 + 3 个开场白
    - 行为：一键复制/插入到聊天，入口到深报告/订阅
  - 埋点：destiny_tab_view / nearby_tab_view / astro_card_impression/click / astro_report_view_light

- **5.3 会话页建议与开场白（改造 `core/chat/screens/chat.dart`）**
  - 顶部横条：今日建议与雷区（可收起，24h 缓存）
  - 输入区：开场白按钮（显示 3 个合盘开场白，支持翻译）
  - 埋点：astro_chat_banner_impression/click、astro_openers_show/click/use

- **5.4 深报告与订阅（改造 `core/subscribe/subscribe_page.dart`）**
  - 权益：详细相位/宫位、当日时机、命定配对优先曝光、Fate Boost 一次置顶
  - 付费触发：匹配后/对话热期/轻报告阅读 80%（做 A/B）
  - 可选：单次深度报告解锁 SKU（作为订阅引流）
  - 埋点：astro_paywall_view/start/convert

### 6. 数据模型与存储
- **MyProfile 扩展**
  - birthDate: DateTime
  - birthTime: String|null（HH:mm）
  - timeAccuracy: enum {accurate, approximate, unknown}
  - birthPlace: {city, country, lat, lng}
  - tzOffset: int（分钟）
- **AstroScore（`core/astro/models.dart`）**
  - { fate(0–100), harmony(0–100), risk(0–100), tags[string[]], prompts[string[]], version }
- **存储策略**
  - 客户端：本地缓存合盘结果 24h（Hive）；横条建议 24h
  - 清除：用户删除出生信息时清空相关缓存

### 7. 服务与接口（`core/astro/service.dart`）
- 首选后端 API，前端保留假分占位（用于无后端时的 A/B 起步）
- 接口契约
```json
POST /astro/synastry
{
  "a": {"birthDate":"1998-10-12","birthTime":"12:00","timeAccuracy":"approximate","birthPlace":{"lat":39.9,"lng":116.3},"tzOffset":480},
  "b": {"birthDate":"1996-03-08","birthTime":null,"timeAccuracy":"unknown","birthPlace":{"lat":31.2,"lng":121.5},"tzOffset":480}
}
=> 200
{
  "fate": 82, "harmony": 71, "risk": 24,
  "tags": ["强吸引","甜蜜期","注意沟通节奏"],
  "prompts": ["你对xx城市的第一印象是？","最近超想去的餐厅"],
  "version": "1.0.0"
}
```
```json
GET /astro/transit/today?userId=123
=> 200
{"tips":"今天宜开聊，避免深度讨论消费观","risk":["情绪波动"],"validFor":"2025-09-16"}
