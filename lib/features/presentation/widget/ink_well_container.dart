import 'package:flutter/material.dart';
import 'package:unischedule_app/core/theme/colors.dart';

class InkWellContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? containerBackgroundColor;
  final Color splashColor;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const InkWellContainer({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.containerBackgroundColor,
    this.splashColor = primaryColor,
    this.border,
    this.borderRadiusGeometry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        borderRadius: borderRadiusGeometry,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
