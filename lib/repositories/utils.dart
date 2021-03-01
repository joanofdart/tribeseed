import 'dart:math';

const errorTriggerPercentage = 0.5;

Future<void> waitForRandomTime() async {
  final random = Random();

  await Future.delayed(
    Duration(
      seconds: random.nextInt(3),
    ),
    () {},
  );
}
