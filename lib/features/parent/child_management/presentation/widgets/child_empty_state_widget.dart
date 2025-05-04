import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';

class ChildEmptyStateWidget extends StatelessWidget {
  final VoidCallback onAddChild;

  const ChildEmptyStateWidget({super.key, required this.onAddChild});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.child_care, size: 100, color: AppTheme.topPolygonColor),
          const VerticalSpace(0.3),
          Text(
            'No children added yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const VerticalSpace(0.3),
          ElevatedButton(
            onPressed: onAddChild,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.topPolygonColor,
            ),
            child: const Text('Add First Child'),
          ),
        ],
      ),
    );
  }
}
