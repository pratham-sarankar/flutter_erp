import 'package:flutter_erp/app/data/models/user.dart';
import 'package:flutter_erp/app/data/repositories/user_repository.dart';
import 'package:flutter_erp/app/modules/users/views/user_form_view.dart';
import 'package:flutter_erp/widgets/dialogs/deletion_dialog.dart';
import 'package:get/get.dart';
import 'package:resource_manager/data/responses/fetch_response.dart';

class UsersController extends GetxController with StateMixin<List<User>> {
  late RxList<User> selectedUsers;

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  void initialize() async {
    change([], status: RxStatus.loading());
    List<User> response = await Get.find<UserRepository>().fetch();
    change(
      response,
      status: response.isEmpty ? RxStatus.empty() : RxStatus.success(),
    );
  }

  void select(User customer) {
    if (selectedUsers.contains(customer)) {
      selectedUsers.remove(customer);
    } else {
      selectedUsers.add(customer);
    }
  }

  void reload() {
    initialize();
  }

  void insertUser() async {
    var result = await Get.dialog(
      const UserFormView(),
      barrierDismissible: false,
    );
    if (result != null) {
      reload();
    }
  }

  void destroyTile(User state) async {
    var result = await Get.dialog(
      DeletionDialog(
        onDelete: () async {
          await Get.find<UserRepository>().destroy(state);
          return true;
        },
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      reload();
    }
  }

  void updateTile(User state) async {
    var result = await Get.dialog(
      const UserFormView(),
      arguments: state,
      barrierDismissible: false,
    );
    if (result != null) {
      reload();
    }
  }
}
