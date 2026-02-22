import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:another_flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bwnp/redux/AppReducer.dart'; // ตรวจสอบ path
import 'package:bwnp/redux/profile/ProfileAction.dart'; // ตรวจสอบ path

class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool statusRedEye = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _login(Map<String, dynamic> values) async {
    var url = Uri.https('api.codingthailand.com', '/api/login');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode(values),
    );

    if (response.statusCode == 200) {
      var res = convert.jsonDecode(response.body);

      // save token ก่อน
      await prefs.setString('token', res['access_token']);

      Flushbar(
        title: 'Login Success',
        message: res['message'] ?? 'เข้าสู่ระบบสำเร็จ',
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.BOTTOM,
      ).show(context);

      // รอให้ผู้ใช้เห็นข้อความก่อน 1 วินาที
      await Future.delayed(Duration(seconds: 1));

      // get profile และ navigate
      if (await _getProfile()) {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      var res = convert.jsonDecode(response.body);
      Flushbar(
        title: "ผิดพลาด ",
        message: res['message'] ?? "เกิดข้อผิดพลาดใน Login",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
      ).show(context);
    }
  }

  Future<bool> _getProfile() async {
  String? tokenString = prefs.getString('token');
  if (tokenString == null) return false;

  var url = Uri.https('api.codingthailand.com', '/api/profile');
  var response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $tokenString'},
  );

  if (response.statusCode == 200) {
    var profile = convert.jsonDecode(response.body);

    if (profile['data'] != null && profile['data']['user'] != null) {
      Map<String, dynamic> user = profile['data']['user'];

      // 1. บันทึกลงเครื่อง (ทำอยู่แล้ว)
      await prefs.setString('profile', convert.jsonEncode(user));

      // ✅ 2. เพิ่มบรรทัดนี้: ส่งข้อมูลเข้า Redux Store ทันที
      // เพื่อให้หน้า Home หรือหน้าอื่นๆ เห็นข้อมูลใหม่โดยไม่ต้องรีสตาร์ท
      final store = StoreProvider.of<AppState>(context, listen: false);
      store.dispatch(GetProfileAction(user));

      return true;
    }
  }
  return false;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
                      Image.asset(
                        'assets/images/C.png',
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      buildInputEmail(),
                      SizedBox(height: 10),
                      buildInputPassword(),
                      SizedBox(height: 20),
                      buildBtnLogin(),
                      SizedBox(height: 10),
                      buildBtnRegister(),
                      SizedBox(height: 10),
                      buildBtnForgetPassword(),
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
        errorStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 0, 0),
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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
        errorStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 17, 0),
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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

  Widget buildBtnLogin() {
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
                "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  _login(_formKey.currentState!.value);
                } else {
                  Flushbar(
                    title: "ข้อมูลไม่ครบ",
                    message: "กรุณากรอกข้อมูลให้ครบถ้วน",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.orange,
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
                Navigator.popAndPushNamed(context, '/register');
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBtnForgetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
          height: 50,
          child: Text(
            "Forget your password?",
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(255, 244, 232, 232),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
