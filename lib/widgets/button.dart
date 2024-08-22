import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPress;
  bool? isColor;

  ButtonWidget({super.key, required this.title, this.onPress, this.isColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            backgroundColor: const MaterialStatePropertyAll(Colors.black)),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
