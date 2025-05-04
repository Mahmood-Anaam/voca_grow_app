import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voca_grow_app/features/parent/child_management/child_management.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';

class ChildDetailsPage extends StatelessWidget {
  final ChildModel child;

  const ChildDetailsPage({super.key, required this.child});

  static Route<void> route(ChildModel child) {
    return MaterialPageRoute<void>(
      builder: (_) => ChildDetailsPage(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Child Details')),
      body: ImageOverlayWidget(
        image: const AssetImage(Assets.imagesTopPolygon),
        alignment: Alignment.topLeft,
        child: ImageOverlayWidget(
          image: const AssetImage(Assets.imagesBottomPolygon),
          alignment: Alignment.bottomRight,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 5,
              bottom: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.child_care,
                    size: 100,
                    color: AppTheme.topPolygonColor,
                  ),
                ),
                const VerticalSpace(0.5),
                Text(
                  child.name.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const VerticalSpace(0.5),
                ChildInfoRow(
                  icon: Icons.person_outline,
                  label: 'Gender',
                  value: child.gender.name,
                ),
                ChildInfoRow(
                  icon: Icons.cake_outlined,
                  label: 'Birth Date',
                  value: DateFormat.yMMMMd().format(child.birthDate),
                ),
                ChildInfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: child.email,
                ),
                ChildInfoRow(
                  icon: Icons.lock_outline,
                  label: 'Password',
                  value: child.password,
                ),
                ChildInfoRow(
                  icon: Icons.star_border,
                  label: 'Activities',
                  value: child.availableActivities
                      .map((e) => e.name)
                      .join(', '),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
