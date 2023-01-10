import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Medication extends StatefulWidget {
  const Medication({super.key});

  @override
  State<Medication> createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  DateTimeRange? _selectedDateRange;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();

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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _dateTextfield(startDateController, '시작일'),
                      _dateTextfield(endDateController, '종료일'),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: hospitalController,
                  decoration: const InputDecoration(
                    hintText: '병원명',
                  ),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('저장'))
            ],
          ),
        ),
      ),
    );
  }

  void _showDateRangePickerPop() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(Duration(days: 30)),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      // Rebuild the UI
      setState(() {
        _selectedDateRange = result;
        startDateController.text = result.start.toString().substring(0, 10);
        endDateController.text = result.end.toString().substring(0, 10);
      });
    }
  }
}
