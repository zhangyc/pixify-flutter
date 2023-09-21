const _male = 1;
const _female = 2;
const _nonBinary = 3;

class Gender {
  const Gender._({required this.index, required this.name});
  final int index;
  final String name;

  static const male = Gender._(index: _male, name: 'Male');
  static const female = Gender._(index: _female, name: 'Female');
  static const all = Gender._(index: _nonBinary, name: 'All');

  static const allTypes = [male, female, all];

  factory Gender.fromIndex(int index) {

    return switch(index) {
      _male => male,
      _female => female,
      _nonBinary => all,
      _ => throw('Invalid gender index: $index')
    };
  }
}