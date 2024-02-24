import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ImportModule extends DartLintRule {
  ImportModule()
      : super(
          code: LintCode(
            name: 'import_module',
            problemMessage:
                'It is not possible to import from the src folder directly.',
            errorSeverity: ErrorSeverity.ERROR,
          ),
        );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addImportDirective(
      (node) {
        if (node.uri.stringValue == null) return;
        if (node.uri.stringValue!.contains('/src/') ||
            node.uri.stringValue!.startsWith('src')) {
          reporter.reportErrorForNode(
            super.code,
            node.uri,
          );
        }
      },
    );
  }
}
