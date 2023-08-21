class Gender {
  const Gender._({required this.index, required this.name});
  final int index;
  final String name;

  static const male = Gender._(index: 1, name: 'Male');
  static const female = Gender._(index: 2, name: 'Female');

  factory Gender.fromIndex(int index) {
    if (index == male.index) {
      return male;
    } else if (index == female.index) {
      return female;
    } else {
      throw('Invalid gender $index');
    }
  }
}