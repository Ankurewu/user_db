import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_button/custom_button.dart';
import '../routes.dart/route.dart';
import 'user_infoscreen.dart';
import 'userlistshow_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Row(
        children: [
          MyButton(
            
            iconData: Icons.add,
             buttonText: 'Add Information',
             onTap: () {
               PageRouting.goToNextPage(context: context, navigateTo: UserInfo());
             },
             ),
              SizedBox(
              width: 70,),
              MyButton(
                iconData: Icons.person_4,
                buttonText:'User List',
                onTap: (){
                  PageRouting.goToNextPage(context: context, navigateTo: UserListShow());
                },
                )
        ],
      ),
    );
  }
}
