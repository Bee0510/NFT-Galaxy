class MarketNFTs {
  final String chain;
  final String description;
  final String image;
  final String primarycnt;
  String? id;
  Map<String, dynamic>? rank;
  String twitter;
  int? tokencount;
  int? onSaleCount;

  MarketNFTs({
    required this.chain,
    required this.description,
    required this.image,
    required this.primarycnt,
    this.id,
    this.rank,
    required this.twitter,
    this.tokencount,
    this.onSaleCount,
  });

  factory MarketNFTs.fromJson(Map<String, dynamic> json) {
    return MarketNFTs(
      chain: json['chain'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      primarycnt: json['primaryContract'] ?? '',
      id: json['id'] ?? '',
      rank: json['rank'] ?? {},
      twitter: json['twitterUsername'] ?? '',
      tokencount: json['tokenCount'] ?? 0,
      onSaleCount: json['onSaleCount'] ?? 0,
    );
  }

  static List<MarketNFTs> listFromJson(Map<String, dynamic> json) {
    final collections = json['collections']['results'];
    if (collections is List) {
      return collections.map((result) => MarketNFTs.fromJson(result)).toList();
    }
    return [];
  }
}
