import 'dart:core';

enum AstrolabeColorType {
  ASTRO_NIGHT_SKY, //夜空
  ASTRO_DEEP_BLUE, //深蓝
  ASTRO_LIGHT_BLUE, //浅蓝
  ASTRO_PINK, //粉色
  ASTRO_BLUE_WHITE, //蓝白
  ASTRO_GRAY, //灰色
}

enum AstrolabeDataType {
  ASTROLABE, //本命盘
  TXASTROLABE, //天象盘
  CXASTROLABE, //次限盘
  XYASTROLABE, //行运盘
  SXASTROLABE, //三限盘
  YFASTROLABE, //月返盘
  RFASTROLABE, //日返盘
  RHASTROLABE, //日弧盘
  FDASTROLABE, //法达盘
}

/**
 * 星盘参数类型
 */
enum AstrolabeParamType {
  PARAMS_TYPE_ASTROBALE("astrolabe"), //本命盘/天象盘 现代参数类型
  PARAMS_TYPE_ASTROBALE_CLASSICAL("astrolabe_classical"), //本命盘/天象盘 古典参数类型
  PARAMS_TYPE_XYASTROBALE("transit"), //行运盘 现代参数类型
  PARAMS_TYPE_XYASTROBALE_CLASSICAL("transit_classical"), //行运盘 古典参数类型
  PARAMS_TYPE_CXASTROLABE("secondary_prog"), //次限盘现代
  PARAMS_TYPE_CXASTROLABE_CLASSICAL("secondary_prog_classical"), //次限盘古典
  PARAMS_TYPE_SXASTROLABE("tertiary_prog"), //三线盘现代
  PARAMS_TYPE_SXASTROLABE_CLASSICAL("tertiary_prog_classical"), //三线盘古典
  PARAMS_TYPE_YFASTROLABE("lunar_return"), //月返现代
  PARAMS_TYPE_YFASTROLABE_CLASSICAL("lunar_return_classical"), //月返古典
  PARAMS_TYPE_RFASTROLABE("solar_return"), //日返现代
  PARAMS_TYPE_RFASTROLABE_CLASSICAL("solar_return_classical"), //日返古典
  PARAMS_TYPE_RHASTROLABE("solar_arc"), //日弧现代
  PARAMS_TYPE_RHASTROLABE_CLASSICAL("solar_arc_classical"), //日弧古典
  PARAMS_TYPE_FDASTROLABE("firdaria"), //法达现代
  PARAMS_TYPE_FDASTROLABE_CLASSICAL("firdaria_classical"); //法达古典

  final String value;

  const AstrolabeParamType(this.value);
}
