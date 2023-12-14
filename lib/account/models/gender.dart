import '../../generated/l10n.dart';

const _male = 1;
const _female = 2;
const _nonBinary = 3;

class Gender {
  const Gender._({required this.index, required this.name});
  final int index;
  final String name;

  static final male = Gender._(index: _male, name: S.current.userGenderOptionMale);
  static final female = Gender._(index: _female, name: S.current.userGenderOptionFemale);
  static final nonBinary = Gender._(index: _nonBinary, name: S.current.userGenderOptionNonBinary);

  static final allTypes = [male, female, nonBinary];

  factory Gender.fromIndex(int index) {
    return switch(index) {
      _male => male,
      _female => female,
      _nonBinary => nonBinary,
      _ => throw('Invalid gender index: $index')
    };
  }
}