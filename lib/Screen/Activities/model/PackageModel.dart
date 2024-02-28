class ActivityPackage {
  final String title;
  final String image;
  final String desc;
  final double amount;
  double total;
  int persons;

  ActivityPackage({
    required this.title,
    required this.image,
    required this.desc,
    required this.amount,
    required this.total,
    required this.persons,
  });
}
