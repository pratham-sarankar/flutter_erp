import 'package:flutter_erp/app/data/models/address.dart';
import 'package:flutter_erp/app/data/models/bank_account.dart';

class Vendor {
  final String? id;

  //Basic details
  String? name;
  String? emailId;
  String? mobileNo;

  //Address
  final Address? address;

  //Business details
  final String? gstin;
  final String? panNo;
  final String? landLineNo;

  //Licences
  final String? foodLicenceNo;
  final String? drugLicenceNo;

  //Bank Details
  final BankAccount? account;
  final String? billingSeries;
  final String? purchaseSeries;
  final String? balanceType;
  final double? balance;

  //Additional Information
  final String? shortName;
  final String? photoURL;
  final String? contactPerson;

  Vendor({
    this.id,
    this.name,
    this.emailId,
    this.mobileNo,
    this.address,
    this.gstin,
    this.panNo,
    this.landLineNo,
    this.foodLicenceNo,
    this.drugLicenceNo,
    this.account,
    this.billingSeries,
    this.purchaseSeries,
    this.balanceType,
    this.balance,
    this.shortName,
    this.photoURL,
    this.contactPerson,
  });

  @override
  String toString() {
    return 'Vendor{id: $id, name: $name, emailId: $emailId, mobileNo: $mobileNo, address: $address, gstin: $gstin, panNo: $panNo, landLineNo: $landLineNo, foodLicenceNo: $foodLicenceNo, drugLicenceNo: $drugLicenceNo, account: $account, billingSeries: $billingSeries, purchaseSeries: $purchaseSeries, balanceType: $balanceType, balance: $balance, shortName: $shortName, photoURL: $photoURL, contactPerson: $contactPerson}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'emailId': this.emailId,
      'mobileNo': this.mobileNo,
      'address': this.address,
      'gstin': this.gstin,
      'panNo': this.panNo,
      'landLineNo': this.landLineNo,
      'foodLicenceNo': this.foodLicenceNo,
      'drugLicenceNo': this.drugLicenceNo,
      'account': this.account,
      'billingSeries': this.billingSeries,
      'purchaseSeries': this.purchaseSeries,
      'balanceType': this.balanceType,
      'balance': this.balance,
      'shortName': this.shortName,
      'photoURL': this.photoURL,
      'contactPerson': this.contactPerson,
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'] as String,
      name: map['name'] as String,
      emailId: map['emailId'] as String,
      mobileNo: map['mobileNo'] as String,
      address: map['address'] as Address,
      gstin: map['gstin'] as String,
      panNo: map['panNo'] as String,
      landLineNo: map['landLineNo'] as String,
      foodLicenceNo: map['foodLicenceNo'] as String,
      drugLicenceNo: map['drugLicenceNo'] as String,
      account: map['account'] as BankAccount,
      billingSeries: map['billingSeries'] as String,
      purchaseSeries: map['purchaseSeries'] as String,
      balanceType: map['balanceType'] as String,
      balance: map['balance'] as double,
      shortName: map['shortName'] as String,
      photoURL: map['photoURL'] as String,
      contactPerson: map['contactPerson'] as String,
    );
  }

  bool doesMatch(String value) {
    return (name?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
        (mobileNo?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
        (emailId?.toLowerCase().contains(value.toLowerCase()) ?? false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Vendor && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
