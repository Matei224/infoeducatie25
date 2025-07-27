import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({super.key,required this.func});
  
  void Function() func;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ElevatedButton(

      onPressed: func,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit:BoxFit.cover,
              width:size.width*0.08,
  height:size.height*0.03,
          ) ,
          Text("Log in with Google")],
      ),
    );
  }
}
