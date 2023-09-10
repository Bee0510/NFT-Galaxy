class NFTDetails {
  final String name;
  final String symbol;
  final String ownerOf;
  final String tokenURI;
  final Map<String, dynamic> metadata;

  NFTDetails({
    required this.name,
    required this.symbol,
    required this.ownerOf,
    required this.tokenURI,
    required this.metadata,
  });

  factory NFTDetails.fromJson(Map<String, dynamic> json) {
    return NFTDetails(
      name: json['nft_details']['name'],
      symbol: json['nft_details']['symbol'],
      ownerOf: json['nft_details']['ownerOf'],
      tokenURI: json['nft_details']['tokenURI'],
      metadata: json['nft_details']['metadata'],
    );
  }
}
