import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({
    super.key,
    required this.screen,
    required this.title,
    required this.data,
    this.description,
  });
  final ResponsiveScreen screen;
  final String title;
  final String data;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: screen.context.theme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 100,
      padding: EdgeInsets.only(
        top: 12,
        bottom: 16,
        right: Get.width * 0.015,
        left: Get.width * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: screen.context.theme.colorScheme.tertiary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data,
                style: TextStyle(
                  fontSize: screen.isDesktop ? 26 : 22,
                  fontWeight: FontWeight.w700,
                  height: screen.isDesktop ? 0.6 : 1,
                  color: screen.context.theme.colorScheme.secondary,
                ),
              ),
              screen.isDesktop ? description ?? Container() : Container(),
            ],
          )
        ],
      ),
    );
  }
}
