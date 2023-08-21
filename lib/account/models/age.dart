extension DateTimeExt on DateTime {
  int toAge() {
    final now = DateTime.now();
    if (isAfter(now)) return -1;

    int age;

    age = now.year - year;
    if (now.month < month) {
      age = age - 1;
    } else if (now.month == month && now.day < day) {
      age = age - 1;
    }
    return age;
  }

  String toBirthdayString() {
    return '$year-$month-$day';
  }
}