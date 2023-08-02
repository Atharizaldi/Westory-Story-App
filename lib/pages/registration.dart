import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:stroy_app/controllers/registration_controller.dart';
import 'package:stroy_app/pages/login.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _form = GlobalKey<FormState>(); //for storing form state.
  RegistrationController registrationController =
      Get.put(RegistrationController());
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
                        controller: registrationController.nameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Name',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Name must be filled out';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: registrationController.emailController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'email must be filled out';
                          } else if (!(text.contains('@')) && text.isNotEmpty) {
                            return "Enter a valid email address!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: registrationController.passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
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
                          } else if (text.length < 8 && text.isNotEmpty) {
                            return "Password lengt must be 8 minimum";
                          } else {
                            return null;
                          }
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

                            registrationController.registration().then(
                                  (response) => {
                                    if (response)
                                      {
                                        progress?.dismiss(),
                                        Navigator.pushNamed(context, "/login"),
                                        Get.rawSnackbar(
                                          message: "Registration Successfull",
                                          snackPosition: SnackPosition.BOTTOM,
                                          margin: EdgeInsets.all(15),
                                          borderRadius: 10,
                                          backgroundColor:
                                              Color.fromRGBO(79, 110, 247, 1),
                                          duration: Duration(seconds: 3),
                                        )
                                      }
                                    else
                                      {
                                        progress?.dismiss(),
                                        Get.rawSnackbar(
                                          message: "Try to use another email.",
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
                        child: const Text("Register"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Have an account? "),
                          GestureDetector(
                            onTap: () {
                              Get.off(LoginPage());
                            },
                            child: const Text(
                              "Login Here.",
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
