import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_manager/data/utils/extensions/validator_extension.dart';
import 'package:rrule/rrule.dart';
import 'package:flutter/material.dart';

class ErpRecurringFormField extends FormField<RecurrenceRule?> {
  final String title;
  final String? Function(String?)? onValidate;
  final bool isRequired;

  ErpRecurringFormField({
    super.key,
    required this.title,
    this.isRequired = false,
    this.onValidate,
    super.onSaved,
    super.initialValue,
    super.enabled,
    super.autovalidateMode,
  }) : super(
          builder: (state) {
            return _RecurringFormField(
              state: state,
              title: title,
              isRequired: isRequired,
            );
          },
          validator: ValidationBuilder(optional: !isRequired)
              .add(onValidate ?? (value) => null)
              .buildDyn(),
        );
}

class _RecurringFormField extends StatefulWidget {
  const _RecurringFormField({
    Key? key,
    required this.title,
    required this.state,
    this.isRequired = false,
  }) : super(key: key);
  final String? title;
  final FormFieldState<RecurrenceRule?> state;
  final bool isRequired;

  @override
  State<_RecurringFormField> createState() => _RecurringFormFieldState();
}

class _RecurringFormFieldState extends State<_RecurringFormField> {
  late Frequency? frequency;
  late Set<ByWeekDayEntry>? byWeekDays;
  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    var rrule = widget.state.value ??
        RecurrenceRule(frequency: Frequency.daily, byWeekDays: const {});
    frequency = rrule.frequency;
    byWeekDays = rrule.byWeekDays;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Opacity(
              opacity: 0.8,
              child: Text(
                widget.title ?? "",
                style: Get.context!.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Get.context!.theme.colorScheme.onBackground,
                ),
              ),
            ),
            const SizedBox(width: 4),
            if (widget.isRequired)
              Text(
                "*",
                style: Get.context!.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                  height: 1,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<Frequency?>(
            onChanged: (dynamic newValue) {
              changeState(newValue, byWeekDays);
            },
            value: frequency,
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text(
                  "Select Frequency",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              ...<Frequency>[
                Frequency.daily,
                Frequency.weekly,
                Frequency.monthly,
                Frequency.yearly,
              ].map<DropdownMenuItem<Frequency>>((freq) {
                return DropdownMenuItem(
                  value: freq,
                  child: Text(
                    freq.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ],
            buttonStyleData: ButtonStyleData(
              height: 35,
              padding: const EdgeInsets.only(left: 5, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: context.theme.outlinedButtonTheme.style!.side!
                      .resolve({})!.color,
                ),
              ),
              elevation: 0,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              padding: null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 8,
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 40,
            ),
          ),
        ),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              widget.state.errorText!,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: context.theme.errorColor,
              ),
            ),
          ),
        const SizedBox(height: 20),
        if (frequency == Frequency.weekly)
          Column(
            children: [
              Row(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      "On",
                      style: Get.context!.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Get.context!.theme.colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "*",
                    style: Get.context!.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      height: 1,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      weekdays[index],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    value: byWeekDays?.contains(ByWeekDayEntry(index + 1)),
                    onChanged: (value) {
                      if (value ?? false) {
                        byWeekDays?.add(ByWeekDayEntry(index + 1));
                      } else {
                        byWeekDays?.remove(ByWeekDayEntry(index + 1));
                      }
                      changeState(frequency, byWeekDays);
                    },
                  );
                },
              ),
            ],
          ),
      ],
    );
  }

  void changeState(Frequency? frequency, Set<ByWeekDayEntry>? byWeekDays) {
    setState(() {
      this.frequency = frequency;
      this.byWeekDays = byWeekDays;
    });
    var rrule = RecurrenceRule(
      frequency: frequency ?? Frequency.daily,
      byWeekDays: byWeekDays ?? {},
    );
    widget.state.didChange(rrule);
  }
}

extension FrequencyExtension on Frequency {
  String get title {
    if (this == Frequency.daily) {
      return "Daily";
    } else if (this == Frequency.weekly) {
      return "Weekly";
    } else if (this == Frequency.monthly) {
      return "Monthly";
    } else if (this == Frequency.yearly) {
      return "Yearly";
    }
    throw UnimplementedError();
  }
}
