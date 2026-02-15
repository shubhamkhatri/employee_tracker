String formatIndianCurrency(
  num amount, {
  bool includeDecimals = true,
}) {
  final bool negative = amount < 0;
  final String fixed = amount.abs().toStringAsFixed(includeDecimals ? 2 : 0);
  final List<String> parts = fixed.split('.');

  String integerPart = parts[0];
  if (integerPart.length > 3) {
    final String lastThree = integerPart.substring(integerPart.length - 3);
    String remaining = integerPart.substring(0, integerPart.length - 3);
    final RegExp groupByTwo = RegExp(r'\B(?=(\d{2})+(?!\d))');
    remaining = remaining.replaceAllMapped(groupByTwo, (Match _) => ',');
    integerPart = '$remaining,$lastThree';
  }

  final String result = includeDecimals && parts.length > 1
      ? '$integerPart.${parts[1]}'
      : integerPart;

  return negative ? '-$result' : result;
}
