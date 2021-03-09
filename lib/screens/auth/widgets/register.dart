import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/screens/auth/widgets/register_info.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'sign_in_up_bar.dart';
import 'title.dart';

class Register extends StatelessWidget {
  Register({Key key, this.onSignInPressed}) : super(key: key);
  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.isSubmitting();
    return SignInForm(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: '\nCreate\nAccount',
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: EmailTextFormField(
                        style: const TextStyle(
                          fontSize: 18,
                          //color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: PasswordTextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        //color: Colors.black,
                      ),
                    ),
                  ),
                  SignUpBar(
                    label: 'Sign up',
                    isLoading: isSubmitting,
                    onPressed: () {
                      context.registerWithEmailAndPassword();
                      Navigator.of(context).pushReplacement(RegisterInfo.route);
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        onSignInPressed?.call();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Palette.darkBlue,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
