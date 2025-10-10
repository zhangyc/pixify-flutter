import 'dart:ui';

class AstrolabeData {
  List<Houses>? houses;
  Info? info;
  List<Labels>? labels;
  List<NewExplain>? newExplain;
  List<Phase>? phase;
  List<Planets>? planets;

  List<Planets>? planetsInner;
  List<Planets>? planetsOuter;

  AstrolabeData({
    this.houses,
    this.info,
    this.labels,
    this.newExplain,
    this.phase,
    this.planets,
  });

  AstrolabeData.fromJson(Map<String, dynamic> json) {
    if (json['houses'] != null) {
      houses = <Houses>[];
      json['houses'].forEach((v) {
        houses!.add(new Houses.fromJson(v));
      });
    }
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels!.add(new Labels.fromJson(v));
      });
    }
    if (json['new_explain'] != null) {
      newExplain = <NewExplain>[];
      json['new_explain'].forEach((v) {
        newExplain!.add(new NewExplain.fromJson(v));
      });
    }
    if (json['phase'] != null) {
      phase = <Phase>[];
      json['phase'].forEach((v) {
        phase!.add(new Phase.fromJson(v));
      });
    }
    // 兼容不同接口返回格式
    if (json['planets'] != null) {
      planets = <Planets>[];
      json['planets'].forEach((v) {
        planets!.add(Planets.fromJson(v));
      });
    }

    // 行运盘等返回 planets1 / planets2
    if (json['planets1'] != null) {
      planetsInner = <Planets>[];
      json['planets1'].forEach((v) {
        final p = Planets.fromJson(v);
        p.flag ??= 'inner'; // 标记为外圈 （内圈为默认）
        planetsInner!.add(p);
      });
    }
    if (json['planets2'] != null) {
      planetsOuter = <Planets>[];
      json['planets2'].forEach((v) {
        final p = Planets.fromJson(v);
        p.flag ??= 'outer';
        planetsOuter!.add(p);
      });
      // 若 planets 为空，则把 planets2 作为默认 planets（内圈）
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.houses != null) {
      data['houses'] = this.houses!.map((v) => v.toJson()).toList();
    }
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.labels != null) {
      data['labels'] = this.labels!.map((v) => v.toJson()).toList();
    }
    if (this.newExplain != null) {
      data['new_explain'] = this.newExplain!.map((v) => v.toJson()).toList();
    }
    if (this.phase != null) {
      data['phase'] = this.phase!.map((v) => v.toJson()).toList();
    }
    if (planets != null) {
      data['planets'] = planets!.map((v) => v.toJson()).toList();
    }
    if (planetsInner != null) {
      data['planets1'] = planetsInner!.map((v) => v.toJson()).toList();
    }
    if (planetsOuter != null) {
      data['planets2'] = planetsOuter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Houses {
  String? constellationCn;
  String? deg;
  String? degrees;
  String? houseName;
  String? min;
  List<Rulers>? rulers;
  String? sec;

  // ------- 以下字段为绘制星盘临时计算所得，不参与 JSON 序列化 -------
  double? houseInitAngle; // 宫位起始角度
  Offset? houseStartPoint; // 宫位分割线起点
  double? houseTextInitAngle; // 宫位文字角度
  Offset? houseTextPoint; // 宫位文字坐标

  Houses({
    this.constellationCn,
    this.deg,
    this.degrees,
    this.houseName,
    this.min,
    this.rulers,
    this.sec,
  });

  Houses.fromJson(Map<String, dynamic> json) {
    constellationCn = json['constellation_cn'];
    deg = json['deg'];
    degrees = json['degrees'];
    houseName = json['house_name'];
    min = json['min'];
    if (json['rulers'] != null) {
      rulers = <Rulers>[];
      json['rulers'].forEach((v) {
        rulers!.add(new Rulers.fromJson(v));
      });
    }
    sec = json['sec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['constellation_cn'] = this.constellationCn;
    data['deg'] = this.deg;
    data['degrees'] = this.degrees;
    data['house_name'] = this.houseName;
    data['min'] = this.min;
    if (this.rulers != null) {
      data['rulers'] = this.rulers!.map((v) => v.toJson()).toList();
    }
    data['sec'] = this.sec;
    return data;
  }

  copyWith({
    String? constellationCn,
    String? deg,
    String? degrees,
    String? houseName,
    String? min,
  }) {
    return Houses(
      constellationCn: constellationCn ?? this.constellationCn,
      deg: deg ?? this.deg,
      degrees: degrees ?? this.degrees,
      houseName: houseName ?? this.houseName,
    );
  }
}

class Rulers {
  String? constellationCn;
  String? placeOn;
  String? planetsName;

  Rulers({this.constellationCn, this.placeOn, this.planetsName});

  Rulers.fromJson(Map<String, dynamic> json) {
    constellationCn = json['constellation_cn'];
    placeOn = json['place_on'];
    planetsName = json['planets_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['constellation_cn'] = this.constellationCn;
    data['place_on'] = this.placeOn;
    data['planets_name'] = this.planetsName;
    return data;
  }
}

class Info {
  String? archivesId;
  String? birthPlace;
  String? birthday;
  String? livePlace;
  String? name;
  String? sex;

  Info({
    this.archivesId,
    this.birthPlace,
    this.birthday,
    this.livePlace,
    this.name,
    this.sex,
  });

  Info.fromJson(Map<String, dynamic> json) {
    archivesId = json['archives_id'];
    birthPlace = json['birth_place'];
    birthday = json['birthday'];
    livePlace = json['live_place'];
    name = json['name'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['archives_id'] = this.archivesId;
    data['birth_place'] = this.birthPlace;
    data['birthday'] = this.birthday;
    data['live_place'] = this.livePlace;
    data['name'] = this.name;
    data['sex'] = this.sex;
    return data;
  }
}

class Labels {
  String? constellationCn;
  String? deg;
  String? degrees;
  String? explain;
  String? flag;
  String? imgCn;
  int? isShow;
  String? label;
  String? min;
  String? placeOn;
  String? planetCn;
  int? reversion;
  String? sec;
  String? shortPlanetCn;

  Labels({
    this.constellationCn,
    this.deg,
    this.degrees,
    this.explain,
    this.flag,
    this.imgCn,
    this.isShow,
    this.label,
    this.min,
    this.placeOn,
    this.planetCn,
    this.reversion,
    this.sec,
    this.shortPlanetCn,
  });

  Labels.fromJson(Map<String, dynamic> json) {
    constellationCn = json['constellation_cn'];
    deg = json['deg'];
    degrees = json['degrees'];
    explain = json['explain'];
    flag = json['flag'];
    imgCn = json['img_cn'];
    isShow = json['is_show'];
    label = json['label'];
    min = json['min'];
    placeOn = json['place_on'];
    planetCn = json['planet_cn'];
    reversion = json['reversion'];
    sec = json['sec'];
    shortPlanetCn = json['short_planet_cn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['constellation_cn'] = this.constellationCn;
    data['deg'] = this.deg;
    data['degrees'] = this.degrees;
    data['explain'] = this.explain;
    data['flag'] = this.flag;
    data['img_cn'] = this.imgCn;
    data['is_show'] = this.isShow;
    data['label'] = this.label;
    data['min'] = this.min;
    data['place_on'] = this.placeOn;
    data['planet_cn'] = this.planetCn;
    data['reversion'] = this.reversion;
    data['sec'] = this.sec;
    data['short_planet_cn'] = this.shortPlanetCn;
    return data;
  }
}

class NewExplain {
  List<PhaseExplain>? phaseExplain;
  PhaseExplain? planetExplain;
  String? planetImgUrl;
  String? planetName;
  String? title;
  String? reversionExplain;

  NewExplain({
    this.phaseExplain,
    this.planetExplain,
    this.planetImgUrl,
    this.planetName,
    this.title,
    this.reversionExplain,
  });

  NewExplain.fromJson(Map<String, dynamic> json) {
    if (json['phase_explain'] != null) {
      phaseExplain = <PhaseExplain>[];
      json['phase_explain'].forEach((v) {
        phaseExplain!.add(new PhaseExplain.fromJson(v));
      });
    }
    planetExplain = json['planet_explain'] != null
        ? new PhaseExplain.fromJson(json['planet_explain'])
        : null;
    planetImgUrl = json['planet_imgUrl'];
    planetName = json['planet_name'];
    title = json['title'];
    reversionExplain = json['reversion_explain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.phaseExplain != null) {
      data['phase_explain'] =
          this.phaseExplain!.map((v) => v.toJson()).toList();
    }
    if (this.planetExplain != null) {
      data['planet_explain'] = this.planetExplain!.toJson();
    }
    data['planet_imgUrl'] = this.planetImgUrl;
    data['planet_name'] = this.planetName;
    data['title'] = this.title;
    data['reversion_explain'] = this.reversionExplain;
    return data;
  }
}

class PhaseExplain {
  String? content;
  String? title;

  PhaseExplain({this.content, this.title});

  PhaseExplain.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['title'] = this.title;
    return data;
  }
}

class Phase {
  String? aspectName;
  String? bgColor;
  String? direction;
  int? isShow; // is_show : 1
  String? orb;
  String? planetName1;
  String? planetName2;

  Phase({
    this.aspectName,
    this.bgColor,
    this.direction,
    this.isShow,
    this.orb,
    this.planetName1,
    this.planetName2,
  });

  Phase.fromJson(Map<String, dynamic> json) {
    aspectName = json['aspect_name'];
    bgColor = json['bg_color'];
    direction = json['direction'];
    isShow = json['is_show'];
    orb = json['orb'];
    planetName1 = json['planet_name_1'];
    planetName2 = json['planet_name_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_name'] = this.aspectName;
    data['bg_color'] = this.bgColor;
    data['direction'] = this.direction;
    data['is_show'] = this.isShow;
    data['orb'] = this.orb;
    data['planet_name_1'] = this.planetName1;
    data['planet_name_2'] = this.planetName2;
    return data;
  }
}

class Planets {
  String? constellationCn;
  String? deg;
  String? degrees;
  String? flag;
  int? isShow;
  String? min;
  String? placeOn;
  String? planetCn;
  int? reversion;
  String? sec;
  String? shortPlanetCn;

  // ------- 绘制用临时字段 -------
  double? planetAngle; // 行星角度
  Offset? planetPoint; // 行星坐标
  double? planetTextAngle; // 文字角度
  Offset? planetTextPoint; // 文字坐标
  Offset? planetTextLineEndPoint; // 文字与行星连线末端
  Offset? planetTextLineStartPoint; // 文字与行星连线起点

  Planets({
    this.constellationCn,
    this.deg,
    this.degrees,
    this.flag,
    this.isShow,
    this.min,
    this.placeOn,
    this.planetCn,
    this.reversion,
    this.sec,
    this.shortPlanetCn,
  });

  Planets.fromJson(Map<String, dynamic> json) {
    constellationCn = json['constellation_cn'];
    deg = json['deg'];
    degrees = json['degrees'];
    flag = json['flag'];
    isShow = json['is_show'];
    min = json['min'];
    placeOn = json['place_on'];
    planetCn = json['planet_cn'];
    reversion = json['reversion'];
    sec = json['sec'];
    shortPlanetCn = json['short_planet_cn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['constellation_cn'] = this.constellationCn;
    data['deg'] = this.deg;
    data['degrees'] = this.degrees;
    data['flag'] = this.flag;
    data['is_show'] = this.isShow;
    data['min'] = this.min;
    data['place_on'] = this.placeOn;
    data['planet_cn'] = this.planetCn;
    data['reversion'] = this.reversion;
    data['sec'] = this.sec;
    data['short_planet_cn'] = this.shortPlanetCn;
    return data;
  }
}

class StarInfoBean {
  String starName; // 星座两字简称
  double starAngle; // 星座分区起始刻度的角度
  Offset? starTextPoint; // 星座文字的坐标点
  double statTextAngle; // 星座文字的角度

  StarInfoBean({
    required this.starName,
    required this.starAngle,
    this.starTextPoint,
    required this.statTextAngle,
  });

  // 用于深拷贝
  StarInfoBean copyWith({
    String? starName,
    double? starAngle,
    Offset? starTextPoint,
    double? statTextAngle,
  }) {
    return StarInfoBean(
      starName: starName ?? this.starName,
      starAngle: starAngle ?? this.starAngle,
      starTextPoint: starTextPoint ?? this.starTextPoint,
      statTextAngle: statTextAngle ?? this.statTextAngle,
    );
  }
}
