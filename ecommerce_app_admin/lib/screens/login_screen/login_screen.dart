import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  @override
  void initState() {
    super.initState();
    // _authService = getIt.get<AuthService>();
    // _navigationService = getIt.get<NavigationService>();
    // _alertService = getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          children: [
            _headerText(),
            _loginForm(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TRANG ADMIN",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
        // height: MediaQuery.sizeOf(context).height * 0.4,
        // margin: EdgeInsets.symmetric(
        //   vertical: MediaQuery.sizeOf(context).height * 0.05,
        // ),
        // child: Form(
        //   key: _loginFormKey,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     mainAxisSize: MainAxisSize.max,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       CustomFormField(
        //         hintText: "Email",
        //         validationRegEx: EMAIL_VALIDATION_REGEX,
        //         onSaved: (value) {
        //           setState(() {
        //             email = value;
        //           });
        //         },
        //       ),
        //       CustomFormField(
        //         hintText: "Password",
        //         validationRegEx: PASSWORD_VALIDATION_REGEX,
        //         obsureText: true,
        //         onSaved: (value) {
        //           password = value;
        //         },
        //       ),
        //       _loginButton(),
        //     ],
        //   ),
        // ),
        );
  }

  Widget _loginButton() {
    return SizedBox(
        // width: MediaQuery.sizeOf(context).width,
        // child: MaterialButton(
        //   onPressed: () async {
        //     if (_loginFormKey.currentState?.validate() ?? false) {
        //       _loginFormKey.currentState?.save();
        //       bool result = await _authService.login(email!, password!);
        //       // print(result);
        //       if (result) {
        //         _navigationService.pushReplacementNamed("/home");
        //         _alertService.showToast(
        //           title: "Successfully",
        //           icon: Icons.error,
        //         );
        //       } else {
        //         _alertService.showToast(
        //           title: "Loi",
        //           icon: Icons.error,
        //         );
        //       }
        //     }
        //   },
        //   color: Theme.of(context).colorScheme.primary,
        //   child: const Text(
        //     "Login",
        //     style: TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        );
  }
}
