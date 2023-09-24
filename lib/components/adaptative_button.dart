import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final ButtonStyle? style;
  const AdaptativeButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: child,
          )
        : ElevatedButton(
            style: style,
            onPressed: onPressed,
            child: child,
          );
  }
}
