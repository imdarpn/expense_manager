import 'package:flutter/material.dart';

import '../constants/font_constants.dart';
import 'common_text.dart';

class CommonScaffold extends StatelessWidget {
  final bool showAppBar;
  final bool showBackIcon;
  final bool centerTitle;
  final String? label;
  final Color? backgroundColor;
  final Widget? body;
  final Widget? backIconWidget;
  final VoidCallback? onTap;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry bodyPadding;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final Widget? titleWidget;
  final bool showLabel;
  final double? titleSpacing;
  final bool? showActions;
  final Widget? actionsWidgets;

  const CommonScaffold(
      {super.key,
      this.showAppBar = false,
      this.showBackIcon = true,
      this.centerTitle = false,
      this.label = "",
      this.backgroundColor,
      this.onTap,
      this.body,
      this.bottomNavigationBar,
      this.bodyPadding = EdgeInsets.zero,
      this.floatingActionButton,
      this.resizeToAvoidBottomInset,
      this.titleWidget,
      this.showLabel = false,
      this.titleSpacing,
      this.backIconWidget,
      this.showActions = false,
      this.actionsWidgets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: true,
      appBar: showAppBar
          ? AppBar(
              leadingWidth: showBackIcon ? 72 : 0,
              backgroundColor: backgroundColor,
              titleSpacing: titleSpacing,
              scrolledUnderElevation: 0,
              title: showLabel
                  ? CommonText(
                      text: label!,
                      fontFamily: FontFamilyConstants.fontName,
                      fontSize: FontConstants.font_16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    )
                  : titleWidget,
              centerTitle: centerTitle,
              leading: showBackIcon ? backIconWidget : const SizedBox.shrink(),
              actions: [
                showActions! ? actionsWidgets! : Container(),
              ],
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: bodyPadding,
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar != null
          ? SafeArea(child: bottomNavigationBar!)
          : null,
    );
  }
}
