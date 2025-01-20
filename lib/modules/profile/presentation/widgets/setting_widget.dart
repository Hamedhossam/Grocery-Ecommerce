import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maram/constants.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.chevron_left_circle,
              size: 30,
            ),
            const Spacer(
              flex: 8,
            ),
            Text(
              title,
              style: labelStyle?.copyWith(fontSize: 18),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
