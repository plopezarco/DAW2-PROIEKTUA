import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:liburutegiaapp/helpers/api_service.dart';
import 'package:liburutegiaapp/pages/pages.dart';
import 'package:liburutegiaapp/helpers/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'LiburutegiApp',
      logo: const AssetImage('assets/logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      },
      messages: LoginMessages(
          flushbarTitleError: "Errorea",
          userHint: "Erabiltzailea",
          passwordHint: "Pasahitza",
          loginButton: "SARTU",
          signupButton: "ERREGISTRATU",
          confirmPasswordHint: "Pasahitza errepikatu",
          confirmPasswordError: "Pasahitzak ez dira berdinak",
          confirmSignupButton: "Erregistratu"),
      hideForgotPasswordButton: true,
      onRecoverPassword: _recoverPassword,
    );
  }

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    bool success = await api.login(data);
    if (success) {
      globals.isLoggedIn = true;
      globals.username = data.name;
      return null;
    }
    return "Erabiltzailea edo pasahitza okerrak dira.";
  }

  Future<String?> _signupUser(SignupData data) async {
    int code = await api.signup(data);
    if (code == 201) {
      globals.isLoggedIn = true;
      globals.username = data.name!;
      return null;
    } else {
      return "Erabiltzaile hori dagoeneko erregistratuta dago";
    }
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }
}
