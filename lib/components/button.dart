import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, this.onPressed, required this.buttonLabel})
      : super(key: key);

  final void Function()? onPressed;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Color.lerp(colors.primary, colors.secondary, 0.8);
            }

            return Theme.of(context).colorScheme.secondary;
          },
        ),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: colors.onSecondary,
        ),
      ),
    );
  }
}
