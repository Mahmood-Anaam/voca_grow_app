import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/auth/auth.dart';

class SigninPage extends StatelessWidget {
  final UserType userType;
  const SigninPage({super.key, required this.userType});

  static Route<void> route({required UserType userType}) {
    return MaterialPageRoute<void>(
      builder: (_) => SigninPage(userType: userType),
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
                        title: 'Welcome Back',
                        subtitle: 'Please sign in to continue',
                        logo: Image.asset(
                          Assets.imagesHappyMic,
                          width: 100,
                          height: 90,
                        ),
                      ),

                      const VerticalSpace(0.5),

                      // sign in form
                      SigninForm(
                        userType: userType,
                        onSignIn: (email, password) async {
                          context.read<AuthBloc>().add(
                            AuthSignInRequested(
                              email: email,
                              password: password,
                              userType: userType,
                            ),
                          );
                        },
                        onSignUpTap: () {
                          Navigator.pushReplacement(
                            context,
                            SignupPage.route(),
                          );
                        },
                        onForgotPasswordTap: () {
                          Navigator.pushReplacement(
                            context,
                            ResetPasswordPage.route(userType: userType),
                          );
                        },
                        onBackTap: () {
                          Navigator.pushReplacement(
                            context,
                            UserTypePage.route(),
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
