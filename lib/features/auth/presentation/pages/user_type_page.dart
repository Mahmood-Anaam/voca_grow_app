import 'package:flutter/material.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/auth/auth.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UserTypePage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ImageOverlayWidget(
          image: AssetImage(Assets.imagesTopPolygon),
          alignment: Alignment.topLeft,
          child: ImageOverlayWidget(
            image: AssetImage(Assets.imagesBottomPolygon),
            alignment: Alignment.bottomRight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AuthHeader(
                      title: 'Who is with us?',
                      subtitle: 'please click on the button below',
                      logo: Image.asset(
                        Assets.imagesHappyMic,
                        width: 100,
                        height: 100,
                      ),
                    ),

                    const VerticalSpace(3),

                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 700,
                        minWidth: 400,
                        minHeight: 50,
                        maxHeight: 50,
                      ),
                      child: SubmitButtonWidget(
                        text: "Child",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            SigninPage.route(userType: UserType.child),
                          );
                        },
                      ),
                    ),
                    const VerticalSpace(3),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 700,
                        minWidth: 400,
                        minHeight: 50,
                        maxHeight: 50,
                      ),
                      child: SubmitButtonWidget(
                        text: "Child's Parent",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            SigninPage.route(userType: UserType.parent),
                          );
                        },
                      ),
                    ),
                    const VerticalSpace(3),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Previous'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
