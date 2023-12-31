import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../routes.dart/route.dart';
import 'homescreen.dart';
import 'user_model.dart';

class MoreInformationScreen extends StatefulWidget {
   final String name;
  final String email;
  final String password;
  const MoreInformationScreen({Key? key,
   required this.name, 
   required this.email, 
   required this.password}) : super(key: key);

  @override
  _MoreInformationScreenState createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nIdController = TextEditingController();
  File? _selectedImage;


  Future<void> _saveUserData() async {
  var user = UserDetailsModel(
    name:widget.name,
    email:widget.email,
    password:widget.password,
    address: _addressController.text,
    bloodgroup: _bloodGroupController.text,
    mobilenumber:_mobileController.text,
    nId: _nIdController.text,
    image: _selectedImage ==null?null:_selectedImage!.path.toString()  
  );

  var box =  Hive.box<UserDetailsModel>('user'); 
  box.add(user);
}

  Future _pickImageFromCamera() async {
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (returnedImage == null) {
    print('User canceled image selection');
    return;
  }
  print('Selected image path: ${returnedImage.path}');
  setState(() {
    _selectedImage = File(returnedImage.path);
    print(_selectedImage!.path.toString());
  });
  print('Set _selectedImage: $_selectedImage');
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('More Information',style: TextStyle(color:Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImageFromCamera();
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.indigo[300],
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                      child: _selectedImage == null ? null : null, // No need for an Icon here
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:15.0),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _bloodGroupController,
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nIdController,
                decoration: InputDecoration(
                  labelText: 'Nid Number',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle mobile number addition to the list
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveUserData();
                  _addressController.clear();
                  _mobileController.clear();
                  _bloodGroupController.clear();
                 _nIdController.clear();
                 
                  PageRouting.goToNextPage(context: context, navigateTo: HomeScreen());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
