import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/dementia_chart_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DementiaController {
  List<DementiaChart> result = <DementiaChart>[];

  Future<void> queryDementia() async {
    final prefs = await SharedPreferences.getInstance();

    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: prefs.getString('id') ?? "")
        .get();

    var data2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(data.docs.first.id)
        .collection('dementia_p')
        .get();

        result = data2.docs.map((e) => DementiaChart()).toList();
  }//

  
}
