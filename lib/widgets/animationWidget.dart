import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimationWidge extends StatefulWidget {
  AnimationWidge({super.key,required this.text});
  String text;

  @override
  State<AnimationWidge> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidge> {
  // Artboard? riveArtboard;
  // void initState() {
  //   super.initState();
  //   rootBundle.load(widget.text).then(
  //     (data) async {
  //       try{
  //           final file = RiveFile.import(data);
  //           final artboard = file.mainArtboard;
  //           var controller = StateMachineController.fromArtboard(artboard,'char');
  //           if(controller != null ) {
  //             artboard.addController(controller);
  //           }
  //           setState(() => riveArtboard = artboard);
  //       } catch(e) {
  //         print(e);
  //       }
  //     }
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return  RiveAnimation.asset(widget.text);
  }
}