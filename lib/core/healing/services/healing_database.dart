import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HealingDatabase {
  static final HealingDatabase instance = HealingDatabase._init();
  static Database? _database;

  HealingDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('healing.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // 每日状态记录（核心表）
    await db.execute('''
      CREATE TABLE daily_status (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL UNIQUE,
        mood_score INTEGER NOT NULL,
        energy_level INTEGER NOT NULL,
        stress_level INTEGER NOT NULL,
        sleep_quality INTEGER,
        note TEXT,
        tags TEXT,
        zodiac_insight TEXT,
        moon_phase TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // 冥想练习记录
    await db.execute('''
      CREATE TABLE meditation_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        duration INTEGER NOT NULL,
        completed_at TEXT NOT NULL
      )
    ''');

    // 情绪日记
    await db.execute('''
      CREATE TABLE emotion_diary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        emotion_type TEXT NOT NULL,
        content TEXT NOT NULL,
        intensity INTEGER NOT NULL,
        triggers TEXT,
        zodiac_influence TEXT,
        planetary_aspect TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // 感恩日记
    await db.execute('''
      CREATE TABLE gratitude_diary (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // 每日心语（预置数据）
    await db.execute('''
      CREATE TABLE daily_quotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        category TEXT NOT NULL,
        is_read INTEGER DEFAULT 0
      )
    ''');

    // 疗愈音频列表
    await db.execute('''
      CREATE TABLE healing_audios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        file_path TEXT NOT NULL,
        duration INTEGER NOT NULL,
        category TEXT,
        play_count INTEGER DEFAULT 0
      )
    ''');

    // 疗愈目标
    await db.execute('''
      CREATE TABLE healing_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        target_days INTEGER NOT NULL,
        completed_days INTEGER DEFAULT 0,
        status TEXT DEFAULT 'active',
        created_at TEXT NOT NULL,
        completed_at TEXT
      )
    ''');

    // 疗愈提醒
    await db.execute('''
      CREATE TABLE healing_reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        time TEXT NOT NULL,
        days_of_week TEXT NOT NULL,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL
      )
    ''');

    // 预置每日心语数据
    await _insertInitialQuotes(db);
    // 预置疗愈音频
    await _insertInitialAudios(db);
  }

  Future<void> _insertInitialAudios(Database db) async {
    final audios = [
      {
        'title': '星空冥想曲',
        'description': '在宁静的星空下，找到内心的平静',
        'file_path': 'healing_1.mp3',
        'duration': 300,
        'category': '冥想'
      },
      {
        'title': '白羊座能量音频',
        'description': '激发你内在的勇气与活力',
        'file_path': 'healing_2.mp3',
        'duration': 180,
        'category': '能量'
      },
      {
        'title': '深度放松引导',
        'description': '释放压力，让身心完全放松',
        'file_path': 'healing_3.mp3',
        'duration': 420,
        'category': '放松'
      },
      {
        'title': '情绪平衡音乐',
        'description': '平衡情绪，找回内心的和谐',
        'file_path': 'healing_4.mp3',
        'duration': 360,
        'category': '情绪'
      },
    ];

    for (var audio in audios) {
      await db.insert('healing_audios', audio);
    }
  }

  Future<void> _insertInitialQuotes(Database db) async {
    final quotes = [
      {'content': '今天的你，闪耀如星', 'category': '鼓励'},
      {'content': '相信自己，如同相信星座的指引', 'category': '信心'},
      {'content': '每个人都是独一无二的星座组合', 'category': '个性'},
      {'content': '宇宙的能量与你同在', 'category': '能量'},
      {'content': '接纳当下的自己，你已经很好了', 'category': '接纳'},
      {'content': '每一种情绪都值得被看见', 'category': '情绪'},
      {'content': '深呼吸，让星辰的力量流经你的身体', 'category': '冥想'},
      {'content': '今天是崭新的一天，充满无限可能', 'category': '希望'},
      {'content': '你的存在本身就是一种奇迹', 'category': '肯定'},
      {'content': '在宁静中寻找内心的答案', 'category': '平静'},
    ];

    for (var quote in quotes) {
      await db.insert('daily_quotes', quote);
    }
  }

  // ========== 每日状态相关 ==========
  Future<int> insertDailyStatus(Map<String, dynamic> status) async {
    final db = await database;
    return await db.insert('daily_status', status,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getDailyStatus(String date) async {
    final db = await database;
    final results =
        await db.query('daily_status', where: 'date = ?', whereArgs: [date]);
    return results.isEmpty ? null : results.first;
  }

  Future<List<Map<String, dynamic>>> getDailyStatusByRange(
      String startDate, String endDate) async {
    final db = await database;
    return await db.query(
      'daily_status',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date DESC',
    );
  }

  // ========== 冥想记录相关 ==========
  Future<int> insertMeditationRecord(Map<String, dynamic> record) async {
    final db = await database;
    return await db.insert('meditation_records', record);
  }

  Future<List<Map<String, dynamic>>> getMeditationRecords(
      String startDate, String endDate) async {
    final db = await database;
    return await db.query('meditation_records',
        where: 'date BETWEEN ? AND ?',
        whereArgs: [startDate, endDate],
        orderBy: 'completed_at DESC');
  }

  Future<int> getMeditationCount(String date) async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM meditation_records WHERE date = ?',
        [date]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ========== 情绪日记相关 ==========
  Future<int> insertEmotionDiary(Map<String, dynamic> diary) async {
    final db = await database;
    return await db.insert('emotion_diary', diary);
  }

  Future<List<Map<String, dynamic>>> getEmotionDiary({String? date}) async {
    final db = await database;
    if (date != null) {
      return await db.query('emotion_diary',
          where: 'date = ?', whereArgs: [date], orderBy: 'created_at DESC');
    }
    return await db.query('emotion_diary',
        orderBy: 'created_at DESC', limit: 50);
  }

  // ========== 感恩日记相关 ==========
  Future<int> insertGratitudeDiary(Map<String, dynamic> diary) async {
    final db = await database;
    return await db.insert('gratitude_diary', diary);
  }

  Future<List<Map<String, dynamic>>> getGratitudeDiary({String? date}) async {
    final db = await database;
    if (date != null) {
      return await db.query('gratitude_diary',
          where: 'date = ?', whereArgs: [date], orderBy: 'created_at DESC');
    }
    return await db.query('gratitude_diary',
        orderBy: 'created_at DESC', limit: 30);
  }

  // ========== 每日心语相关 ==========
  Future<Map<String, dynamic>?> getTodayQuote() async {
    final db = await database;
    final results = await db.query('daily_quotes',
        where: 'is_read = ?', whereArgs: [0], limit: 1);

    if (results.isEmpty) {
      await db.update('daily_quotes', {'is_read': 0});
      return await getTodayQuote();
    }

    return results.first;
  }

  Future<void> markQuoteAsRead(int id) async {
    final db = await database;
    await db.update('daily_quotes', {'is_read': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getDailyQuotes() async {
    final db = await database;
    return await db.query('daily_quotes', orderBy: 'id DESC');
  }

  // ========== 疗愈音频相关 ==========
  Future<List<Map<String, dynamic>>> getHealingAudios(
      {String? category}) async {
    final db = await database;
    if (category != null) {
      return await db.query('healing_audios',
          where: 'category = ?', whereArgs: [category]);
    }
    return await db.query('healing_audios');
  }

  Future<void> incrementAudioPlayCount(int id) async {
    final db = await database;
    await db.rawUpdate(
        'UPDATE healing_audios SET play_count = play_count + 1 WHERE id = ?',
        [id]);
  }

  // ========== 疗愈目标相关 ==========
  Future<int> insertHealingGoal(Map<String, dynamic> goal) async {
    final db = await database;
    return await db.insert('healing_goals', goal);
  }

  Future<List<Map<String, dynamic>>> getActiveGoals() async {
    final db = await database;
    return await db.query('healing_goals',
        where: 'status = ?', whereArgs: ['active'], orderBy: 'created_at DESC');
  }

  Future<void> updateGoalProgress(int id, int completedDays) async {
    final db = await database;
    await db.update('healing_goals', {'completed_days': completedDays},
        where: 'id = ?', whereArgs: [id]);
  }

  // ========== 统计分析相关 ==========
  Future<Map<String, dynamic>> getStatistics(
      String startDate, String endDate) async {
    final db = await database;

    // 冥想总时长
    final meditationResult = await db.rawQuery(
        'SELECT SUM(duration) as total, COUNT(*) as count FROM meditation_records WHERE date BETWEEN ? AND ?',
        [startDate, endDate]);

    // 情绪趋势
    final emotionResult = await db.rawQuery(
        'SELECT emotion_type, COUNT(*) as count FROM emotion_diary WHERE date BETWEEN ? AND ? GROUP BY emotion_type',
        [startDate, endDate]);

    // 平均心情分数
    final moodResult = await db.rawQuery(
        'SELECT AVG(mood_score) as avg_mood FROM daily_status WHERE date BETWEEN ? AND ?',
        [startDate, endDate]);

    // 转换情绪分布为 Map
    final emotionDistribution = <String, int>{};
    for (var row in emotionResult) {
      emotionDistribution[row['emotion_type'] as String] = row['count'] as int;
    }

    return {
      'meditation_minutes': meditationResult.first['total'] ?? 0,
      'meditation_count': meditationResult.first['count'] ?? 0,
      'emotion_distribution': emotionDistribution,
      'avg_mood': moodResult.first['avg_mood'] ?? 0.0,
    };
  }

  // ========== 星座洞察相关 ==========
  /// 获取今日星座建议（基于月相和星座）
  String getTodayZodiacInsight(String sunSign, String moonPhase) {
    final insights = {
      'new_moon': {
        '白羊座': '新月能量适合开启新计划，调动你的行动力',
        '金牛座': '新月时刻，专注于物质和情感的稳定',
        '双子座': '新月带来沟通机会，是学习新知的好时机',
        '巨蟹座': '新月激活情感，关注内心需求',
        '狮子座': '新月能量强化自信，展现你的光芒',
        '处女座': '新月适合制定健康计划，关注细节',
        '天秤座': '新月带来和谐，平衡关系很重要',
        '天蝎座': '新月深化情感，探索内在力量',
        '射手座': '新月激发冒险精神，拓展视野',
        '摩羯座': '新月助力目标达成，脚踏实地',
        '水瓶座': '新月带来创新，独立思考',
        '双鱼座': '新月增强直觉，倾听内心声音',
      },
      'full_moon': {
        '白羊座': '满月释放能量，平衡冲动与理性',
        '金牛座': '满月显化丰盛，感恩拥有',
        '双子座': '满月促进交流，分享想法',
        '巨蟹座': '满月情绪高峰，温柔对待自己',
        '狮子座': '满月照亮舞台，自信表达',
        '处女座': '满月收获成果，完善细节',
        '天秤座': '满月平衡关系，和谐共处',
        '天蝎座': '满月转化力量，释放旧有',
        '射手座': '满月拓展视野，追求真理',
        '摩羯座': '满月达成目标，享受成就',
        '水瓶座': '满月突破创新，实现理想',
        '双鱼座': '满月灵性觉醒，梦境启示',
      },
    };

    return insights[moonPhase]?[sunSign] ?? '今天适合静心观察内在';
  }

  /// 获取情绪的星座影响提示
  String getEmotionZodiacInfluence(
      String emotionType, String? planetaryAspect) {
    final influences = {
      '愉悦': '可能受金星能量影响，享受美好时刻',
      '焦虑': '注意水星逆行影响，放慢脚步',
      '愤怒': '火星能量活跃，学会温和表达',
      '悲伤': '月亮相位影响，允许情绪流动',
      '平静': '土星稳定能量，保持内在平和',
      '兴奋': '木星扩张能量，把握机遇',
    };

    return influences[emotionType] ?? '观察情绪，接纳当下';
  }

  // 关闭数据库
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
