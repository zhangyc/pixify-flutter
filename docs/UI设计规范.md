## 星盘合盘 设计规范与页面稿 V1.0

### 1) 设计目标
- 有机融合“天选（合盘）/附近（实时）”双通道，转化优先、不中断浏览。
- 统一视觉语言与文案，形成可扩展的设计系统与组件库。

### 2) Design Tokens（基础样式）
- 颜色
  - 主色: #22C58B（成功/高分） | 次主: #7C3AED（神秘/星盘） | 强调: #FF6A55（警示/雷区）
  - 文本: 主 #111827 | 次 #6B7280 | 反白 #FFFFFF
  - 背景: #F9FAFB | 卡片: #FFFFFF | 分割线: #E5E7EB
- 字体（已用 M PLUS Rounded 1c）
  - H1 24/32 Bold | H2 20/28 Semibold | Body 16/24 Regular | Caption 12/16
- 圆角与阴影
  - 卡片 Radius 16 | 徽章半圆 999 | 阴影 0 8 24 rgba(0,0,0,0.08)
- 间距
  - 8 基准栅格：4/8/12/16/20/24/32

### 3) 组件库（命名建议）
- Segmented 控件: `SegTabs`（天选/附近）
- 用户卡片: `UserCard`（含头像、姓名年龄、距离、活跃点）
- 星盘徽章: `AstroBadge`（Fate/Harmony/Risk 微型图标+分数）
- 轻报告底部弹层: `AstroLightReportSheet`
- 会话顶部横条: `AstroChatBanner`
- 开场白条: `OpenersBar`（三枚按钮，可横滑）
- 订阅权益卡: `EntitlementCard`（勾选列表+CTA）
- 表单字段: `FormDate`, `FormTime`, `FormPlace`（带“未知时间”选项）

### 4) 页面低保真（ASCII Wireframe）

- 首页（双通道）
```
[ 搜索 | 提醒 ] 
[ 天选 | 附近 ]  ← SegTabs
────────────────────────────────
[ UserCard ]  ┐
[ 头像大图   ] │  右上: [ AstroBadge 82 ]
[ 姓名·年龄  ] │  底部：标签/距离/活跃点
[ 今日话题提示 ]│  点击卡片 → 弹 AstroLightReportSheet
────────────────────────────────
[ UserCard ] ...
```

- 轻报告弹层（AstroLightReportSheet）
```
╔════════ 你们的缘分（82） ════════╗
  • 强吸引：xxx
  • 日常相处：xxx
  • 雷区提示：xxx
  今日宜聊：[#旅行愿望] [#最近美食]
  开场白（点即发送）：
  [ 我刚看你的xxx.. ] [ 最近最想去.. ] [ 第一次印象.. ]
  [ 查看深度合盘报告 → 订阅 ]
╚═══════════════════════════════╝
```

- 会话页（AstroChatBanner + Openers）
```
┌ Chat Header (对方头像/状态)
│ [ 今日建议：放轻节奏，避免财务话题 ]  [展开]
│ Openers: [ 想起你说的.. ] [ 这周哪天.. ] [ 上次提到.. ]  →
└ 输入框 [Aa][麦克风][发送]
```

- 星盘采集（Astro Onboarding）
```
生日 [ 1998-10-12 ] 
出生时间 [ 12:00 ]  [ 不清楚 ] → 勾选显示“中午12点（近似）”
出生城市 [ 北京 ]  (搜索联想)
[ 下 一 步 ]
```

- 订阅页（权益呈现）
```
深度合盘 · 星语助理 · 命定曝光
✓ 双方深度合盘（相位/宫位全量）
✓ 今日/本周缘分窗口 & 会话建议
✓ 开场白库 Pro（翻译/语气）
✓ 命定配对优先曝光（天选位）
[ 立即订阅 ¥48/月 ]  [ 了解更多权益 ]
```

### 5) 交互与状态
- 首页卡片：先渲染基础信息→异步补 AstroBadge；失败时隐藏徽章不报错。
- 轻报告：上滑关闭/点击遮罩关闭；“查看深度报告”进入付费墙。
- 会话横条：默认展开一次/天，可收起 24h 记忆；点击“展开”展示更多建议。
- 开场白：点即填充输入框，可二次编辑后发送；埋点 `openers_use`.

### 6) 文案（可直接给设计/本地化）
- SegTabs：天选配对｜附近可聊
- AstroBadge：缘分 82｜契合 71｜雷区 24
- 轻报告标题：你们的缘分（82）
- 轻报告洞察示例：
  - 强吸引：你们在xxx主题上天然投缘
  - 日常相处：节奏相近，适合有计划的小约会
  - 雷区提示：避免在开聊就讨论消费观
  - 今日宜聊：最近想去的城市/这周最想做的一件事
- 开场白模板：
  - “看到你写的xxx，我也正好…”
  - “如果周末只选一个好去处，你会选…？”
  - “第一眼你给我感觉像…（友好版）”
- 订阅 CTA：解锁深度合盘｜获得命定曝光

### 7) 资源清单（交付给设计/前端）
- 图标：`astro_star.svg`, `astro_risk.svg`, `astro_heart.svg`, `seg_today.svg`, `seg_nearby.svg`
- 插图（可选）：“星空+心动”头图 1 张；空状态插画 2 张
- Lottie（可选）：轻报告打开小动效（0.6s）

### 8) Figma 结构建议（命名）
- Pages：01_Home, 02_Report, 03_Chat, 04_Onboarding, 05_Subscribe, 99_System
- Components：
  - `SegTabs/Primary`
  - `Card/UserCard.(default|loading|error)`
  - `Badge/Astro.(A|B|C)`
  - `Sheet/LightReport`
  - `Banner/AstroChat`
  - `Bar/Openers`
  - `Buttons/(Primary|Ghost|Tonal)`
- Tokens：`Color/*`, `Font/*`, `Radius/*`, `Shadow/*`, `Spacing/*`

### 9) 验收清单（设计/前端共同对齐）
- 卡片 3 状态：正常/加载骨架/失败隐藏 AstroBadge
- 轻报告弹层 3 高度：小（内容≤2行）/中（默认）/大（滚动）
- 会话横条可收起，并 24h 记忆；开场白≥3 条可横滑
- 订阅页权益可配置（与后端权益表一致），CTA 不遮挡系统手势
```