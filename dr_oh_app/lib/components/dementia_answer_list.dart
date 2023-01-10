import 'package:flutter/material.dart';

class DementiaAnswer {
  List<Widget> dementiaAnswer = const [
    ZList(),
    AList(),
    PList(),
    CList(),
    BList(),
    DList(),
    EList(),
    FList(),
    GList(),
    HList(),
    IList(),
    QList(),
    JList(),
    KList(),
    LList(),
    MList(),
    NList(),
    OList()
  ];
  List<String> dementiaText = const [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18'
  ];
}

class ZList extends StatefulWidget {
  const ZList({super.key});

  @override
  State<ZList> createState() => _ZListState();
}

class _ZListState extends State<ZList> {
  TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: yearController,
          decoration: const InputDecoration(hintText: '1990'),
        )
      ],
    );
  }
}

class AList extends StatefulWidget {
  const AList({super.key});

  @override
  State<AList> createState() => _AListState();
}

class _AListState extends State<AList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('봄')),
          ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('여름')),
          ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('가을')),
          ElevatedButton(
              onPressed: () {
                //
              },
              child: const Text('겨울')),
        ],
      ),
    );
  }
} //AList

class BList extends StatefulWidget {
  const BList({super.key});

  @override
  State<BList> createState() => _BListState();
}

class _BListState extends State<BList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('월요일')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('화요일')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('수요일')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('목요일')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('금요일')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('토요일')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('일요일')),
      ],
    );
  }
}

class CList extends StatefulWidget {
  const CList({super.key});

  @override
  State<CList> createState() => _CListState();
}

class _CListState extends State<CList> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: dateController,
          decoration: const InputDecoration(hintText: '21'),
        )
      ],
    );
  }
}

class DList extends StatefulWidget {
  const DList({super.key});

  @override
  State<DList> createState() => _DListState();
}

class _DListState extends State<DList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('대한민국')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('미국')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('일본')),
      ],
    );
  }
}

class EList extends StatefulWidget {
  const EList({super.key});

  @override
  State<EList> createState() => _EListState();
}

class _EListState extends State<EList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('서울특별시')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('인천시')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('경상북도')),
      ],
    );
  }
}

class FList extends StatefulWidget {
  const FList({super.key});

  @override
  State<FList> createState() => _FListState();
}

class _FListState extends State<FList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('대덕구')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('동구')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('중구')),
      ],
    );
  }
}

class GList extends StatefulWidget {
  const GList({super.key});

  @override
  State<GList> createState() => _GListState();
}

class _GListState extends State<GList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('신대동')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('황호동')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('신탄진동')),
      ],
    );
  }
}

class HList extends StatefulWidget {
  const HList({super.key});

  @override
  State<HList> createState() => _HListState();
}

class _HListState extends State<HList> {
  TextEditingController aProductController = TextEditingController();
  TextEditingController bProductController = TextEditingController();
  TextEditingController cProductController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aProductController = TextEditingController();
    bProductController = TextEditingController();
    cProductController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: aProductController,
        ),
        TextField(
          controller: bProductController,
        ),
        TextField(
          controller: cProductController,
        ),
      ],
    );
  }
}

class IList extends StatefulWidget {
  const IList({super.key});

  @override
  State<IList> createState() => _IListState();
}

class _IListState extends State<IList> {
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: numController,
        ),
      ],
    );
  }
}

class JList extends StatefulWidget {
  const JList({super.key});

  @override
  State<JList> createState() => _JListState();
}

class _JListState extends State<JList> {
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: numController,
        ),
      ],
    );
  }
}

class QList extends StatefulWidget {
  const QList({super.key});

  @override
  State<QList> createState() => _QListState();
}

class _QListState extends State<QList> {
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: numController,
        ),
      ],
    );
  }
}

class KList extends StatefulWidget {
  const KList({super.key});

  @override
  State<KList> createState() => _KListState();
}

class _KListState extends State<KList> {
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: numController,
        ),
      ],
    );
  }
}

class LList extends StatefulWidget {
  const LList({super.key});

  @override
  State<LList> createState() => _LListState();
}

class _LListState extends State<LList> {
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: numController,
        ),
      ],
    );
  }
}

class MList extends StatefulWidget {
  const MList({super.key});

  @override
  State<MList> createState() => _MListState();
}

class _MListState extends State<MList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('나무')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('모자')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('자동차')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('연필')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('비행기')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('소나무')),
      ],
    );
  }
}

class NList extends StatefulWidget {
  const NList({super.key});

  @override
  State<NList> createState() => _NListState();
}

class _NListState extends State<NList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('비행기')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('시계')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('나무')),
      ],
    );
  }
}

class OList extends StatefulWidget {
  const OList({super.key});

  @override
  State<OList> createState() => _OListState();
}

class _OListState extends State<OList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('소나무')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('볼펜')),
        ElevatedButton(
            onPressed: () {
              //
            },
            child: const Text('모자')),
      ],
    );
  }
}

class PList extends StatefulWidget {
  const PList({super.key});

  @override
  State<PList> createState() => _PListState();
}

class _PListState extends State<PList> {
  TextEditingController monthController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    monthController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: monthController,
        )
      ],
    );
  }
}
