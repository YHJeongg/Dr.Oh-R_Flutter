import 'package:flutter/material.dart';

class InfoDiabetes extends StatelessWidget {
  const InfoDiabetes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('당뇨병 정보'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                // 정의 시작
                const Text(
                  '정의',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "당뇨병은 소변으로 포도당이 배출된다고 하여 이름 붙여진 병입니다. 정상인의 경우 소변으로 당이 넘쳐나지 않을 정도로 혈당이 조절됩니다. 여기에는 췌장에서 분비되는 '인슐린'이라는 호르몬이 중요한 작용을 합니다. 이러한 인슐린이 모자라거나 제대로 일을 못 하는 상태가 되면 혈당이 상승하며, 이로 인해 혈당이 지속적으로 높은 상태가 됩니다. 이러한 상태를 당뇨병이라고 합니다. 우리나라의 당뇨병 유병률은 경제가 발전하고 생활 양식이 서구화됨에 따라 증가하는 추세입니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 정의 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 원인 시작
                const Text(
                  '원인',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "당뇨병의 발생에는 유전과 환경이 중요한 역할을 합니다. 즉, 당뇨병은 이것에 걸리기 쉬운 유전적 체질을 부모로부터 물려받은 사람이 당뇨병을 유발하기 쉬운 환경에 노출될 때 발생할 수 있습니다. 하지만 현재까지 당뇨병을 일으키는 유전자의 이상을 찾을 수 있는 경우는 전체 당뇨병의 1% 미만에 불과합니다. 대부분의 당뇨병에서는 원인 유전자가 명확히 밝혀지지 않았습니다.\n\n당뇨병을 유발할 수 있는 환경 인자로는 고령, 비만, 스트레스, 임신, 감염, 약물(스테로이드제제, 면역억제제, 이뇨제) 등이 있습니다. 환경 인자는 유전 인자와는 달리 본인의 노력으로 어느 정도 피할 수 있습니다. 최근 들어 당뇨병이 급증하는 이유는 유전적인 원인보다는 과도한 음식물 섭취와 운동량 감소로 인한 비만증의 증가 때문으로 여겨집니다. 단것을 많이 먹는다고 당뇨병이 생기지는 않지만, 단것을 많이 먹으면 체중이 늘어날 수 있으며, 비만증이 생기면 당뇨병이 생길 위험성이 증가합니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 원인 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 증상 시작
                const Text(
                  '증상',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "당뇨병에 걸리면 소변으로 포도당이 빠져나가는데, 이때 수분을 같이 끌고 나가기 때문에 소변량이 늘어납니다. 그 결과 몸 안에 수분이 부족하여 심한 갈증을 느끼게 됩니다. 또한 영양분이 몸에서 이용되지 않고 빠져나가므로 피로감을 잘 느낍니다. 또한 잘 먹는데도 불구하고 체중이 감소합니다.\n\n당뇨병의 가장 대표적인 증상을 ‘삼다(三多)’라고 부릅니다. 즉, 다음(多飮, 물을 많이 마심), 다뇨(多尿, 소변을 많이 봄), 다식(多食, 많이 먹음)을 말합니다. 그 외 당뇨병의 증상으로는 눈 침침함, 손발 저림, 여성의 경우 질 소양증 등이 나타날 수 있습니다. 하지만 혈당이 많이 높지 않은 경우에는 대부분 특별한 증상을 느끼지 못합니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 증상 끝
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // 주의사항 시작
                const Text(
                  '주의사항',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "당뇨병을 예방하기 위해서는 일단 당뇨병을 유발할 수 있는 환경 인자인 비만, 좌식 생활, 고지방 식사, 스트레스, 음주 등을 피하는 것이 최선입니다. 특히 가족 중에 당뇨병 환자가 있는 사람은 비만증이 생기지 않도록 식사량을 적절히 조절하고, 운동을 규칙적으로 해야 합니다.\n또한 무증상기의 당뇨병을 조기에 진단하기 위해서 다음에 해당하는 사람들은 매년 혈당 검사를 받을 것을 권장하고 있습니다.\n① 45세 이상의 모든 성인\n② 45세 미만이라도 과체중이거나 비만이면서 아래와 같은 위험 요인이 있는 경우\n- 부모, 형제, 자식 중에 당뇨병 환자가 있는 사람\n- 고혈압(혈압 140/90mmHg 이상)이 있거나 항고혈압 약물을 복용 중인 사람\n- 이상지혈증을 가지고 있는 사람(HDL 콜레스테롤 35mg/dl 이하 또는 중성지방 250mg/dl 이상)\n- 과거 내당능 장애 또는 공복 혈당 장애가 있었던 사람\n- 임신성 당뇨병으로 진단받은 적이 있거나 4kg 이상의 거대아를 출산한 적이 있는 사람\n- 심혈관 질환(뇌졸중, 관상동맥 질환, 말초혈관 질환)을 경험한 사람\n- 평소에 운동을 하지 않는 사람",
                  style: TextStyle(fontSize: 20),
                ),
                // 주의사항 끝
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
