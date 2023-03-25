import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/services/mail_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MailDialog extends StatelessWidget {
  const MailDialog({Key? key, required this.initialMails}) : super(key: key);
  final List<String> initialMails;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MailController(initialMails),
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.white.withOpacity(1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.7,
              maxWidth: Get.height * 0.8,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                    left: 25,
                    top: 22,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 30,
                      left: 30,
                      bottom: 20,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        TextField(
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          controller: controller.mailController,
                          decoration: InputDecoration(
                            prefixIcon: Text(
                              "To : ",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: controller.subjectController,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          decoration:
                          const InputDecoration(hintText: 'Subject'),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Type the message...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Obx(() => _footer(controller)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _footer(MailController controller) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                controller.sendMail();
              },
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                ),
                fixedSize: const MaterialStatePropertyAll(Size(100, 40)),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              child: controller.isLoading.value
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                ),
              )
                  : const Text(
                "Send now",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MailController extends GetxController {
  final List<String> initialEmails;

  late final TextEditingController mailController;
  late final TextEditingController subjectController;
  late final TextEditingController messageController;

  late final RxBool isLoading;

  MailController(this.initialEmails);

  @override
  void onInit() {
    mailController = TextEditingController(text: initialEmails.join(', '));
    subjectController = TextEditingController();
    messageController = TextEditingController();
    isLoading = RxBool(false);
    super.onInit();
  }

  void sendMail() async {
    isLoading.value = true;
    var addresses = mailController.text.split(', ').toList();
    var response = await Get.find<MailService>()
        .sendMail(addresses, subjectController.text, messageController.text);
    (response);
    isLoading.value = false;
    Get.back();
  }
}
