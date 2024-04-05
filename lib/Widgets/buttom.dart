import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final String? text;
  final double? size;
  const ButtonWidget({super.key, this.onPressed, this.text, this.size});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: _isPressed
          ? Matrix4.translationValues(0, 10, 0)
          : Matrix4.translationValues(0, 0, 0),
      decoration: BoxDecoration(
        border: BoxBorder.lerp(
          Border.all(color: const Color(0xFF1766a6), width: 2),
          Border.all(color: const Color(0xFF0c3659), width: 2),
          0.5,
        ),
        color: const Color(0xFFFAEF07),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 5.0,
            spreadRadius: 1,
            offset: const Offset(4, 7),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _isPressed = !_isPressed;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              _isPressed = !_isPressed;
            });
          });
          widget.onPressed!();
        },
        child: Text(
          widget.text ?? 'Button',
          style: TextStyle(
            color: Colors.black,
            fontSize: widget.size ?? 16,
          ),
        ),
      ),
    );
  }
}
