import 'package:flutter/material.dart';
import 'package:getx_mvvm/resources/components/round_button_widget.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onTap;
  const InternetExceptionWidget({super.key, required this.onTap});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off,
              color: Colors.red,
              size: 25,
            ),
            Text(
              "No internet\nplease check your internet connection",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: RoundButtonWidget(
                onPressed: () => widget.onTap(),
                title: "Retry",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
