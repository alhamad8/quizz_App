



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../controller/quiz_controller.dart';
import '../widgets/custtom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const routeName = '/result_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 142, 221, 213),
            /*image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'),
                fit: BoxFit.cover),*/
          ),
        ),
        Center(
          child: GetBuilder<QuizzQontroller>(
            init: Get.find<QuizzQontroller>(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Congratulation',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  controller.name,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: kPrimaryColor,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Your Score is',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  '${controller.scoreResult.round()} /100',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: kPrimaryColor,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(

                    onPressed: () => controller.startAgain(),
                    text: 'Start Again'),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}