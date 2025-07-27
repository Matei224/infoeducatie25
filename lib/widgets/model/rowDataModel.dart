import 'package:flutter/material.dart';
import 'package:studee_app/widgets/model/dataTextModel.dart';

class RowDataModel extends StatelessWidget {
  RowDataModel({super.key,required this.icon,required this.text,this.data,required this.colorTitle});
  Icon icon;
  final text;
  Color colorTitle;

  String? data;
  @override
  Widget build(BuildContext context) {
    return Row (
      children: [
        Expanded(child: Row(spacing:5.0,children: [
           icon, DataTextModel(text: text, colorTitle: colorTitle,data: data,),
        ],)),
         Text( 
          data == '' || data == ' ' || data == null ?
          'Not found' : data!
       ),
      ],
    );
  }
}