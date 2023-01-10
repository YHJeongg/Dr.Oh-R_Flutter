import 'package:cloud_firestore/cloud_firestore.dart';

class DementiaDB{
  queryJSONData(){
    FirebaseFirestore.instance
              .collection('Dementia')
              .orderBy('seq', descending: false)
              .snapshots();
  }
}