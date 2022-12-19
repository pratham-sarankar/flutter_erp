import 'package:flutter_erp/app/data/models/vendor.dart';
import 'package:flutter_erp/app/data/providers/vendor_provider.dart';

class VendorRepository {
  final VendorProvider _provider;

  VendorRepository._privateConstructor() : _provider = VendorProvider();

  static final instance = VendorRepository._privateConstructor();

  Future<List<Vendor>> fetchAll() async {
    List<Vendor> results = await _provider.fetchAll();
    return results;
  }

  Future<void> insertOne(Vendor vendor) async {
    await _provider.insertOne(vendor);
    return;
  }
}
