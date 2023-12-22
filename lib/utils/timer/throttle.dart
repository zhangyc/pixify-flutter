class Throttle {
  final Duration duration;
  DateTime? _lastExecuteTime;

  Throttle(this.duration);

  void run(void Function() action) {
    if (_lastExecuteTime == null ||
        DateTime.now().difference(_lastExecuteTime!) >= duration) {
      action();
      _lastExecuteTime = DateTime.now();
    }
  }
}