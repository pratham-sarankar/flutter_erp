import 'package:faker/faker.dart';
import 'package:flutter_erp/app/data/models/vendor.dart';

class VendorProvider {
  late List<Vendor> _vendors;

  VendorProvider() {
    var faker = Faker();
    _vendors = [
      for (int i = 0; i < 5; i++)
        Vendor(
          id: faker.person.name().hashCode.toString(),
          name: faker.person.name(),
          mobileNo: faker.phoneNumber.us(),
          emailId: faker.internet.email(),
        ),
    ];
  }

  Future<List<Vendor>> fetchAll() async {
    return _vendors;
  }

  Future<void> insertOne(Vendor vendor) async {
    _vendors.add(vendor);
    return;
  }
}
