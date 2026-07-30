import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class DescriptionField extends StatefulWidget {
  const DescriptionField({super.key});

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  final _controller = TextEditingController();
  int _charCount = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          maxLength: 500,
          maxLines: 4,
          minLines: 4,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText:
                'صف المشكلة بالتفصيل: ما الذي يحدث؟ منذ متى؟ هل حاولت إصلاحه؟',
            hintStyle: TextStyle(
              fontSize: 13,
              color: AppColors.textHint,
            ),
            hintTextDirection: TextDirection.rtl,
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: AppRadius.lgAll,
              borderSide: BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.lgAll,
              borderSide: BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.lgAll,
              borderSide: BorderSide(color: AppColors.primary),
            ),
            counterStyle: TextStyle(
              fontSize: 12,
              color: AppColors.textHint,
            ),
            counter: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '$_charCount/500',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _charCount = value.length;
            });
          },
        ),
      ],
    );
  }
}
