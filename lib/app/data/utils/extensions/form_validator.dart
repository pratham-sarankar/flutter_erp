import 'package:form_validator/form_validator.dart';

extension ValidationBuilderExtension on ValidationBuilder {
  String? Function(dynamic) buildDyn() {
    return (value) {
      return test(value?.toString());
    };
  }
}
