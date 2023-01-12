import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/model/body_info_model.dart';
import 'package:dr_oh_app/model/diabetes_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DUserInfo extends StatefulWidget {
  final PageController pageCont;
  const DUserInfo({super.key, required this.pageCont});

  @override
  State<DUserInfo> createState() => _DUserInfoState();
}

class _DUserInfoState extends State<DUserInfo> {
  late TextEditingController ageCont;
  late TextEditingController heightCont;
  late TextEditingController weightCont;
  int curyear = DateTime.now().year;
  RegExp ageReg = RegExp(r"^[0-9]{4}$"); //숫자만 4자리
  late bool correctYear;
  late bool correctHeight;
  late bool correctWeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ageCont = TextEditingController();
    heightCont = TextEditingController();
    weightCont = TextEditingController();
    correctYear = false;
    correctWeight = false;
    correctHeight = false;
  }

  @override
  Widget build(BuildContext context) {
    // Date: 2023-01-11, SangwonKim
    // Desc: GestureDetector 추가함
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // -----------------------------
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text(
                  '신체 정보 입력',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: ageCont,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (ageReg.hasMatch(value) &&
                            int.parse(value) <= curyear) {
                          setState(() {
                            correctYear = true;
                          });
                        } else {
                          setState(() {
                            correctYear = false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ageCont.text.trim().isEmpty
                            ? '출생년도 4자리'
                            : correctYear
                                ? ''
                                : '출생년도를 정확히 입력하세요.',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: heightCont,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: '키(cm)',
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            correctHeight = false;
                          });
                        } else {
                          setState(() {
                            correctHeight = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: TextField(
                      controller: weightCont,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: '몸무게(kg)',
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            correctWeight = false;
                          });
                        } else {
                          setState(() {
                            correctWeight = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String id = (prefs.getString('id') ?? "");
                    var docs1 = await FirebaseFirestore.instance
                        .collection('users')
                        .where('id', isEqualTo: id)
                        .get();
                    final bodyinfo =
                        docs1.docs.first.data().toString().contains('height')
                            ? BodyInfoModel(
                                id: docs1.docs.first.data()['id'],
                                height: docs1.docs.first.data()['height'],
                                weight: docs1.docs.first.data()['weight'],
                              )
                            : BodyInfoModel(id: '', height: '', weight: '');
                    final userage=docs1.docs.first.data()['birthdate'].toString().substring(0,4);
                    if (bodyinfo.height.toString().isNotEmpty) {
                      heightCont.text = bodyinfo.height.toString();
                      weightCont.text = bodyinfo.weight.toString();
                      setState(() {
                        correctHeight=true;
                        correctWeight=true;
                      });
                    }
                    ageCont.text=userage;
                    setState(() {
                      correctYear=true;
                    });
                  },
                  child: const Text(
                    '내 정보 가져오기',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: correctYear && correctHeight && correctWeight
                        ? () {
                            //if로 한번 더 감싸기(개인정보보호법 둘 다 클릭 완료 시 넘어감)
                            if (widget.pageCont.hasClients) {
                              DiabetesMessage.age =
                                  curyear - int.parse(ageCont.text.trim());
                              DiabetesMessage.height =
                                  double.parse(heightCont.text.trim());
                              DiabetesMessage.weight =
                                  double.parse(weightCont.text.trim());
                              widget.pageCont.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        : null,
                    child: const Text(
                      '다음',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
