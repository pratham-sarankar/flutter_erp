import 'package:get/get.dart';
import 'package:rrule/rrule.dart';

class RRuleService extends GetxService {
  late RruleL10n l10n;
  Future<RRuleService> init() async {
    l10n = await RruleL10nEn.create();
    return this;
  }

  String generateReadableText(RecurrenceRule rule) {
    return rule.toText(l10n: l10n);
  }
}
