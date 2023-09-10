// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nftgallery/Firestore/models/nftModel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference nftCollection =
      FirebaseFirestore.instance.collection('NFT collection');
  Future UpdateUserData(
    String imgurl,
    String contactAdress,
    String chain,
    String name,
    String description,
  ) async {
    return await nftCollection.doc(uid).set({
      'imgurl': imgurl,
      'contractAdress': contactAdress,
      'chain': chain,
      'name': name,
      'description': description,
    });
  }

  Future<void> addNftItem({
    required String imgurl,
    required String contactAdress,
    required String chain,
    required String name,
    required String description,
  }) async {
    String documentId = nftCollection.doc().id;

    await nftCollection.doc(documentId).set({
      'imgurl': imgurl,
      'contractAdress': contactAdress,
      'chain': chain,
      'name': name,
      'description': description,
    });
  }

  List<nftStore> nftStorelistfromanapshots(QuerySnapshot Snapshot) {
    return Snapshot.docs.map(
      (e) {
        return nftStore(
            imgurl: e['imgurl'] ?? '',
            contactAdress: e['contractAdress'] ?? '',
            chain: e['chain'] ?? '',
            name: e['name'] ?? '',
            description: e['description'] ?? '');
      },
    ).toList();
  }

  Stream<List<nftStore>> get nfts {
    return nftCollection.snapshots().map(nftStorelistfromanapshots);
  }
}
