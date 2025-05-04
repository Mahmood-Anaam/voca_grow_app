import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/utils/utils.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/auth/auth.dart';

class ResetPasswordPage extends StatelessWidget {
  final UserType userType;
  const ResetPasswordPage({super.key, required this.userType});

  static Route<void> route({required UserType userType}) {
    return MaterialPageRoute<void>(
      builder: (_) => ResetPasswordPage(userType: userType),
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
                        title: 'Reset Password',
                        subtitle:
                            'Enter your email address to receive a password reset link',
                        logo: Image.asset(
                          Assets.imagesHappyMic,
                          width: 100,
                          height: 90,
                        ),
                      ),

                      const VerticalSpace(0.5),

                      // reset password form
                      ResetPasswordForm(
                        onResetPassword: (email) async {
                          context.read<AuthBloc>().add(
                            AuthResetPasswordRequested(
                              email: email,
                              userType: userType,
                              ),
                          );
                        },
                        onBackTap: () {
                          Navigator.pushReplacement(
                            context,
                            SigninPage.route(userType: userType),
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
