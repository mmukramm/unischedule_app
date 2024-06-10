import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String name, hintText;
  final String? labelText;
  final bool isRequired;
  final int maxLines;
  final bool readOnly;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign labelTextAlign;
  final TextInputType? textInputType;
  final List<String? Function(String?)>? validators;
  final Function(String?)? onChanged;
  final VoidCallback? onTap;

  const CustomPasswordTextField({
    super.key,
    required this.name,
    this.labelText,
    this.isRequired = true,
    this.maxLines = 1,
    this.readOnly = false,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
    this.textInputType,
    this.validators,
    this.onChanged,
    this.onTap,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  late final ValueNotifier<bool> isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = ValueNotifier(true);
  }

  @override
  void dispose() {
    super.dispose();
    isVisible.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelText != null)
          RichText(
            textAlign: widget.labelTextAlign,
            text: TextSpan(
              style: textTheme.bodyMedium,
              children: [
                TextSpan(text: widget.labelText),
                if (widget.isRequired)
                  const TextSpan(
                    text: '*',
                    style: TextStyle(color: dangerColor),
                  ),
              ],
            ),
          ),
        ValueListenableBuilder(
          valueListenable: isVisible,
          builder: (context, value, _) {
            return FormBuilderTextField(
              name: widget.name,
              obscureText: value,
              keyboardType: widget.textInputType,
              textInputAction: widget.textInputAction,
              textCapitalization: widget.textCapitalization,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: textTheme.bodyMedium!.copyWith(
                  color: highlightTextColor,
                ),
                contentPadding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: widget.prefixIcon,
                      )
                    : null,
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    value
                        ? AssetPath.getIcons('eye-off.svg')
                        : AssetPath.getIcons('eye.svg'),
                    colorFilter: const ColorFilter.mode(
                      primaryTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    isVisible.value = !value;
                  },
                ),
              ),
              onChanged: widget.onChanged,
              style: textTheme.bodyMedium!.copyWith(
                color: primaryTextColor,
              ),
              cursorColor: secondaryTextColor,
              maxLines: widget.maxLines,
              readOnly: widget.readOnly,
              validator: widget.validators != null
                  ? FormBuilderValidators.compose(widget.validators!)
                  : null,
              onTap: widget.onTap,
            );
          },
        ),
      ],
    );
  }
}
