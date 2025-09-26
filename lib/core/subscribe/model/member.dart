enum MemberType {
  none(_noneName),
  plus(_plusName);

  static const _noneName = 'NONE';
  static const _clubName = 'CLUB';
  static const _plusName = 'PLUS';

  const MemberType(this.name);
  final String name;

  factory MemberType.fromString(String? t) {
    return switch (t) { _plusName => plus, _ => none };
  }
}
