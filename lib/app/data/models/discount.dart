class Discount {
  final DiscountType type;
  double value;

  Discount({required this.type, required this.value});
}

enum DiscountType { percentage, price, none }

extension DiscountTypeExtension on DiscountType {
  String get name {
    switch (this) {
      case DiscountType.percentage:
        return "percentage";
      case DiscountType.price:
        return "price";
      case DiscountType.none:
        return "none";
    }
  }

  String get title {
    switch (this) {
      case DiscountType.percentage:
        return "Percentage";
      case DiscountType.price:
        return "Price";
      case DiscountType.none:
        return "None";
    }
  }

  static DiscountType fromString(String name) {
    switch (name) {
      case "percentage":
        return DiscountType.percentage;
      case "price":
        return DiscountType.price;
      case "none":
        return DiscountType.none;
      default:
        return DiscountType.none;
    }
  }
}
