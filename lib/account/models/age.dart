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

  DateTime yearsAgo(int years) {
    if (month == 2 && day == 29) {
      if ((year - years) % 4 == 0) {
        return DateTime(year - years, month, day);
      }
      return DateTime(year - years, month, day - 1);
    }
    return DateTime(year - years, month, day);
  }

  String toBirthdayString() {
    return '$year-$month-$day';
  }
}