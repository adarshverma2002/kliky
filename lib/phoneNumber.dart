import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class phoneNumber extends StatefulWidget {
  const phoneNumber({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<phoneNumber> createState() => _phoneNumberState();
}

class _phoneNumberState extends State<phoneNumber> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/gif_mobile.gif',
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone number before getting started",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countrycode,
                          decoration: InputDecoration(border: InputBorder.none),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 35, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: TextField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone Number"))),
                    // TextField(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${countrycode.text + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        phoneNumber.verify = verificationId;
                        Navigator.pushNamed(context, "otp");
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  },
                  child: Text('Send the otp'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
