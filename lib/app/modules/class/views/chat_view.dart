import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/class/controllers/chat_controller.dart';
import 'package:flutter_erp/widgets/dialogs/mail_dialog.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state == null) {
          return const Center(child: Text("No Data"));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Members (${state.length})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'These customer have active subscription of this class',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 1,
                          color: Colors.grey.shade700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextButton(
                            child: Row(
                              children: [
                                Icon(
                                  controller.canSelectAll.value
                                      ? Icons.select_all_rounded
                                      : Icons.deselect_rounded,
                                  size: 16,
                                ),
                                const SizedBox(width: 5),
                                Text(controller.canSelectAll.value
                                    ? "Select All"
                                    : "Deselect All"),
                              ],
                            ),
                            onPressed: () {
                              if (controller.canSelectAll.value) {
                                controller.selectAll();
                              } else {
                                controller.deSelectAll();
                              }
                            },
                          ),
                        ),
                        if (controller.canMail.value)
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextButton(
                              child: Row(
                                children: const [
                                  Icon(
                                    CupertinoIcons.mail,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Mail"),
                                ],
                              ),
                              onPressed: () async {
                                var emails = controller.selectedList
                                    .map(
                                      (subscription) {
                                        return subscription.customer?.email;
                                      },
                                    )
                                    .toSet()
                                    .toList();
                                emails = emails
                                    .where((element) => element != null)
                                    .toList();
                                await Get.dialog(MailDialog(
                                    initialMails: List<String>.from(emails)));
                              },
                            ),
                          ),
                      ],
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Obx(
                    () => Material(
                      type: MaterialType.transparency,
                      child: ListTile(
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Valid till',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                height: 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('d MMM y').format(
                                state[index].expiringAt!,
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                height: 1,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.selectedList.isNotEmpty)
                              Row(
                                children: [
                                  Checkbox(
                                    value: controller.selectedList
                                        .contains(state[index]),
                                    onChanged: (value) {
                                      controller.select(state[index]);
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            const CircleAvatar(
                              radius: 18,
                            ),
                          ],
                        ),
                        dense: true,
                        horizontalTitleGap: 12,
                        minLeadingWidth: 0,
                        visualDensity: const VisualDensity(vertical: 0.1),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        title: Text(
                          state[index].customer?.name ?? '-',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            height: 1,
                          ),
                        ),
                        subtitle: Text(
                          state[index].package?.name ?? '-',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            height: 1,
                          ),
                        ),
                        onTap: () {
                          controller.select(state[index]);
                        },
                        onLongPress: () {
                          controller.select(state[index]);
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
