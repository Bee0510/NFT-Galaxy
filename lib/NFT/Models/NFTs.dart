class NFTs {
  final String tokenId;
  final String contractAdd;

  final String tokenName;

  NFTs({
    required this.tokenId,
    required this.contractAdd,
    required this.tokenName,
  });

  factory NFTs.fromJson(Map<String, dynamic> json) {
    return NFTs(
      tokenId: json['tokenID'].toString(),
      contractAdd: json['contractAddress'].toString(),
      tokenName: json['tokenName'].toString(),
    );
  }
}
