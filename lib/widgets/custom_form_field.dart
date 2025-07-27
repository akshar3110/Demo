import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? prefixIconWidget;
  final TextInputType? keyboardType;
  final bool isRequired;
  final bool readOnly;
  final int maxLines;
  final Color? fillColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const CustomFormField({
    Key? key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.prefixIconWidget,
    this.keyboardType,
    this.isRequired = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.fillColor,
    this.controller,
    this.onChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCDD4DA)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCDD4DA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCDD4DA)),
            ),
            prefixIcon: prefixIconWidget ?? (prefixIcon != null ? Icon(prefixIcon) : null),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              vertical: maxLines > 1 ? 5 : 3,
              horizontal: prefixIcon == null && prefixIconWidget == null ? 20 : 0,
            ),
            isDense: true,
            filled: fillColor != null,
            fillColor: fillColor,
          ),
          style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
        if (isRequired)
          Positioned(
            top: 6,
            right: 8,
            child: Text('*', style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}

class CustomRadioButton<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final Function(T?) onChanged;
  final Color activeColor;

  const CustomRadioButton({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor = const Color(0xFFE7B958),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          activeColor: activeColor,
          groupValue: groupValue,
          onChanged: onChanged,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'SansSerif',
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}