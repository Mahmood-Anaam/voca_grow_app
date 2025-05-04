import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/parent/child_management/child_management.dart';

class ChildrenListPage extends StatefulWidget {
  const ChildrenListPage({super.key});

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute<void>(
      builder:
          (_) => RepositoryProvider.value(
            value: context.read<ChildRepository>(),
            child: BlocProvider.value(
              value: context.read<ChildBloc>(),
              child: const ChildrenListPage(),
            ),
          ),
    );
  }

  @override
  State<ChildrenListPage> createState() => _ChildrenListPageState();
}

class _ChildrenListPageState extends State<ChildrenListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChildBloc>().add(LoadChildren());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Children")),
      body: ImageOverlayWidget(
        image: const AssetImage(Assets.imagesTopPolygon),
        alignment: Alignment.topLeft,
        child: ImageOverlayWidget(
          image: const AssetImage(Assets.imagesBottomPolygon),
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 50,
              bottom: 50,
            ),
            child: BlocBuilder<ChildBloc, ChildState>(
              builder: (context, state) {
                if (state is ChildLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChildLoaded) {
                  final children = state.children;
                  if (children.isEmpty) {
                    return ChildEmptyStateWidget(
                      onAddChild: () {
                        Navigator.push(
                          context,
                          AddEditChildPage.route(context),
                        );
                      },
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(SizeConfig.defaultSize! * 2),
                    itemCount: state.children.length,

                    itemBuilder: (context, index) {
                      final child = children[index];
                      return ChildListItemWidget(
                        child: child,
                        onEdit: () {
                          Navigator.push(
                            context,
                            AddEditChildPage.route(
                              context,
                              existingChild: child,
                            ),
                          );
                        },
                        onDelete: () {
                          context.read<ChildBloc>().add(
                            DeleteChild(childId: child.id),
                          );
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            ChildDetailsPage.route(child),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ChildError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.topPolygonColor,
        onPressed: () {
          Navigator.push(context, AddEditChildPage.route(context));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
