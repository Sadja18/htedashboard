import 'package:flutter/material.dart';
import 'dart:developer';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController usernameController =
      TextEditingController(text: "");
  TextEditingController passwordController =
      TextEditingController(text: "");

  // this method sends auth request to odoo backend
  // and return the login status
  // if the login is success; the method returns 1 else null

  Future<dynamic> tryDeptLogin(String? username, String? password) async {
    try {
      if (kDebugMode) {
        log("sending http request for authentication");
        log(username.toString());
        log(password.toString());
      }
      // Validate the credentials
      if (username == "admin" && password == "password") {
        /// Storing the username and password in the browser's session storage.
        html.window.sessionStorage['username'] = username.toString();
        html.window.sessionStorage['password'] = password.toString();

        // Navigate to home page
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Show error message
        if (kDebugMode) {
          log("message");
          log("invalid Credentials");
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        log("Dept Login in Dashboard caused error");
        log(e.toString());
      }
      return null;
    }
  }

  // if the user closes the browser, send a logout request to the odoo backend
  // the session storage will
  Future<void> sendLogoutOnClose() async {
    try {
      html.window.onUnload.listen((event) {
        http.get(
          Uri.parse('https://example.com/logout'),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        log("error in sending logout on browser close");
        log(e.toString());
      }
    }
  }

  bool isLoggedIn() {
    return html.window.sessionStorage.containsKey('username') &&
        html.window.sessionStorage.containsKey('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            const Image(
              image: AssetImage('assets/images/user.png'),
              height: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail',
                ),
                controller: usernameController,
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(15),
            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: 100,
                child: InkWell(
                  child: const Center(
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    tryDeptLogin(
                      usernameController.text,
                      passwordController.text,
                    );
                  },
                )
                // child: InkWell(
                //   onTap: () {},
                //   highlightColor: Colors.blue,
                //   child: Center(
                //     child: Card(
                //       child: Padding(
                //         padding: EdgeInsets.all(16.0),
                //         child: Text('login'),
                //       ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       elevation: 1,
                //       color: Colors.blue,
                //     ),
                //   ),
                // ),
                )
          ]),
        ),
      ),
    );
  }
}
