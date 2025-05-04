import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/auth/auth.dart';

class SignupPage extends StatelessWidget {
  final UserType userType;
  const SignupPage({super.key, this.userType = UserType.parent});

  static Route<void> route({UserType userType = UserType.parent}) {
    return MaterialPageRoute<void>(
      builder: (_) => SignupPage(userType: userType),
    );
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // auth header
                      AuthHeader(
                        title: 'Create Account',
                        subtitle: 'Please fill in the form to continue',
                        logo: Image.asset(
                          Assets.imagesHappyMic,
                          width: 100,
                          height: 90,
                        ),
                      ),

                      const VerticalSpace(0.5),

                      // sign up form
                      SignupForm(
                        onSignUp: (email, password, name) async {
                          context.read<AuthBloc>().add(
                            AuthSignUpRequested(
                              email: email,
                              password: password,
                              name: name,
                              userType: userType,
                            ),
                          );
                        },
                        onSignInTap: () {
                          Navigator.pushReplacement(
                            context,
                            SigninPage.route(userType: UserType.parent),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
