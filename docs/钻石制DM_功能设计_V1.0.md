## 钻石制 DM 功能设计 V1.0

### 0. 背景与目标
- 作为独立开发者，当前版本需尽快封板发布，钻石制 DM 放入下版以打造可持续营收的“最小可行盈利路径”。
- 目标：以“可控成本的冷 DM”驱动转化，保障体验与合规；同时不影响已匹配对话的自然增长。

### 1. 范围与定义
- 钻石（Gems）：可消耗虚拟货币（Consumable IAP）。
- 冷 DM：对未匹配用户发送的私信。
- 匹配对话：双方互相匹配后的聊天。
- 星语问候：轻量触达动作，用于拉新与促转。

### 2. 定价与包档（建议）
- 汇率锚点：1 USD ≈ 10 钻（本地货币由商店自动换算）。
- 包档（含赠送，拉高 ARPPU）：
  - gems_10: $0.99 → 10 钻
  - gems_60: $4.99 → 60 钻（+10 赠送）
  - gems_140: $9.99 → 140 钻（+40 赠送）
  - gems_320: $19.99 → 320 钻（+120 赠送）

### 3. 消耗规则（默认值可 RC 配置）
- 冷 DM：3 钻/条
- 已匹配对话：0 钻/条（鼓励互动）
- 星语问候：1 钻/次（轻触达）
- 附件加价（可选，后续灰度）：图片 +1、语音 +1

### 4. 用户体验（UX）
1) 余额可见
   - 聊天输入区上方显示“余额：12 钻”；<20 钻时使用强调色提示。
2) 费用提示
   - 发送按钮旁展示费用标签“3 钻”；点击/长按出现说明气泡：“冷 DM 扣 3 钻，已匹配免费”。
3) 余额不足拦截
   - 弹窗展示差额与推荐包档（默认勾选性价比最高档，如 $4.99/60 钻）。
4) 发送反馈
   - 成功：Toast “已扣 3 钻（剩余 27）”；失败：回滚并提示重试。
5) 多入口充值
   - 聊天页、消息列表页顶部余额卡片、个人页“我的钱包”、喜欢我的页、空状态页。

### 5. UI 指南（nightTheme 风格对齐）
- 钱包卡片：surfaceContainer/outlineVariant 边；数字用 onSurface 强对比；不足时改为 tertiary。
- 发送按钮费用标签：primaryContainer + onPrimaryContainer；有动画轻提示（缩放/呼吸）。
- 充值弹窗：两列卡片 + 推荐角标（Best Value）；次要 CTA 为“继续浏览”。

### 6. IAP 配置
- 商品类型：Consumable（可消耗）
- Product IDs（建议命名）：
  - Google Play: `gems_10`, `gems_60`, `gems_140`, `gems_320`
  - App Store:  同名一套
- 收据校验：
  - 客户端支付成功 → 服务端校验（Google/Apple）→ 幂等入账（purchaseToken / transactionId 去重）→ 返回新余额。
- 退款策略：
  - 检测退款后回收等额钻石（允许负余额并限制付费操作）。

### 7. 后端与风控（最小实现）
- 数据模型
  - UserBalance: user_id, gems_balance, updated_at
  - GemsLedger: id, user_id, delta(+/-), reason(enum), ref_id, created_at（幂等）
  - Reasons: top_up, dm_cold_send, star_greeting, attachment_image, refund_revoke, grant_promo
- 扣费流程
  - Pre-check 余额 → 原子扣减（事务）→ 写 Ledger → 发送消息 → 失败回滚。
- 频控/质量
  - 冷 DM 每日上限（默认 20/日，Plus 提升）
  - 低回复/被举报用户降频或限流（灰度开关）

### 8. Remote Config（默认关闭以不影响当前版本）
- feature_dm_gems_enabled: false
- gem_per_usd: 10
- dm_cost_cold: 3
- dm_cost_matched: 0
- star_greeting_cost: 1
- daily_free_gems: 1
- daily_free_gems_cap: 3
- starter_pack_enabled: true
- starter_pack_price: 0.99
- starter_pack_gems: 20

### 9. 埋点（对齐你的事件规范：动词_名词 + 通用参数）
通用参数：user_id, gender, age_range, locale, country, source, ab_variant, app_version, os_version, device

- 钱包与入口
  - wallet_view
  - wallet_low_balance
  - topup_entry_click {source_entry}
- 充值链路
  - top_up_impression {pack_id, price_usd, gems}
  - top_up_start {pack_id}
  - top_up_success {pack_id, price_usd, gems}
  - top_up_fail {pack_id, error_code}
- 消耗链路
  - dm_cost_impression {dm_type}
  - dm_send_paid {dm_type, cost_gems, balance_before, balance_after}
  - dm_send_free {dm_type}
  - dm_send_fail_insufficient {dm_type, need_gems}
  - dm_attach_addon {addon_type}
- RC
  - rc_fetch {keys}
  - rc_activate {feature_dm_gems_enabled}

### 10. 文案与 i18n（Key 草案）
- walletBalance: “钻石余额”
- costColdDm: “冷 DM 扣 {n} 钻”
- costMatched: “已匹配对话免费”
- topUpNow: “立即补充”
- continueBrowsing: “继续浏览”
- bestValue: “最优性价比”
- lowBalance: “余额不足（{n}）”
- deductToast: “已扣 {cost} 钻（剩余 {left}）”

### 11. 上线计划与里程碑
- 本版（收口-发布）
  - 完成：订阅页（Plus）、i18n 校验通过、Liked Me 优化、Persona 国际化、Astro 预览相位+角度、筛选页主题化与布局微调。
  - 验收：主路径无崩溃、订阅购买/恢复、深浅色可读性、ARB 生成、冷启动与回前台性能。
- 下版（新增钻石制 DM）
  - M1：钱包余额组件、RC 开关、DM 扣费与拦截弹窗、Consumable IAP 入账。
  - M2：频控与反骚扰、星语问候扣费、附件加价（灰度）。
  - M3：看板与策略优化（地区定价/打包优化/Plus 叠加）。

### 12. 验收标准（下版）
- 充值成功率 ≥ 97%，收据幂等 100%，异常下发 < 0.1%
- 冷 DM 扣费路径时延 P95 < 400ms（服务端扣减）
- 余额一致性无丢单；退款回收 100% 覆盖
- 埋点命中率 ≥ 99%，看板口径与明细一致

### 13. 风险与对策
- 退款与合规：服务端校验与回收；地区定价与税务按商店规则
- 滥用与骚扰：频控、灰度限流、低质量用户加价或封禁
- 金额与价格实验：通过 RC + A/B 分层调整 DM 单价与包档

---
注：本设计默认与现有“Astro Pair Plus”并存，互不冲突；上线顺序以里程碑为准，功能开关由 Remote Config 控制，默认关闭以不影响当前版本发布。


