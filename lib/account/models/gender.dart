enum Gender {
  male(1, 'Male'),
  female(2, 'Female');

  const Gender(this.value, this.label);
  final int value;
  final String label;

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