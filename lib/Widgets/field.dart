import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  const FieldWidget({super.key, required this.label, required this.controller, this.validator, this.onTap});

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAEF07),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 5.0,
            spreadRadius: 1,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
