import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
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
              height: 64,
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
            InkWell(
              onTap: () {
                
              },
              child: Container(
                child: Text('Log in'),
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
