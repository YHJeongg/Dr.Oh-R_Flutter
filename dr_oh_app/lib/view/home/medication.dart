import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:dr_oh_app/model/medication_model.dart';
import 'package:dr_oh_app/viewmodel/my_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Medication extends StatefulWidget {
  const Medication({super.key});

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  DateTimeRange? _selectedDateRange;
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _pillController = TextEditingController();
  late String id = '';

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Widget _dateTextfield(dynamic controller, String hint) {
    return SizedBox(
      width: 165,
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () {
          _showDateRangePickerPop();
        },
        decoration: InputDecoration(
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('투약이력 입력'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dateTextfield(_startDateController, '시작일'),
                    _dateTextfield(_endDateController, '종료일'),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _hospitalController,
                decoration: const InputDecoration(
                  hintText: '병원명',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _diseaseController,
                decoration: const InputDecoration(
                  hintText: '병명',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _pillController,
                decoration: const InputDecoration(
                  hintText: '처방의약품명',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  MedicationModel medicationModel = MedicationModel(
                    firstDate:
                        _startDateController.text.toString().substring(0, 10),
                    lastDate:
                        _endDateController.text.toString().substring(0, 10),
                    hospital: _hospitalController.text,
                    disease: _diseaseController.text,
                    pill: _pillController.text,
                  );
                  MyHistoryViewModel.to.addMedication(medicationModel, id);
                  Navigator.pop(context);
                },
                child: const Text('추가'))
          ],
        ),
      ),
    );
  }

  void _showDateRangePickerPop() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      setState(() {
        _selectedDateRange = result;
        _startDateController.text = result.start.toString().substring(0, 10);
        _endDateController.text = result.end.toString().substring(0, 10);
      });
    }
  }
}
