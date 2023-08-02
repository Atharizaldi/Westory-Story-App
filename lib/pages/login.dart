import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:stroy_app/controllers/login_controller.dart';
import 'package:stroy_app/pages/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>(); //for storing form state.

  bool isAPIcallProcess = false;
  bool hidePassword = true;
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: ProgressHUD(
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logoletter.png'),
                        width: 350,
                      ),
                      TextFormField(
                        controller: loginController.emailController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email must be filled out';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: loginController.passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Password must be filled out';
                          }
                          return null;
                        },
                        style: TextStyle(),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final progress = ProgressHUD.of(context);
                          if (_form.currentState?.validate() == true) {
                            progress?.show();

                            loginController.login().then(
                                  (response) => {
                                    if (response)
                                      {
                                        progress?.dismiss(),
                                        Navigator.pushNamed(context, "/home")
                                      }
                                    else
                                      {
                                        progress?.dismiss(),
                                        Get.rawSnackbar(
                                          message:
                                              "Check Your Email & Password",
                                          snackPosition: SnackPosition.BOTTOM,
                                          margin: EdgeInsets.all(15),
                                          borderRadius: 10,
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        )
                                      }
                                  },
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(79, 110, 247, 1),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text("Login"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Get.off(RegistrationPage());
                            },
                            child: const Text(
                              "Register Here.",
                              style: TextStyle(
                                color: Color.fromRGBO(79, 110, 247, 1),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
