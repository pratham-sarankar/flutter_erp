import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/models/customer.dart';
import 'package:flutter_erp/app/data/repositories/call_log_repository.dart';
import 'package:flutter_erp/app/data/repositories/customer_repository.dart';
import 'package:flutter_erp/app/data/services/ivr_service.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:flutter_erp/widgets/global_widgets/erp_scaffold.dart';

import 'package:get/get.dart';
import 'package:resource_manager/resource_manager.dart';

import '../controllers/call_log_controller.dart';

class CallLogView extends GetResponsiveView<CallLogController> {
  CallLogView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return ErpScaffold(
      path: Routes.CALL_LOG,
      screen: screen,
      body: Scaffold(
        backgroundColor: screen.context.theme.colorScheme.surfaceVariant,
        body: Container(
          margin:
              const EdgeInsets.only(right: 16, left: 16, top: 22, bottom: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ResourceListView(
                canAdd: false,
                repository: Get.find<CallLogRepository>(),
                title: "Call Logs",
                description:
                    "Inbound and Outbound IVR call history is listed below.",
                tileBuilder: (controller, callLog) {
                  return Column(
                    children: [
                      PlusAccordion(
                        header: ListTile(
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              // color: callLog.statusColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              callLog.icon,
                              size: 20,
                              color: callLog.statusColor,
                            ),
                          ),
                          title: Text(callLog.name),
                          subtitle: Text(callLog.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // if (!callLog.isFromExistingCustomer)
                              //   CupertinoButton.filled(
                              //     child: const Icon(Icons.add),
                              //     padding: EdgeInsets.zero,
                              //     onPressed: () {},
                              //   ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 10),
                              //   child: TextButton(
                              //     onPressed: () {},
                              //     child: const Icon(
                              //       Icons.add,
                              //       size: 15,
                              //     ),
                              //   ),
                              // ),
                              Text(callLog.formattedTime),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CupertinoTheme(
                                    data: CupertinoThemeData(
                                      primaryColor: Colors.green.shade700,
                                    ),
                                    child: CupertinoButton.filled(
                                      padding: EdgeInsets.zero,
                                      borderRadius: BorderRadius.circular(10),
                                      minSize: 40,
                                      onPressed: () {
                                        Get.find<IVRService>().initiateCall(
                                            callLog.customerPhoneNumber!);
                                      },
                                      child: const Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  if (!callLog.isFromExistingCustomer)
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        CupertinoTheme(
                                          data: CupertinoThemeData(
                                            primaryColor: Colors.grey.shade800,
                                          ),
                                          child: CupertinoButton.filled(
                                            padding: EdgeInsets.zero,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            minSize: 40,
                                            onPressed: () {
                                              Get.find<
                                                      TableController<
                                                          Customer>>()
                                                  .insertRow(
                                                initialData: {
                                                  'phoneNumber': callLog
                                                      .customerPhoneNumber
                                                },
                                              );
                                            },
                                            child: const Icon(
                                              Icons.save,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
