import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user_model.dart';

class UserListShow extends StatefulWidget {
  const UserListShow({Key? key}) : super(key: key);

  @override
  State<UserListShow> createState() => _UserListShowState();
}

class _UserListShowState extends State<UserListShow> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<UserDetailsModel>('user');

    return Scaffold(
      appBar: AppBar(
        title: Text('All User List'),
        backgroundColor: Colors.teal[200],
      ),
      body: ListenableBuilder(
        listenable: box.listenable(),
        builder: (context, child) => ListView.builder(
          itemBuilder: (context, index) {
            final users = box.values.toList();
            return Card(
              color: Colors.indigo[300],
              margin: EdgeInsets.all(15),
              child: ListTile(
                leading: ClipOval(
                  child:users[index].image == null? Icon(Icons.person): Image.file(File(users[index].image.toString()),height: 60,width: 60,fit: BoxFit.cover,),
                  
                ),
                title: Text(users[index].name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(users[index].email),
                    Text(users[index].address),
                    Text(users[index].nId),
                    Text(users[index].bloodgroup),
                    Text(users[index].mobilenumber),
                  ],
                ),
                
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(context, index),
                ),
              ),
            );
          },
          itemCount: box.values.toList().length,
        ),
      ),
    );
  }

  void _deleteItem(BuildContext context, int index) {
    var box = Hive.box<UserDetailsModel>('user');
    box.deleteAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User deleted successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
