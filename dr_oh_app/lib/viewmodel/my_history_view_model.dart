import 'package:dr_oh_app/model/hospital_visit_model.dart';
import 'package:dr_oh_app/model/medication_model.dart';
import 'package:dr_oh_app/repository/localdata/my_history_repository.dart';
import 'package:get/get.dart';

class MyHistoryViewModel extends GetxController {
  static MyHistoryViewModel get to => Get.find();
  Rx<HospitalVisitModel> hospital = HospitalVisitModel().obs;
  Rx<MedicationModel> medication = MedicationModel().obs;

  void addHospital(HospitalVisitModel hos, String id) async {
    await MyHistoryRepository.addHospitalVisit(hos, id);
  }

  void addMedication(MedicationModel med, String id) async {
    await MyHistoryRepository.addMedication(med, id);
  }
}
