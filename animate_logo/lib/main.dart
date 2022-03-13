import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animation = CurvedAnimation(parent: animationController, curve: Curves.elasticInOut, reverseCurve: Curves.bounceIn);
    animationController.forward();
    animation.addStatusListener((status) {
      if (animation.isCompleted) {
        animationController.reverse();
      } else if (animation.isDismissed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GrowAnimated(child: FlutterLogo(), animation: animation);
  }
}

// class AnimatedLogo extends AnimatedWidget {
//   AnimatedLogo(Animation<double> animation) : super(listenable: animation);

//   @override
//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable as Animation<double>;
//     return Center(
//       child: Container(
//         width: animation.value,
//         height: animation.value,
//         child: FlutterLogo(),
//       ),
//     );
//   }
// }

class GrowAnimated extends StatelessWidget {
  Widget child;
  Animation<double> animation;

  final sizeTween = Tween(begin: 0.0, end: 300.0);
  final opacitTween = Tween(begin: 0.1, end: 1.0);

  GrowAnimated({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: opacitTween.evaluate(animation).clamp(0, 1.0),
            child: SizedBox(
              width: sizeTween.evaluate(animation).clamp(0, 500),
              height: sizeTween.evaluate(animation).clamp(0, 500),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
