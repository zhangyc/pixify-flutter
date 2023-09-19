enum StatusCode {
  success(0, 'success'),
  systemError(10000, 'system error'),
  invalidToken(10030, 'invalid token'),
  expiredToken(10040, 'expired token'),
  unknown(-1, 'unknown error');

  const StatusCode(this.code, this.desc);

  final int code;
  final String desc;

  factory StatusCode.fromCode(int code) {
    return switch (code) {
      0 => StatusCode.success,
      10000 => StatusCode.systemError,
      10030 => StatusCode.invalidToken,
      10040 => StatusCode.expiredToken,
      _ => StatusCode.unknown
    };
  }
}