import 'package:flutter/material.dart';
import '../routes.dart/route.dart';
import 'more_infoscreen.dart';


class CustomTextFieldButton extends StatefulWidget {
  const CustomTextFieldButton({Key? key}) : super(key: key);

  @override
  _CustomTextFieldButtonState createState() => _CustomTextFieldButtonState();
}

class _CustomTextFieldButtonState extends State<CustomTextFieldButton> {
 final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTextFormField(
          controller: _nameController,
          hintText: 'Name',
        ),
        SizedBox(height: 10),
        buildTextFormField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 10),
        buildTextFormField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_validate()) {
               // Save user information
            PageRouting.goToNextPage(context: context, navigateTo: MoreInformationScreen(name: _nameController.text,
            email: _emailController.text, password:_passwordController.text,
            ));
            }
          },
          child: Text('Next'),
        ),
      ],
    );
  }

  TextFormField buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: (String? value) {
        if (value?.isEmpty ?? false) {
          return "Enter $hintText";
        }
        return null;
      },
    );
  }

  bool _validate() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Please provide all required information');
      return false;
    }
    if (!_isValidEmail(_emailController.text)) {
      _showSnackBar('Please enter a valid email address');
      return false;
    }

    return true;
  }

  bool _isValidEmail(String email) {
    return email.contains('@');
  }



  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
    _emailController.clear();
    _nameController.clear();
    _passwordController.clear();
  }
}
