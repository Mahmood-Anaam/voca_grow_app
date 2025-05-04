import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';

class HeaderBoxWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final Color? backgroundColor;
  const HeaderBoxWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.imagePath,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagePath != null
                ? Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: ClipOval(
                      child: Image.asset(
                        imagePath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                : SizedBox.shrink(),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
            
                      fontSize: 20,
                    ),
                  ),
            
                  const VerticalSpace(0.5),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
