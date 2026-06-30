import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader_app/core/constant/app_constants.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

// enum DrawerItem { hone, bookmark, wallstreet }

class CustomizeDrawerScreen extends StatefulWidget {
  final VoidCallback isLoggedOutTapped;
  // final VoidCallback toBookMarkScreen;
  // final VoidCallback toWallStreetHJournal;
  // final VoidCallback toHomeScreen;
  // final DrawerItem selectedItem;

  const CustomizeDrawerScreen({
    required this.isLoggedOutTapped,
    // required this.toBookMarkScreen,
    // required this.toWallStreetHJournal,
    // required this.toHomeScreen,
    // required this.selectedItem,
  });

  @override
  State<CustomizeDrawerScreen> createState() => _CustomizeDrawerScreenState();
}

class _CustomizeDrawerScreenState extends State<CustomizeDrawerScreen> {
  String email = '';

  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  Future<void> loadEmail() async {
    final result = await context.read<LoginProvider>().setUserName();
    setState(() {
      email = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isHome = location == '/home';
    final isBookmark = location == '/bookmark';
    final isWallstreet = location == '/wallStreel';

    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 40,
                bottom: 24,
                left: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  email ?? '',
                  style: TextStyle(fontSize: 18, color: AppConstants.black),
                ),
              ],
            ),
          ),
          Column(
            children: [
              drawerTile(
                icon: Icons.home_outlined,
                title: 'Home',
                isSelected: isHome,
                onTap: () {
                  context.go('/home');
                  Navigator.pop(context);
                },
              ),
              drawerTile(
                icon: Icons.bookmark,
                title: 'Bookmarks',
                isSelected: isBookmark,
                onTap: () {
                  context.go('/bookmark');
                  Navigator.pop(context);
                },
              ),
              drawerTile(
                icon: Icons.currency_pound,
                title: 'WallStreet',
                isSelected: isWallstreet,
                onTap: () {
                  context.go('/wallStreel');
                  Navigator.pop(context);
                },
              ),
              drawerTile(
                icon: Icons.logout,
                title: 'Log out',
                isSelected: false,
                onTap: () {
                  Navigator.pop(context);
                  widget.isLoggedOutTapped();
                },
              ),
            ],
          )
        ],
      ),
    ));
  }

  Widget drawerTile({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppConstants.white : AppConstants.black,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppConstants.white : AppConstants.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppConstants.blue6759FF,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: onTap,
      ),
    );
  }
}
