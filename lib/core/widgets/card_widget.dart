import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';

class CardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Color? color;
  final VoidCallback onTap;

  const CardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(imagePath),
              ),
              const VerticalSpace(0.5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(0.5),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
