import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/features/auth/auth.dart';
import 'package:voca_grow_app/features/child/activities/activities.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/child/characters/characters.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ActivitiesPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activities'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOutRequested());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: ImageOverlayWidget(
          image: const AssetImage(Assets.imagesTopPolygon),
          alignment: Alignment.topLeft,
          child: ImageOverlayWidget(
            image: const AssetImage(Assets.imagesBottomPolygon),
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: HeaderBoxWidget(
                    title: 'Welcome to Activities',
                    subtitle:
                        'Activities are fun and educational tasks that help you learn and grow.',
                    imagePath: Assets.imagesHappyMic,
                  ),
                ),

                const VerticalSpace(0.5),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.8,
                        ),

                        itemCount: listActivtes.length,
                        itemBuilder: (context, index) {
                          final activite = listActivtes[index];
                          return CardWidget(
                            imagePath: activite.imagePath,
                            title: activite.name,
                            description: activite.description,
                            onTap: () {
                              Navigator.push(
                                context,
                                CharacterSelectionPage.route(
                                  activitie: activite,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
