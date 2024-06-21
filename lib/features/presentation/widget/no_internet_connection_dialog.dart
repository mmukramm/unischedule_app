import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';

class NoInternetConnectionDialog extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonText;
  final bool withCloseButton;
  final VoidCallback onTapPrimaryButton;

  const NoInternetConnectionDialog({
    super.key,
    required this.title,
    required this.message,
    this.withCloseButton = true,
    required this.onTapPrimaryButton,
    required this.primaryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: scaffoldColor,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 32,
      ),
      shape: const RoundedRectangleBorder(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium!.copyWith(
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetPath.getSvg('no-internet.svg'),
                    height: 240,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onTapPrimaryButton,
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: Text(
                        primaryButtonText,
                        style: textTheme.titleMedium!
                            .copyWith(color: secondaryTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
