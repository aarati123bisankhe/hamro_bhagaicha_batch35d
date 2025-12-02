import 'package:flutter/material.dart';

class FloatingButtonAction extends StatelessWidget {
  const FloatingButtonAction({
    super.key,
    required this.label,
    this.VoidCallbackAction,
  });

  final String label;
  final VoidCallbackAction;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: const Color(050925),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
