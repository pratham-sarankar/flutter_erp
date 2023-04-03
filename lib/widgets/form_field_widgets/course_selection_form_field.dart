import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/class.dart';
import 'package:flutter_erp/app/data/models/course.dart';
import 'package:flutter_erp/app/data/models/package.dart';
import 'package:flutter_erp/app/data/repositories/class_repository.dart';
import 'package:flutter_erp/app/data/repositories/course_repository.dart';
import 'package:flutter_erp/app/data/repositories/package_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseSelectionFormField extends FormField<Course> {
  CourseSelectionFormField(
      {super.key, super.onSaved, super.validator, super.initialValue})
      : super(
          builder: (state) {
            return GetBuilder(
              init: CourseSelectionFieldController(initialValue: initialValue),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Course"),
                    const SizedBox(height: 8),
                    TypeAheadFormField<Course>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller.courseController,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              width: 1,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.only(
                            bottom: 12,
                            top: 12,
                            right: 10,
                            left: 10,
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return await controller.getCourses(pattern);
                      },
                      itemBuilder: (context, Course course) {
                        return ListTile(
                          minVerticalPadding: 0,
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          title: Text(course.name),
                          subtitle:
                              Text(course.description ?? "-", maxLines: 1),
                        );
                      },
                      hideOnEmpty: false,
                      getImmediateSuggestions: true,
                      keepSuggestionsOnLoading: true,
                      hideOnLoading: false,
                      animationStart: 1,
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        elevation: 1,
                        constraints: const BoxConstraints(
                          maxHeight: 300,
                        ),
                      ),
                      noItemsFoundBuilder: (context) {
                        return Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "No courses found",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context) {
                        return Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (Course suggestion) {
                        state.didChange(suggestion);
                        controller.onChanged(suggestion);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a course";
                        }
                        return null;
                      },
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          state.errorText ?? "",
                          style: TextStyle(
                            color: Get.theme.colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      )
                  ],
                );
              },
            );
          },
        );
}

class CourseSelectionFieldController extends GetxController {
  late final TextEditingController courseController;
  final Course? initialValue;

  CourseSelectionFieldController({this.initialValue});

  @override
  void onInit() {
    courseController = TextEditingController(text: initialValue?.title);
    super.onInit();
  }

  Future<List<Course>> getCourses(String pattern) async {
    return await Get.find<CourseRepository>().fetch(
      queries: {
        "search": pattern,
      },
    );
  }

  void onChanged(Course suggestion) {
    courseController.text = suggestion.name;
  }
}
