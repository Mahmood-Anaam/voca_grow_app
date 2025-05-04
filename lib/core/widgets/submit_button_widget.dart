import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final bool isLoading;
  final VoidCallback? onPressed;

  const SubmitButtonWidget({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        child:
            isLoading
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
                : Text(text),
      ),
    );
  }
}
