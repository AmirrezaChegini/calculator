import 'dart:async';

import 'package:calculator/controller/cal_controller.dart';
import 'package:calculator/utils/btn_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spring_button/spring_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final List<List<String>> expressionLists = const [
    ['C', 'DE', '(', ')'],
    ['7', '8', '9', '/'],
    ['4', '5', '6', 'x'],
    ['1', '2', '3', '+'],
    ['.', '0', '=', '-']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 35,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                ),
                child: EdtText(),
              ),
            ),
            Expanded(
              flex: 65,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Btns(txts: expressionLists[index]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EdtText extends StatelessWidget {
  EdtText({super.key});
  final _calCtrl = Get.put(CalController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() => Text(
                _calCtrl.exp.value,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.2,
                  letterSpacing: 1.6,
                ),
              )),
          const SizedBox(height: 10),
          Obx(() => Text(
                _calCtrl.result.value,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.6,
                ),
              )),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Btns extends StatelessWidget {
  Btns({super.key, required this.txts});

  final List<String> txts;
  final _calCtrl = Get.put(CalController());
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...List.generate(
            4,
            (index) => Expanded(
              child: SpringButton(
                SpringButtonType.OnlyScale,
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.blueGrey[900],
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        txts[index],
                        style: TextStyle(
                          color: btnColors(txts[index]),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                onTapDown: (_) {
                  _calCtrl.calculate(txts[index]);
                },
                onLongPress: () => _timer = Timer.periodic(
                  const Duration(milliseconds: 100),
                  (_) => _calCtrl.calculate(txts[index]),
                ),
                onLongPressEnd: (_) => _timer.cancel(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
