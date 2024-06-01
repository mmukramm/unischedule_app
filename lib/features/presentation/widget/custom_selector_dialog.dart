import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/widget/ink_well_container.dart';

class SelectorDialogParams {
  final String label;
  final VoidCallback onTap;

  SelectorDialogParams({
    required this.label,
    required this.onTap,
  });
}

class CustomSelectorDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<SelectorDialogParams> items;

  const CustomSelectorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.items,
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
                padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: textTheme.headlineSmall!.copyWith(
                          fontSize: 20,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        navigatorKey.currentState!.pop();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: dangerColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      icon: const Icon(
                        Icons.close,
                        color: scaffoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return SizedBox(
                        width: double.infinity,
                        child: InkWellContainer(
                          border: Border.all(
                            color: primaryColor,
                            width: 2,
                          ),
                          containerBackgroundColor: backgroundColor,
                          padding: const EdgeInsets.all(12),
                          onTap: item.onTap,
                          child: Center(
                            child: Text(
                              item.label,
                              style: textTheme.titleMedium!.copyWith(
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 12,
                      );
                    },
                    itemCount: items.length,
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
