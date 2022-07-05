

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _usernameController.dispose();
      _bioController.dispose();
    }

    selectImage() async {
      Uint8List im = await pickImage(ImageSource.gallery);
      setState(() {
        _image = im;
      });
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              'assets/images/ic_instagram.svg',
              color: primaryColor,
              height: 60,
            ),
            SizedBox(
              height: 40,
            ),
            Stack(
              children: [
                _image == null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/564x/6b/73/3a/6b733ac2d55e40544fbdce404d08b2bf.jpg'))
                    : CircleAvatar(
                        radius: 60, backgroundImage: MemoryImage(_image!)),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: Icon(Icons.camera_alt)))
              ],
            ),
            SizedBox(
              height: 64,
            ),
            TextFieldInput(
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
                hintText: 'Enter your Username'),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: 'Enter your Email'),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              isPass: true,
              textInputType: TextInputType.text,
              hintText: 'Enter your Password',
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _bioController,
              textInputType: TextInputType.text,
              hintText: 'Enter your Bio',
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              
              onTap: () async {
                setState(() {
                  _isLoading=true;
                });
                var response = await AuthMethods().signUpUser(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    bio: _bioController.text,
                    file: _image
                    );
                print(response);
                if (response!='success') {
                  showSnackBar(response,context);
                }
                setState(() {
                  _isLoading=false;
                });
              },
              child:_isLoading?CircularProgressIndicator(): Container(
                child: Text('Sign up'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: const ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
            ),
            Flexible(child: Container(), flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Sign up',
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
