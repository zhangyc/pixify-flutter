import '../../generated/l10n.dart';

const _male = 1;
const _female = 2;
const _nonBinary = 3;

class Gender {
  const Gender._({required this.index, required this.name});
  final int index;
  final String name;

  String get displayName => switch(index) {
    _male => S.current.userGenderOptionMale,
    _female => S.current.userGenderOptionFemale,
    _nonBinary => S.current.userGenderOptionNonBinary,
    _ => throw('Invalid gender index: $index')
  };

  static const male = Gender._(index: _male, name: 'Male');
  static const female = Gender._(index: _female, name: 'Female');
  static const nonBinary = Gender._(index: _nonBinary, name: 'Non-binary');

  static const allTypes = [male, female, nonBinary];

  factory Gender.fromIndex(int index) {

    return switch(index) {
      _male => male,
      _female => female,
      _nonBinary => nonBinary,
      _ => throw('Invalid gender index: $index')
    };
  }
}