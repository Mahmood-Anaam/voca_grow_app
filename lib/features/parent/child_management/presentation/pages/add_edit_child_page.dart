import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/features/parent/child_management/child_management.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';

class AddEditChildPage extends StatelessWidget {
  final ChildModel? existingChild;

  const AddEditChildPage({super.key, this.existingChild});

  static Route<void> route(BuildContext context, {ChildModel? existingChild}) {
    return MaterialPageRoute<void>(
      builder:
          (_) => RepositoryProvider.value(
            value: context.read<ChildRepository>(),
            child: BlocProvider.value(
              value: context.read<ChildBloc>(),
              child: AddEditChildPage(existingChild: existingChild),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = existingChild != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Child' : 'Add Child')),

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
              top: 100,
              bottom: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChildForm(
                  initialData: existingChild,
                  onSubmit: (child) {
                    if (isEditing) {
                      context.read<ChildBloc>().add(UpdateChild(child: child));
                    } else {
                      context.read<ChildBloc>().add(AddChild(child: child));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
