import 'package:flutter/material.dart';

class LineModel extends StatelessWidget {
  LineModel({super.key,required this.textWidth});
  var textWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.002,
      width: size.width*0.87-textWidth,
      color: const Color.fromARGB(87, 158, 158, 158),
      
    );
  }
}