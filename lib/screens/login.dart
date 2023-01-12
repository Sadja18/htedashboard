import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({super.key});

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
            SizedBox(
              height: 50,
            ),
            Image(
              image: AssetImage('assets/images/user.png'),
              height: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'username'),
                )),
            // Padding(
            //   padding: EdgeInsets.all(15),
            const SizedBox(
              height: 30,
            ),

            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'password'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: 100,
                child: InkWell(
                  child: Center(
                    child: Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                  onTap: () {},
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
