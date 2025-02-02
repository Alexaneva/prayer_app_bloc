import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app_widgets/app_colors.dart';
import '../../app_widgets/app_images.dart';
import '../../app_widgets/custom_button.dart';
import '../../app_widgets/typography.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';
import 'package:prayer_bloc/screens/authorisation/widgets/auth_input_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              context.go('/main-screen');
            } else if (state.status == AuthStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? 'Registration failed')),
              );
            }
          },
          child: Column(
          children: [
               Flexible(
                 flex: 1,
                 child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.backGround),
                      fit: BoxFit.cover,
                    ),
                  ),
                 ),
               ),
            Flexible(
             flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Registration',
                        style: AppTypography.heading1,
                      ),
                      CustomInputField(
                        controller: AuthTextEditingControllers.signUpName,
                        labelText: 'Name',
                        fieldType: FieldType.name,
                        isObscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        controller: AuthTextEditingControllers.signUpEmail,
                        labelText: 'Email',
                        fieldType: FieldType.email,
                        isObscureText: false,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        controller: AuthTextEditingControllers.signUpPassword,
                        labelText: 'Password',
                        fieldType: FieldType.password,
                      ),
                      SizedBox(height: 10),
                      CustomInputField(
                        controller:
                            AuthTextEditingControllers.signUpConfirmPassword,
                        labelText: 'Confirm password',
                        fieldType: FieldType.confirmPassword,
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: 'Register',
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthEvent(
                                            email: AuthTextEditingControllers
                                                .signUpEmail.text,
                                            password: AuthTextEditingControllers
                                                .signUpPassword.text,
                                            name: AuthTextEditingControllers
                                                .signUpName.text));
                            },
                            backgroundColor:
                            AuthTextEditingControllers.isSignInFormFilled
                                ? AppColors.grayScale800
                                : AppColors.grayScale300,
                            foregroundColor: AppColors.grayScale100,

                          );
                        },
                      ),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => context.go('/sign-in'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?",
                                    style: TextStyle(color: AppColors.grayScale800)),
                                const Text(" Sign in",
                                    style: TextStyle(color: AppColors.error)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
