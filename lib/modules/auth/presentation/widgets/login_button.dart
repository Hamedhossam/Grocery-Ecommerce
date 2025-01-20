import 'package:flutter/material.dart';
import 'package:maram/constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.onTap,
    required this.tittle,
    required this.icon,
  });
  final void Function()? onTap;
  final String tittle;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .96,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              tittle,
              style: labelStyle,
            ),
          ],
        ),
      ),
    );
  }
}
