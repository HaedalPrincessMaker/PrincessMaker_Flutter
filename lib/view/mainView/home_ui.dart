import 'package:flutter/material.dart';
import 'package:flutter_princess_maker/common/react_size.dart';

class HomeUi extends StatelessWidget {
  const HomeUi({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle main =
        TextStyle(fontFamily: 'Hakgyo', fontSize: garo(context, 0.08));

    TextStyle sub = main.copyWith(fontSize: garo(context, 0.045));

    return SafeArea(
        child: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: garo(context, 0.025)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: sero(context, 0.02),
            ),
            Text(
              "당신의 아침을 깨우고,\n당신의 잠재력을 깨웁니다.\n함께 시작해볼까요?",
              style: main,
            ),
            SizedBox(
              height: sero(context, 0.025),
            ),
            Text(
              "우리는 당신의 하루 시작을 특별하게 만들고, 매일 아침을 의미 있고 생산적으로 시작할 수 있도록 도와드립니다.\n매일 아침, 일나람은 당신을 깨우는 것에서 그치지 않습니다. 우리는 당신의 두뇌를 자극하고, 하루를 활기차게 시작할 수 있도록 도와줍니다. 매일 새로운 퀴즈로 당신의 지식을 테스트하고, 학습 욕구를 자극하며, 계속해서 성장할 수 있는 기회를 제공합니다.\n하지만 일나람의 진정한 힘은 바로 연결에 있습니다. 친구들과 함께 알람을 설정하고, 서로의 성장을 응원하며, 함께 배우고 성장하는 즐거움을 경험해보세요. 혼자가 아닌 함께일 때, 우리는 더 큰 동기부여를 받고 더 멀리 갈 수 있습니다.\n상상해보세요. 매일 아침 퀴즈를 풀며 두뇌를 깨우고, 친구들과 함께 성장하는 즐거움을 느끼며, 하루를 시작하는 당신의 모습을. 이것이 바로 일나람이 제공하는 경험입니다.\n매일 조금씩 더 나은 자신이 되어가는 여정을 시작해보세요.",
              style: sub,
              softWrap: true,
            ),
          ],
        ),
              ),
            ));
  }
}
