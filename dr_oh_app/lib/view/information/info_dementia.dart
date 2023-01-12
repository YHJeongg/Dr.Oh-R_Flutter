import 'package:dr_oh_app/components/logout_btn.dart';
import 'package:flutter/material.dart';

// --------------------------------------------------------------------
// Date: 2023-01-08, SangwonKim
// Desc: Information / Dementia Page
class InfoDementia extends StatelessWidget {
  const InfoDementia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('치매 정보'),
        elevation: 1,
        actions: const [LogoutBtn()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                // --------------------------------------------
                // 정의 Start
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
                  "치매는 후천적으로 기억, 언어, 판단력 등의 여러 영역의 인지 기능이 감소하여 일상생활을 제대로 수행하지 못하는 임상 증후군을 의미합니다. 치매에는 알츠하이머병이라 불리는 노인성 치매, 중풍 등으로 인해 생기는 혈관성 치매가 있습니다. 이 밖에도 다양한 원인에 의한 치매가 있습니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 정의 End
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // --------------------------------------------
                // 원인 Start
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
                  "전반적인 뇌 기능의 손상을 일으킬 수 있는 모든 질환이 치매의 원인이 될 수 있습니다. 흔히 알고 있는 알츠하이머병은 원인 미상의 신경퇴행성 질환으로, 전체 치매의 50~60%를 차지합니다. 뇌의 혈액순환장애에 의한 혈관성 치매가 20~30%를 차지합니다. 나머지는 기타 원인에 의한 치매입니다.\n\n알츠하이머병은 두뇌의 수많은 신경세포가 서서히 쇠퇴하면서 뇌 조직이 소실되고 뇌가 위축되는 질환입니다. 이 질환의 원인은 명확하게 밝혀지지 않았습니다. 뇌세포의 유전적 질환이 아닌지에 대한 연구가 지속적으로 이루어지고 있습니다. 다만 유전적 이상이 없는 상태에서 발병하는 알츠하이머병이 80% 이상을 차지하고 있습니다. 아직 명확하게 알려진 부분이 없습니다.\n\n혈관성 치매는 뇌 안에서 혈액순환이 잘 이루어지지 않아 서서히 신경세포가 죽거나, 갑자기 큰 뇌혈관이 막히거나 뇌혈관이 터지면서 뇌세포가 죽으면서 발생하는 치매를 의미합니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 원인 End
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // --------------------------------------------
                // 증상 Start
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
                  "치매와 건망증은 다릅니다. 건망증은 일반적으로 기억력의 저하를 호소하지만, 지남력이나 판단력 등은 정상이어서 일상적인 생활에 지장을 주지 않습니다. 건망증 환자는 기억력 장애에 대한 주관적인 호소를 하며 지나친 걱정을 하기도 하지만, 잊어버렸던 내용을 곧 기억해 낸다거나 힌트를 들으면 금방 기억해 냅니다. 치매는 기억력 감퇴뿐 아니라 언어 능력, 시공간 파악 능력, 인격 등 다양한 정신 능력에 장애가 발생함으로써 지적인 기능의 지속적 감퇴가 초래됩니다.\n\n① 기억력 저하\n건망증이라면 어떤 사실을 기억하지 못하더라도 힌트를 주면 금방 기억을 되살릴 수 있습니다. 하지만 치매 환자는 힌트를 주어도 기억하지 못하는 경우가 많습니다.\n② 언어 장애\n가장 흔한 증상은 물건의 이름이 금방 떠오르지 않아 머뭇거리는 현상인 '명칭 실어증'입니다.\n③ 시공간 파악 능력 저하\n길을 잃고 헤매는 증상이 나타날 수 있습니다. 초기에는 낯선 곳에서 길을 잃는 경우가 나타납니다. 점차 증상이 진행되면, 자기 집을 못 찾는다거나 집 안에서 화장실이나 안방 등을 혼동하는 경우가 나타납니다.\n④ 계산 능력의 저하\n거스름돈과 같은 잔돈을 주고받는 데 자꾸 실수가 생깁니다. 이전에 잘하던 돈 관리를 못 하게 되기도 합니다.\n⑤ 성격 변화와 감정의 변화\n이는 매우 흔하게 나타날 수 있는 증상입니다. 예를 들어, 과거에 매우 꼼꼼하던 사람이 대충대충 일을 처리한다거나, 전에는 매우 의욕적이던 사람이 매사에 무관심해지기도 합니다. 감정의 변화도 많이 관찰됩니다. 특히 우울증이 동반되는 경우가 많습니다. 수면 장애가 생길 수도 있습니다. 잠을 지나치게 많이 자거나, 반대로 불면증에 시달리기도 합니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 증상 End
                Divider(
                  color: Theme.of(context).primaryColorDark,
                  height: 40,
                  thickness: 1,
                ),
                // --------------------------------------------
                // 주의사항 Start
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
                  "치매의 증상 및 종류는 다양합니다. 현재까지 발생 기전이 확실히 규명되지 않았고, 원인을 치료할 수 있는 치료법도 없는 상태입니다. 따라서 미리 예방하는 것이 중요합니다. 일반적으로 권장되는 것은 두뇌 회전을 많이 시킬 수 있는 놀이나 독서입니다. 건전한 수준의 게임, 바둑, 카드놀이와 같은 종합적인 인지 능력을 요구하는 놀이가 건망증을 예방하는 데 도움이 됩니다. 신문, 책을 읽거나 글을 쓰는 것이 효과적인 예방법입니다. 건강한 식습관을 가지고 생선과 야채를 즐겨 먹어야 합니다. 적절한 운동을 합니다. 꾸준한 걷는 운동은 인지 기능을 유지하는 데 도움이 됩니다. 지나친 음주와 흡연을 삼가야 합니다. 술과 담배는 기억력 등의 인지 기능에 나쁜 영향을 미칩니다. 충분한 수면을 취하는 것이 좋습니다. 수면 부족은 기억력을 떨어뜨릴 수 있습니다. 메모하는 생활을 습관화하는 것이 좋습니다.",
                  style: TextStyle(fontSize: 20),
                ),
                // 주의사항 End
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
