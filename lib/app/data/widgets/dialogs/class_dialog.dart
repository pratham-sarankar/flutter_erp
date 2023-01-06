import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_dialog.dart';
import 'package:flutter_erp/app/data/widgets/plus_widgets/plus_form_field.dart';
import 'package:flutter_erp/app/modules/class/controllers/class_dialog_controller.dart';
import 'package:get/get.dart';

class ClassDialog extends GetWidget<ClassDialogController> {
  const ClassDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErpDialog(
      title: "Add Class",
      onSave: () {
        controller.save();
      },
      onCancel: () {
        Get.back();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.8,
            child: Text(
              "Profile Photo",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: context.theme.colorScheme.onBackground,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() => _imageButton(context)),
          const SizedBox(height: 30),
          Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _formFields(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formFields(BuildContext context) {
    return Column(
      children: [
        PlusFormField(
          title: "Title",
          type: TextInputType.name,
          initialText: controller.model.title,
          onSaved: (value) {
            controller.model.title = value;
          },
        ),
        const SizedBox(height: 20),
        PlusFormField(
          title: "Description",
          type: TextInputType.multiline,
          initialText: controller.model.description,
          onSaved: (value) {
            controller.model.title = value;
          },
        ),
        const SizedBox(height: 20),
        PlusFormField(
          title: "Price",
          type: TextInputType.number,
          initialText: (controller.model.price ?? "").toString(),
          onSaved: (value) {
            controller.model.title = value;
          },
        ),
      ],
    );
  }

  Widget _imageButton(BuildContext context) {
    if (controller.image != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: MemoryImage(controller.image!),
                fit: BoxFit.cover,
              ),
            ),
            child: controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2),
                  )
                : null,
          ),
          Positioned(
            top: -10,
            right: -20,
            child: TextButton(
              onPressed: () {
                controller.model.photoUrl = null;
              },
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                fixedSize: MaterialStatePropertyAll(Size(20, 20)),
              ),
              child: const Icon(Icons.clear, size: 16),
            ),
          )
        ],
      );
    }
    return TextButton(
      onPressed: () {
        controller.updateImage();
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size(150, 120)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return context.theme.primaryColorDark.withOpacity(0.8);
          }
          return context.theme.primaryColorDark;
        }),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: controller.isLoading.isTrue
          ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
          : const Icon(
              CupertinoIcons.camera_circle_fill,
              size: 60,
              color: Colors.white,
            ),
    );
  }
}
