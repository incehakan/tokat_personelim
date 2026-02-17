import 'package:flutter/material.dart';

import '../../product/constants/app_dimensions.dart';

class TextFieldWithBorder extends StatelessWidget {
  const TextFieldWithBorder({
    Key? key,
    this.onTap,
    this.controller,
    required this.hintText,
    this.readOnly = false,
    this.onChanged,
    this.maxLines,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String hintText;
  final bool readOnly;
  final Function(String?)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        } else {
          return null;
        }
      },
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
      onTap: () {
        if (onTap != null) onTap!();
      },
      controller: controller,
      readOnly: readOnly,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: AppDimensions.buttonRadius,
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.buttonRadius,
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
