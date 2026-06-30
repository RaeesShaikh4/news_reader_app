import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/features/home/presentation/screens/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {
  final Widget child;
  const DashBoardScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    return Scaffold(
      appBar: AppBar(title: Text(getPageTitle(location))),
      drawer: CustomizeDrawerScreen(
        isLoggedOutTapped: () => logOut(context),
      ),
      body: child,
    );
  }

  String getPageTitle(String location) {
    switch (location) {
      case '/home':
        return 'Home';
      case '/bookmark':
        return 'Bookmarks';
      case '/wallStreel':
        return 'WallStreet';
      default:
        return 'News Reader';
    }
  }

  void logOut(BuildContext context) async {
    final result = await context.read<LoginProvider>().logout();
    if (result == true) {
      context.read<BookMarkProvider>().clearBookmarks();
      context.go('/login');
    }
  }
}
