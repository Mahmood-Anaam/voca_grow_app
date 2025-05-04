import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/parent/child_management/child_management.dart';
import 'package:voca_grow_app/features/parent/home/home.dart';
import 'package:voca_grow_app/features/auth/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(body: Center(child: Text("Unauthorized")));
    }

    final userParent = authState.user;

    return RepositoryProvider(
      create: (context) => ChildRepository(userParent: userParent),
      child: BlocProvider(
        create:
            (context) =>
                ChildBloc(childRepository: context.read<ChildRepository>()),
        child: SafeArea(
          child: Scaffold(
            body: ImageOverlayWidget(
              image: const AssetImage(Assets.imagesTopPolygon),
              alignment: Alignment.topLeft,
              child: const HomeBody(),
            ),
            bottomNavigationBar: ConvexButton.fab(
              icon: Icons.home,
              backgroundColor: AppColors.bottomPolygonColor,
              color: AppColors.topPolygonColor,
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
