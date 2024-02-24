import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'export_module.dart';
import 'import_module.dart';

// Entrypoint of plugin
PluginBase createPlugin() => _CustomRulesPlugin();

class _CustomRulesPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        ImportModule(),
        ExportModule(),
      ];
}
