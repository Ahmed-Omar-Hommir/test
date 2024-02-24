part of anis_test_widgets;

class TimeTaskManager {
  Duration _totalDuration = Duration.zero;

  Task<void> take(Duration duration) {
    _totalDuration += duration;
    return Task(() => Future.delayed(duration));
  }

  Duration _deduct(Duration duration) {
    _totalDuration -= duration;
    return duration;
  }

  Duration _resetTotal() {
    final currentDuration = _totalDuration;
    _totalDuration -= Duration.zero;
    return currentDuration;
  }
}
