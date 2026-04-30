import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/pages/homepage.dart';
import 'package:untitled1/pages/signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Color.fromRGBO(85, 101, 175, 1.0)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text(
                  'Kanva',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(255, 251, 205, 1),
                    letterSpacing: 2.0,
                  ),
                ),

                const SizedBox(height: 20.0),

                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 251, 205, 1.0),
                  ),
                ),

                const SizedBox(height: 40.0),

                Expanded(
                  child: Container(
                    width: double.infinity,

                    //color: Color.fromRGBO(228, 235, 255, 1),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(228, 235, 255, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(44),
                        topRight: Radius.circular(44),
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              'Welcome back',
                              style: GoogleFonts.inknutAntiqua(
                                fontSize: 20,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(height: 20.0),

                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email',
                                    style: GoogleFonts.inknutAntiqua(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12.0),

                            TextField(
                              decoration: InputDecoration(
                                hintText: 'example@gmail.com',
                                hintStyle: GoogleFonts.inknutAntiqua(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),

                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 22.0,
                                    right: 4,
                                  ),
                                  child: Icon(Icons.email),
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                  borderSide: BorderSide.none,
                                ),

                                filled: true,

                                fillColor: Color.fromRGBO(245, 245, 245, 1),
                              ),
                            ),

                            const SizedBox(height: 12.0),

                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Password',
                                    style: GoogleFonts.inknutAntiqua(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12.0),

                            TextField(
                              decoration: InputDecoration(
                                hintText: 'password123',
                                hintStyle: GoogleFonts.inknutAntiqua(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),

                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                ),

                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: GestureDetector(
                                    child: Icon(Icons.lock),
                                  ),
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                  borderSide: BorderSide.none,
                                ),

                                filled: true,

                                fillColor: Color.fromRGBO(245, 245, 245, 1),
                              ),
                            ),

                            const SizedBox(height: 20.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        // Update the state when checkbox is toggled
                                        setState(() {
                                          isChecked = value ?? false;
                                        });
                                      },

                                      fillColor: MaterialStateProperty.all(
                                        Colors.white,
                                      ),
                                      checkColor: Colors.black,
                                      visualDensity: VisualDensity(
                                        horizontal: -4.0,
                                        vertical: -4.0,
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Remember Me',
                                        style: GoogleFonts.inknutAntiqua(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: GoogleFonts.inknutAntiqua(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20.0),

                            //login button
                            SizedBox(
                              width: double.infinity,
                              height: 50,

                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Homepage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Color.fromRGBO(
                                    245,
                                    245,
                                    245,
                                    1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.inknutAntiqua(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30.0),

                            //dividers
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.black, // line color
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "or Login with",
                                    style: GoogleFonts.inknutAntiqua(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 2,
                                    ), // text style
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Google Button
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      customBorder: CircleBorder(),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/icons8-google-logo-48.png',
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                // Facebook Button
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      customBorder: CircleBorder(),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/icons8-facebook-logo-16.png',
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Dont have an account ?',
                                  style: GoogleFonts.inknutAntiqua(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Signup(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.inknutAntiqua(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
