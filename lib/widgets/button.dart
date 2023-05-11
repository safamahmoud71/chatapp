import 'package:flutter/material.dart';
class AppButton extends StatelessWidget {
  const AppButton({
    required this.color, required this.title, required this.onPressed

  });
  final Color color;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:  onPressed,
          child: Text('$title',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
          minWidth: 370,


        ),

      ),
    );
  }
}