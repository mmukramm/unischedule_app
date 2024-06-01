import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String name, hintText;
  final String? labelText;
  final bool isRequired;
  final int maxLines;
  final TextAlign labelTextAlign;
  final List<String? Function(String?)>? validators;

  const CustomTextField({
    super.key,
    required this.name,
    this.labelText,
    this.isRequired = true,
    this.maxLines = 1,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null)
          RichText(
            textAlign: labelTextAlign,
            text: TextSpan(
              style: textTheme.bodyMedium,
              children: [
                TextSpan(text: labelText),
                if (isRequired)
                  const TextSpan(
                    text: '*',
                    style: TextStyle(color: dangerColor),
                  ),
              ],
            ),
          ),
        FormBuilderTextField(
          name: name,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.bodyMedium!.copyWith(
              color: highlightTextColor,
            ),
            contentPadding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
          ),
          style: textTheme.bodyMedium!.copyWith(
            color: primaryTextColor,
          ),
          cursorColor: secondaryTextColor,
          maxLines: maxLines,
          validator: validators != null
              ? FormBuilderValidators.compose(validators!)
              : null,
        ),
      ],
    );
  }
}
