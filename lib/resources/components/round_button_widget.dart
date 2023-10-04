import 'package:flutter/material.dart';

class RoundButtonWidget extends StatelessWidget {
  final String title;
  final double height, width;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color textColor, buttonColor;
  const RoundButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.height = 45,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: buttonColor,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: 35,width: 35,
                  child: CircularProgressIndicator(
                    color: Colors.white
                  ),
                ),
              )
            : Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: textColor),
                ),
              ),
      ),
    );
  }
}
