import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/features/auth/auth.dart';
import 'package:voca_grow_app/features/parent/home/home.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/parent/child_management/child_management.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    // List of feature cards
    final featureCards = [
      FeatureCard(
        icon: Icons.child_care,
        title: 'Manage Children',
        description: 'Add and manage child profiles',
        onTap: () {
          Navigator.push(context, ChildrenListPage.route(context));
        },
      ),

      FeatureCard(
        icon: Icons.assessment,
        title: 'Track Progress',
        description: 'Monitor speech development',
        onTap: () {},
      ),
      FeatureCard(
        icon: Icons.logout,
        title: 'Logout',
        description: 'Sign out of the app',
        onTap: () {
          context.read<AuthBloc>().add(AuthSignOutRequested());
        },
      ),
      FeatureCard(
        icon: Icons.help_outline,
        title: 'Support',
        description: 'Get help and resources',
        onTap: () {},
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          margin: const EdgeInsets.only(top: 50),

          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: Image.asset(
                        Assets.imagesHappyMic,
                        width: 80,
                        height: 80,
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final name =
                                  state is AuthAuthenticated
                                      ? state.user.name
                                      : 'Parent';
                              return Text(
                                'Welcome, $name!',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                ),
                              );
                            },
                          ),
                          const VerticalSpace(0.5),
                          Text(
                            'Manage and track your child\'s speech development journey',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const VerticalSpace(0.5),

              // Features Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1,
                    ),

                    itemCount: featureCards.length,
                    itemBuilder: (context, index) {
                      return featureCards[index];
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
