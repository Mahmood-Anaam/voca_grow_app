import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:voca_grow_app/features/auth/auth.dart';

class SigninForm extends StatefulWidget {
  final UserType userType;
  final Function(String email, String password)? onSignIn;
  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotPasswordTap;
  final VoidCallback? onBackTap;

  const SigninForm({
    super.key,
    required this.userType,
    this.onSignIn,
    this.onSignUpTap,
    this.onForgotPasswordTap,
    this.onBackTap,
  });

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(1),
                  TextFormField(
                    controller: _passwordController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(0.5),
                  TextButton(
                    onPressed: widget.onForgotPasswordTap,
                    child: Text('Forgot Password?'),
                  ),
                  const VerticalSpace(0.5),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return SubmitButtonWidget(
                        text: 'Sign In',
                        isLoading: state is AuthLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await widget.onSignIn?.call(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          }
                        },
                      );
                    },
                  ),

                  const VerticalSpace(0.5),
                  if (widget.userType == UserType.parent)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            TextButton(
                              onPressed: widget.onSignUpTap,
                              style: Theme.of(
                                context,
                              ).textButtonTheme.style?.copyWith(
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 0),
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  TextButton(
                    onPressed: widget.onBackTap,
                    child: Text('Previous'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
