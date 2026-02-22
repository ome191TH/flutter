
import 'package:bwnp/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool statusRedEye = true;

  Future<void> _register(Map<String, dynamic> values) async {
    try {
      var url = Uri.https('api.codingthailand.com', '/api/register');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode({
          "name": values['name'],
          "email": values['email'],
          "password": values['password'],
          "dob": values['dob'].toString().substring(0, 10),
        }),
      );

      if (response.statusCode == 201) {
        var res = convert.jsonDecode(response.body);
        Flushbar(
          title: "สำเร็จ",
          message: res['message'] ?? "สมัครสมาชิกเรียบร้อยแล้ว",
          duration: Duration(seconds: 2), // ลดเวลาให้แสดงแค่ 2 วินาที
          backgroundColor: Colors.green,
          flushbarPosition: FlushbarPosition.BOTTOM,
        ).show(context);

        // หน่วงเวลา 2 วินาทีก่อนย้ายไปหน้า Login
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => loginpage()),
          );
        });
      } else {
        var res = convert.jsonDecode(response.body);
        Flushbar(
          title: "ผิดพลาด",
          message: res['message'] ?? "เกิดข้อผิดพลาดในการสมัคร",
          duration: Duration(seconds: 3),
          backgroundColor: const Color.fromARGB(255, 255, 17, 0),
          flushbarPosition: FlushbarPosition.BOTTOM,
        ).show(context);
      }
    } catch (e) {
      Flushbar(
        title: "Exception",
        message: e.toString(),
        duration: Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        flushbarPosition: FlushbarPosition.BOTTOM,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // กดแล้วไป Login โดยตรง
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => loginpage()),
            );
          },
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color.fromARGB(255, 0, 25, 148)!,
              const Color.fromARGB(255, 84, 124, 255)!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: <Widget>[
                      buildInputName(),
                      buildInputEmail(),
                      buildInputPassword(),
                      buildInputBirthdate(),
                      SizedBox(height: 20),
                      buildBtnRegister(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputName() {
    return FormBuilderTextField(
      name: 'name',
      maxLines: 1,
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'Name',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: const Color.fromARGB(255, 255, 17, 0), fontSize: 20),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: 'Please enter your full name.',
        ),
        FormBuilderValidators.minLength(
          3,
          errorText: 'Please enter at least 3 characters.',
        ),
      ]),
    );
  }

  Widget buildInputEmail() {
    return FormBuilderTextField(
      name: 'email',
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: const Color.fromARGB(255, 255, 17, 0), fontSize: 20),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Invalid email address.'),
        FormBuilderValidators.email(errorText: 'Invalid email format.'),
      ]),
    );
  }

  Widget buildInputPassword() {
    return FormBuilderTextField(
      name: 'password',
      maxLines: 1,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      obscureText: statusRedEye,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon: Icon(statusRedEye ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              statusRedEye = !statusRedEye;
            });
          },
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: const Color.fromARGB(255, 255, 17, 0), fontSize: 20),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Password is required.'),
        FormBuilderValidators.minLength(
          4,
          errorText: 'Please enter at least 6 characters.',
        ),
      ]),
    );
  }

  Widget buildInputBirthdate() {
    return FormBuilderDateTimePicker(
      name: 'dob',
      inputType: InputType.date,
      format: DateFormat('dd/MM/yyyy'),
      decoration: InputDecoration(
        labelText: 'วัน/เดือน/ปี เกิด',
        prefixIcon: Icon(Icons.cake),
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: const Color.fromARGB(255, 255, 21, 5), fontSize: 20),
      ),
      style: TextStyle(fontSize: 20),
      validator: FormBuilderValidators.required(
        errorText: 'Date of birth is required.',
      ),
    );
  }

  Widget buildBtnRegister() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Register",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  _register(_formKey.currentState!.value);
                } else {
                  Flushbar(
                    title: "ข้อมูลไม่ครบ",
                    message: "กรุณากรอกข้อมูลให้ครบถ้วน",
                    duration: Duration(seconds: 3),
                    backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                  ).show(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
