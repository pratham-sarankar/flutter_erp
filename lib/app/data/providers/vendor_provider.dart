import 'package:flutter_erp/app/data/models/vendor.dart';

class VendorProvider {
  late List<Vendor> _vendors;

  VendorProvider() {}

  Future<List<Vendor>> fetchAll() async {
    return _vendors;
  }

  Future<void> insertOne(Vendor vendor) async {
    _vendors.add(vendor);
    return;
  }
}
