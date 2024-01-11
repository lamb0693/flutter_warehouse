import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String strText;
  final IconData iconData;
  final VoidCallback callback;
  const LoginButton({required this.strText, required this.iconData,
    required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: ElevatedButton(
          onPressed: () {  },
          child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : [
                Icon(iconData),
                Text(strText),
              ]
          )
      ),
    );
  }
}
