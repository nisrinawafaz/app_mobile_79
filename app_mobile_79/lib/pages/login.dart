import 'package:flutter/material.dart';
import 'package:taskify/component/text_field.dart';
import 'package:taskify/pages/home.dart';
import 'package:taskify/shared/images.dart';
import 'package:taskify/shared/style.dart';
import 'package:taskify/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = username.isEmpty
            ? "Username cannot be empty"
            : "Password cannot be empty";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await AuthService().login(username, password);

      final accessToken = result['accessToken'];
      if (accessToken == null) throw Exception("Token tidak ditemukan");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('tokenAuth', accessToken);

      Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
      String name = decodedToken['firstName'];
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage(name: name)),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        _errorMessage = e is Exception
            ? e.toString().replaceFirst("Exception: ", "")
            : e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  background_auth,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  semanticLabel: 'Background Image',
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Access Your Tasks with Taskify',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      if (_errorMessage != null)
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: failed,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      Semantics(
                        label: 'Username Text Field',
                        child: CustomTextField(
                          label: "Username",
                          placeholder: "Enter your Username",
                          controller: _usernameController,
                        ),
                      ),
                      SizedBox(height: 10),
                      Semantics(
                        label: 'Password Text Field',
                        child: CustomTextField(
                          label: "Password",
                          password: true,
                          placeholder: "Enter your password",
                          controller: _passwordController,
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Belum punya akun? ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: black,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor,
                                ),
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => RegisterPage()),
                                //     );
                                //   },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Semantics(
                              label: 'Login Button',
                              button: true,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: secondaryColor,
                                  minimumSize: Size(150, 50),
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
