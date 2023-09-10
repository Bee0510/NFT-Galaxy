class Transaction {
  final String blockNumber;
  final String timeStamp;
  final String hash;
  final String from;
  final String tokenName;
  final String tokenSymbol;

  Transaction({
    required this.blockNumber,
    required this.timeStamp,
    required this.hash,
    required this.from,
    required this.tokenName,
    required this.tokenSymbol,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      blockNumber: json['blockNumber'].toString(),
      timeStamp: json['timeStamp'].toString(),
      hash: json['hash'].toString(),
      from: json['from'].toString(),
      tokenName: json['tokenName'].toString(),
      tokenSymbol: json['tokenSymbol'].toString(),
    );
  }
}
