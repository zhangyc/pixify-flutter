# 疗愈模块国际化文本清单

## 1. astro_calendar_page.dart (星盘日历)

### 页面标题
- `星盘疗愈日历` → healing_calendar_title

### 月度统计
- `活跃天数` → active_days
- `疗愈次数` → healing_count  
- `连续打卡` → streak_days

### 日期详情
- `{月}月{日}日` → date_format_md
- `这天还没有记录哦` → no_records_today

### 活动类型
- `冥想练习` → meditation_practice
- `情绪日记` → emotion_diary
- `每日状态` → daily_status
- `疗愈音乐` → healing_music

### 活动描述
- `{x} 分钟` → x_minutes
- `记录了情绪` → recorded_emotion
- `心情 {x}/10` → mood_score_x
- `播放了音频` → played_audio

### 月相解读
- `新月时刻，适合开启新的疗愈计划` → new_moon_insight
- `月亮渐盈，能量逐渐积累` → waxing_crescent_insight
- `上弦月，是行动和决策的好时机` → first_quarter_insight
- `满月将至，情绪可能更加敏感` → waxing_gibbous_insight
- `满月能量最强，适合释放情绪` → full_moon_insight
- `月亮渐亏，适合反思和整理` → waning_gibbous_insight
- `下弦月，放下过去，准备新开始` → last_quarter_insight
- `残月时刻，休息和恢复很重要` → waning_crescent_insight

---

## 2. healing_screen.dart (疗愈主页)

### 页面元素
- `心理疗愈` → psychological_healing
- `关闭背景音乐` / `开启背景音乐` → toggle_background_music
- `今日心语` → daily_quote
- `点击记录今日状态` → click_to_record_status
- `点击我获得鼓励` → click_for_encouragement
- `你真棒！继续保持 ✨` → great_keep_going

### 功能卡片
- `冥想练习` → meditation_practice
- `通过星座冥想，找到内心的平静` → meditation_subtitle
- `情绪管理` → emotion_management
- `了解你的情绪，学会与自己相处` → emotion_subtitle
- `每日心语` → daily_quotes
- `来自星座的治愈能量` → quotes_subtitle
- `疗愈音乐` → healing_music
- `放松身心的星座音频` → music_subtitle

---

## 3. meditation_page.dart (冥想练习)

### 页面元素
- `冥想练习` → meditation_practice
- `选择时长，开始冥想` → select_duration_start
- `深呼吸，放松身心...` → breathe_relax
- `选择冥想时长` → select_meditation_duration
- `{x}分钟` → x_minutes (5/10/15/20)
- `开始冥想` → start_meditation
- `停止冥想` → stop_meditation
- `✅ 冥想记录已保存` → meditation_saved
- `星座冥想` → astro_meditation
- `完成了{x}分钟冥想练习` → completed_x_minutes

---

## 4. emotion_diary_page.dart (情绪日记)

### 页面元素
- `情绪日记` → emotion_diary
- `保存` → save
- `此刻的情绪` → current_emotion
- `记录你的感受` → record_your_feelings
- `写下此刻的感受...` → write_feelings_hint
- `每一种情绪都值得被看见和记录` → every_emotion_matters
- `请写下你的感受` → please_write_feelings
- `✅ 情绪日记已保存` → emotion_diary_saved
- `保存失败: {error}` → save_failed

### 情绪类型
- `😊 开心` → happy
- `😢 难过` → sad
- `😠 愤怒` → angry
- `😰 焦虑` → anxious
- `😌 平静` → calm
- `😴 疲惫` → tired

### 提示文字
- `接纳当下的自己，情绪如同星辰流转，终将归于平静` → emotion_tip

---

## 5. daily_quotes_page.dart (每日心语)

### 页面元素
- `每日心语` → daily_quotes
- `暂无心语记录` → no_quotes
- `心灵成长` → spiritual_growth (默认分类)

---

## 6. healing_music_page.dart (疗愈音乐)

### 页面元素
- `疗愈音乐` → healing_music
- `暂无音频` → no_audio
- `{x} 分钟` → x_minutes
- `疗愈` → healing (默认分类)

### 音频分类
- `冥想` → meditation
- `放松` → relaxation
- `睡眠` → sleep
- `能量` → energy
- `情绪` → emotion

---

## 7. daily_status_dialog.dart (每日状态)

### 页面元素
- `记录今日状态` → record_daily_status
- `心情` → mood
- `能量` → energy
- `压力` → stress
- `记录` → notes
- `保存` → save
- `✅ 状态已保存` → status_saved

---

## 8. statistics_page.dart (统计页面)

### 页面标题
- `我的统计` → my_statistics

### 统计项
- `冥想练习` → meditation_practice
- `总时长` → total_duration
- `{x} 小时` → x_hours
- `练习次数` → practice_count
- `{x} 次` → x_times
- `距离30天目标还有 {x} 次` → days_to_30_goal

### 情绪分析
- `情绪分析` → emotion_analysis
- `平均心情` → average_mood
- `记录天数` → recorded_days
- `{x} 天` → x_days
- `情绪分布` → emotion_distribution

### 每日状态
- `每日状态` → daily_status
- `能量指数` → energy_index
- `压力指数` → stress_index
- `连续记录 {x} 天！` → streak_x_days
- `坚持就是胜利，继续加油 ✨` → keep_it_up

---

## 9. persona.dart (个人页面 - 疗愈统计)

### 统计概览
- `疗愈数据` → healing_data
- `查看详情` → view_details
- `冥想次数` → meditation_count
- `情绪记录` → emotion_records
- `平均心情` → average_mood

---

## 10. healing_database.dart (数据库预置数据)

### 每日心语
- `今天的你，闪耀如星` → quote_1
- `相信自己，如同相信星座的指引` → quote_2
- `每个人都是独一无二的星座组合` → quote_3
- `宇宙的能量与你同在` → quote_4
- `接纳当下的自己，你已经很好了` → quote_5
- `每一种情绪都值得被看见` → quote_6
- `深呼吸，让星辰的力量流经你的身体` → quote_7
- `今天是崭新的一天，充满无限可能` → quote_8
- `你的存在本身就是一种奇迹` → quote_9
- `在宁静中寻找内心的答案` → quote_10

### 疗愈音频
- `星空冥想曲` → audio_1_title
- `在宁静的星空下，找到内心的平静` → audio_1_desc
- `白羊座能量音频` → audio_2_title
- `激发你内在的勇气与活力` → audio_2_desc
- `深度放松引导` → audio_3_title
- `释放压力，让身心完全放松` → audio_3_desc
- `情绪平衡音乐` → audio_4_title
- `平衡情绪，找回内心的和谐` → audio_4_desc

---

## 总计
- **约 100+ 个文本** 需要添加到国际化文件
- 涉及文件：9 个 Dart 文件
- 语言：需要支持所有已有语言（en, zh_CN, ja, ko, es, fr, de, it, pt, ru, th 等）

