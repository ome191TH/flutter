import 'package:bwnp/redux/AppReducer.dart';
//import 'package:bwnp/redux/AppState.dart'; // ตรวจสอบ path ให้ถูก
import 'package:bwnp/redux/profile/ProfileAction.dart';
import 'package:bwnp/redux/profile/ProfileReducer.dart';
//import 'package:bwnp/redux/profile/ProfileState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late SharedPreferences prefs;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  // ✅ แก้ไขฟังก์ชันอัปเดต: เอาฟังก์ชันซ้อนออก และเรียกใช้จริงทันที
  Future<void> _update(String newName) async {
    try {
      // 1. ดึงข้อมูลเก่าจาก SharedPreferences
      String? profileString = prefs.getString('profile');
      Map<String, dynamic> profile = {};
      if (profileString != null) {
        profile = convert.jsonDecode(profileString);
      }

      // 2. อัปเดตข้อมูล (ตรวจสอบโครงสร้าง Key ให้ตรงกับในแอปของคุณ)
      profile['name'] = newName;
      
      // ✅ 3. เซฟกลับลงเครื่องทันที (ไม่มีฟังก์ชันซ้อนแล้ว)
      await prefs.setString('profile', convert.jsonEncode(profile));

      // ✅ 4. Dispatch ไปที่ Redux ทันทีเพื่อให้หน้าอื่นเปลี่ยนตาม
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(GetProfileAction(profile)); 

      // 5. แจ้งเตือนและปิดหน้า
      if (!mounted) return;
      Flushbar(
        title: "สำเร็จ",
        message: "แก้ไขชื่อเป็น $newName เรียบร้อยแล้ว",
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.BOTTOM,
      ).show(context).then((_) {
        Navigator.pop(context, profile);
      });
    } catch (e) {
      Flushbar(
        title: "ผิดพลาด",
        message: e.toString(),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[50]!, Colors.blue[700]!],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: StoreConnector<AppState, ProfileState>(
              converter: (store) => store.state.profileState,
              // ✅ สำคัญ: ใช้ onInit เพื่อ set ชื่อครั้งเดียวตอนเปิดหน้า
              onInit: (store) {
                _nameController.text = store.state.profileState.profile['name'] ?? '';
              },
              builder: (context, profileState) {
                return FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      buildInputName(),
                      const SizedBox(height: 20),
                      buildBtnUpdate(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputName() {
    return FormBuilderTextField(
      name: 'name',
      controller: _nameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'Name',
        fillColor: Colors.white,
        filled: true,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'กรุณากรอกชื่อ-นามสกุล'),
        FormBuilderValidators.minLength(3, errorText: 'กรุณากรอกอย่างน้อย 3 ตัวอักษร'),
      ]),
    );
  }

  Widget buildBtnUpdate() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Text("Update", style: TextStyle(fontSize: 20, color: Colors.white)),
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            _update(_nameController.text); // เรียกใช้ฟังก์ชันอัปเดต
          }
        },
      ),
    );
  }
}