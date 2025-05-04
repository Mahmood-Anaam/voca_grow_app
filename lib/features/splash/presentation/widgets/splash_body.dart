import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/utils/utils.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesSplash),
          alignment: Alignment.center,
          repeat: ImageRepeat.repeat,
        ),
      ),
    );
  }
}
