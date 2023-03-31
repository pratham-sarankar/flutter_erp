import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/modules/class/controllers/chat_controller.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_search_field.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  ChatController get controller =>
      Get.find<ChatController>(tag: Get.parameters['id']);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      onLoading: Column(
        children: [
          getHeader([]),
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
      onEmpty: Column(
        children: [
          getHeader([]),
          const Expanded(
            child: Center(
              child: Text('No Data'),
            ),
          ),
        ],
      ),
          (state) {
        if (state == null) {
          return const Center(child: Text("No Data"));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeader(state),
            getList(state),
          ],
        );
      },
    );
  }

  Widget getHeader(List<Customer> state) =>
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
          ErpSearchField(
            onUpdate: (value) {
              controller.search(value);
            },
          ),
          Obx(
                () {
              if (controller.selectedCustomers.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
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
                      controller.mail();
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      );

  Widget getList(List<Customer> state) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          return Material(
            type: MaterialType.transparency,
            child: ListTile(
              leading: Obx(
                    () {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (controller.selectedCustomers.isNotEmpty)
                        Row(
                          children: [
                            Checkbox(
                              value: controller.selectedCustomers
                                  .contains(state[index]),
                              onChanged: (value) {},
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      const CircleAvatar(
                        radius: 18,
                      ),
                    ],
                  );
                },
              ),
              dense: true,
              horizontalTitleGap: 12,
              minLeadingWidth: 0,
              visualDensity: const VisualDensity(vertical: 0.1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              title: Text(
                state[index]?.name ?? '-',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  height: 1,
                ),
              ),
              subtitle: Text(
                state[index]?.phoneNumber ?? state[index]?.email ?? '-',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  height: 1,
                ),
              ),
              onTap: () {
                controller.select(state[index]);
              },
              onLongPress: () {},
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: state.length,
      ),
    );
  }
}
