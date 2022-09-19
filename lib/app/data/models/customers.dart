class Customer {
  final String name;
  final String photoURL;
  final DateTime memberSince;
  final double totalPurchased;
  final int totalVisits;
  final String contactNumber;

  Customer({
    required this.name,
    required this.photoURL,
    required this.memberSince,
    required this.totalPurchased,
    required this.totalVisits,
    required this.contactNumber,
  });

  Customer.fromJson(Map json)
      : name = "${json['name']['first']} ${json['name']['last']}",
        photoURL = json['picture']['large'],
        memberSince = DateTime.parse(json['registered']['date']),
        totalPurchased = double.parse(json['dob']['age'].toString()),
        totalVisits = json['registered']['age'],
        contactNumber = json['cell'];
}
