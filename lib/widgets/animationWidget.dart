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
  @override
  Widget build(BuildContext context) {
    return  RiveAnimation.asset(widget.text);
  }
}