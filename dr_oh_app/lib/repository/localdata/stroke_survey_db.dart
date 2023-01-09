import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/stroke_survey_model.dart';

// Date: 2023-01-09, SangwonKim
// Desc: 뇌졸중검사 DB, 임시<<
class StrokeSurveyDB{
  
  queryJSONData(){
    FirebaseFirestore.instance
              .collection('Stroke')
              .orderBy('seq', descending: false)
              .snapshots();
  }
}







// class StrokeSurveyDB {
//   // Query
//   Future<List<StrokeSurvey>> queryJSONData() async {
//     var url =
//         Uri.parse('http://localhost:8080/Flutter/student_query_flutter.jsp');
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       final body = jsonDecode(utf8.decode(response.bodyBytes));
//       final Iterable json = body['results'];
//       return json.map((strokeSurvey) => StrokeSurvey.fromJson(strokeSurvey)).toList();
//     } else {
//       throw Exception("Unable to perform request!");
//     }
//   }

//   // // Insert
//   // insertJSONData(String code, String name, String dept, String phone) async {
//   //   var url = Uri.parse(
//   //       'http://localhost:8080/Flutter/student_insert_return_flutter.jsp?code=$code&name=$name&dept=$dept&phone=$phone');
//   //   await http.get(url);
//   // }

//   // // Delete
//   // deleteJSONData(String code) async {
//   //   var url = Uri.parse(
//   //       'http://localhost:8080/Flutter/student_delete_return_flutter.jsp?code=$code');
//   //   await http.get(url);
//   // }

//   // // Update
//   // updateJSONData(String code, String name, String dept, String phone) async {
//   //   var url = Uri.parse(
//   //       'http://localhost:8080/Flutter/student_update_return_flutter.jsp?code=$code&name=$name&dept=$dept&phone=$phone');
//   //   await http.get(url);
//   // }
// } // End
