import 'package:flutter/material.dart';
import 'package:maram/constants.dart';

// ignore: must_be_immutable
class CustomizedButton extends StatelessWidget {
  CustomizedButton({
    super.key,
    this.onTap,
    required this.isLoading,
    required this.tittle,
  });
  final void Function()? onTap;
  final String tittle;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .96,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: myGreenColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Text(
                  tittle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomizedButtonWithBorder extends StatelessWidget {
  CustomizedButtonWithBorder({
    super.key,
    this.onTap,
    required this.tittle,
    required this.isLoading,
  });
  final void Function()? onTap;
  final String tittle;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .96,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          border: Border.all(color: myGreenColor, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: myGreenColor,
              ))
            : Center(
                child: Text(
                  tittle,
                  style: const TextStyle(
                    color: myGreenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
