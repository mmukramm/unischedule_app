import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/core/utils/keys.dart';
import 'package:unischedule_app/features/presentation/common/register_page.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';
import 'package:unischedule_app/features/presentation/widget/custom_password_text_field.dart';
import 'package:unischedule_app/features/presentation/widget/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                "Login",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              FormBuilder(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      name: 'email',
                      hintText: 'Email',
                      prefixIcon: SvgPicture.asset(
                        AssetPath.getIcons('envelope.svg'),
                        colorFilter: const ColorFilter.mode(
                          primaryTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Bagian ini harus diisi',
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomPasswordTextField(
                      name: 'password',
                      hintText: '********',
                      prefixIcon: SvgPicture.asset(
                        AssetPath.getIcons('lock.svg'),
                        colorFilter: const ColorFilter.mode(
                          primaryTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                          errorText: 'Bagian ini harus diisi',
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 52,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: Text(
                    'Login',
                    style: textTheme.titleMedium!.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Don\'t have an account?',
                style: textTheme.bodyMedium!.copyWith(
                  color: highlightTextColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    navigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: backgroundColor,
                  ),
                  child: Text(
                    'Register',
                    style: textTheme.bodyMedium!.copyWith(
                      color: primaryTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
