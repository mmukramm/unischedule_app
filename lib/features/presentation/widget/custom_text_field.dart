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
  final bool readOnly;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign labelTextAlign;
  final TextInputType? textInputType;
  final List<String? Function(String?)>? validators;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.name,
    this.labelText,
    this.isRequired = true,
    this.maxLines = 1,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
    this.textInputType,
    this.validators,
    this.onTap,
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
          keyboardType: textInputType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
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
          readOnly: readOnly,
          validator: validators != null
              ? FormBuilderValidators.compose(validators!)
              : null,
          onTap: onTap,
        ),
      ],
    );
  }
}
