
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),

                Image.asset(
                  AppConstants.appLogo,
                ),

                const SizedBox(
                  height: 60,
                ),
                Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  return TextFormField(
                    controller: emailController,
                    onChanged: loginProvider.validateEmail,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      errorText: loginProvider.emailError,
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                  return TextFormField(
                    controller: passwordController,
                    onChanged: loginProvider.validatePassword,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      errorText: loginProvider.passwordError,
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 60,
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
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppConstants.blue,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    height: 40,
                    child: Center(
                      child: Text(
                        'Log in',
                        style:
                            TextStyle(fontSize: 16, color: AppConstants.white),
                      ),
                    ),
                  ),
                ),
                 const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppConstants.black,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Text(
                      'or sign in with',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(width: 12),
                    Expanded(
                      child: Divider(
                        color:  AppConstants.black,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialButton(Icons.g_mobiledata),
                    _socialButton(Icons.facebook),
                    _socialButton(Icons.flutter_dash),
                    _socialButton(Icons.apple),
                  ],
                ),
                 const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Text(
                      "Don't have an account?",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppConstants.black,
                      ),
                    ),
                   Text(
                      "Regoster",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppConstants.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _socialButton(IconData icon) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black54,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(
      icon,
      size: 28,
      color: Colors.black87,
    ),
  );
}
}
