library anis_test_widgets;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_api/scaffolding.dart' as test_package;
import 'package:meta/meta.dart';

part 'anis_widget_tester.dart';
part 'task_manager.dart';

@isTest
void anisTestWidgets(
  String description,
  AnisWidgetTesterCallback callback, {
  bool? skip,
  test_package.Timeout? timeout,
  bool semanticsEnabled = true,
  TestVariant<Object?> variant = const DefaultTestVariant(),
  dynamic tags,
  int? retry,
}) {
  final taskManager = TimeTaskManager();

  testWidgets(
    description,
    (tester) async {
      await callback(
        AnisWidgetTester(
          widgetTester: tester,
          task: taskManager,
        ),
        taskManager,
      );
      await tester.pump(taskManager._resetTotal());
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: tags,
    retry: retry,
  );
}
