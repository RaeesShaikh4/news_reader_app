

import 'package:flutter/material.dart';

class CustomizeDrawerScreen extends StatelessWidget {
  final String? email;
  final VoidCallback isLoggedOutTapped;
  final VoidCallback toBookMarkScreen;
  final VoidCallback toHomeScreen;
  const CustomizeDrawerScreen(this.email, this.isLoggedOutTapped, this.toBookMarkScreen, this.toHomeScreen);

  @override
  Widget build(BuildContext context) {
    print('email $email');
    return  Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
          Material(
            color: Colors.blueAccent,
            child: InkWell(
              onTap: (){
    
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    bottom: 24
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60' 
                      ),
                    ), 
                     Text( email ?? '',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),),
    
                  ],
                ),
              ),
            ),
          ),
     
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: (){
                  toHomeScreen();
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Bookmarks'),
                onTap: (){  
                  toBookMarkScreen();
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications_outlined),
                title: Text('Log out'),
                onTap: () {
                  print('drawer logout clalled');

                  isLoggedOutTapped();
                }
                
              ),
            ],
          )
        ],
      ),
    )
    );
    
        
  }
}