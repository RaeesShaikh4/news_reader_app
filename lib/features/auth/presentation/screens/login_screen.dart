
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader_app/core/constant/app_constants.dart';
import 'package:news_reader_app/core/utils/routes.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/main.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(fontSize: 22, color: AppConstants.blue),
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  return TextFormField(
                    controller: emailController,
                    onChanged: loginProvider.validateEmail,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      errorText: loginProvider.emailError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  return TextFormField(
                    controller: passwordController,
                    onChanged: loginProvider.validatePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      errorText: loginProvider.passwordError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    final success = await loginProvider.login(
                        email: emailController.text,
                        passowrd: passwordController.text);
                        RestartWidget.restartApp(context);

                    if (success == true) {
                      // Clear previous user's in-memory bookmarks before navigating
                      if (context.mounted) {
                        context.read<BookMarkProvider>().clearBookmarks();
                      }
                      context.go('/home');
                    }
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: AppConstants.blue,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    height: 50,
                    child: Center(
                      child: Text(
                        'Log in',
                        style:
                            TextStyle(fontSize: 16, color: AppConstants.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
