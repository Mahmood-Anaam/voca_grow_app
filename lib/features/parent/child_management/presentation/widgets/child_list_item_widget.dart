import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/features/parent/child_management/data/models/models.dart';

class ChildListItemWidget extends StatelessWidget {
  final ChildModel child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const ChildListItemWidget({
    super.key,
    required this.child,
    required this.onEdit,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: SizeConfig.defaultSize! * 2),
        elevation: 4,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                child.gender == Gender.male ? Colors.blue : Colors.pink,
            child: Icon(
              child.gender == Gender.male
                  ? Icons.boy_rounded
                  : Icons.girl_rounded,
              color: Colors.white,
            ),
          ),
          title: Text(
            child.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                child.availableActivities
                    .map((a) => a.name.toUpperCase())
                    .join('-'),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.blueAccent,
                onPressed: () {
                  onEdit();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () {
                  onDelete();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
