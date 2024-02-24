import 'dart:io';

import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:path/path.dart' as p;

class ExportModule extends DartLintRule {
  ExportModule()
      : super(
          code: LintCode(
            name: 'export_module',
            problemMessage: 'You must export from the src folder directly.',
            errorSeverity: ErrorSeverity.ERROR,
          ),
        );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addExportDirective(
      (node) {
        final stringValue = node.uri.stringValue;
        if (stringValue == null) return;

        String path = Uri.parse(stringValue).path;

        // Check is module export
        final dir = p.dirname(resolver.path);
        final file = File(p.join(dir, 'module.yaml'));
        if (!file.existsSync()) return;

        if (!(path.startsWith("./src/") || path.startsWith("src/"))) {
          reporter.reportErrorForNode(
            super.code,
            node.uri,
          );
          return;
        }

        path = path.replaceFirst(RegExp(r'^(./)?src/'), '');

        if (path.contains('/src/') || path.startsWith('src/')) {
          reporter.reportErrorForNode(
            super.code,
            node.uri,
          );
        }
      },
    );
  }
}
