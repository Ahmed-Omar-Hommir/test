part of anis_test_widgets;

typedef AnisWidgetTesterCallback = Future<void> Function(
  AnisWidgetTester tester,
  TimeTaskManager durMan,
);

class AnisWidgetTester {
  const AnisWidgetTester({
    required WidgetTester widgetTester,
    required TimeTaskManager task,
  })  : _widgetTester = widgetTester,
        _task = task;

  final WidgetTester _widgetTester;
  final TimeTaskManager _task;

  Future<void> tap(
    FinderBase<Element> finder, {
    int? pointer,
    int buttons = kPrimaryButton,
    bool warnIfMissed = true,
  }) {
    return _widgetTester.tap(finder);
  }

  Future<void> pump([
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) async {
    if (duration != null) {
      _task._deduct(duration);
    }
    await _widgetTester.pump(duration, phase);
  }

  Future<void> pumpAndSettle([
    Duration duration = const Duration(milliseconds: 100),
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
    Duration timeout = const Duration(minutes: 10),
  ]) async {
    _task._deduct(duration);
    await _widgetTester.pumpAndSettle(duration, phase, timeout);
  }

  Future<void> pumpWidget(
    Widget widget, [
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) async {
    await _widgetTester.pumpWidget(widget, duration, phase);
  }
}
