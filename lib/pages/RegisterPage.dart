import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool statusRedEye = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Page')),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.blue[700]!],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(16),
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
                      buildInputBirthday(),
                      SizedBox(height: 20),
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
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'name',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: Colors.red, fontSize: 20),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'กรุณาป้อนชื่อ-นามสกุล'),
        FormBuilderValidators.minLength(
          3,
          errorText: "กรุณากรอกอย่างน้อย 3 ตัวอักษร",
        ),
      ]),
    );
  }

  Widget buildInputEmail() {
    return FormBuilderTextField(
      name: 'email',
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(color: Colors.red, fontSize: 20),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'กรุณากรอกE-mail'),
        FormBuilderValidators.email(errorText: "รูปแบบE-mailไม่ถูกต้อง"),
      ]),
    );
  }

  Widget buildInputPassword() {
    return FormBuilderTextField(
      name: 'password',
      maxLines: 1,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 20),
      obscureText: statusRedEye,
      decoration: InputDecoration(
        hintText: 'password',
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon: Icon(
            statusRedEye ? Icons.remove_red_eye : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              statusRedEye = !statusRedEye;
            });
          },
        ),
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
        fillColor: Colors.white,
        filled: true,
        errorStyle: const TextStyle(color: Colors.red, fontSize: 20),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'กรุณากรอกPassword'),
        FormBuilderValidators.minLength(
          4,
          errorText: "กรุณากรอกอย่างน้อย 4 ตัวอักษร",
        ),
      ]),
    );
  }
}

Widget buildInputBirthday() {
  return FormBuilderDateTimePicker(
    name: 'dob',
    maxLines: 1,
    inputType: InputType.date,
    decoration: const InputDecoration(
      prefixIcon: Icon(Icons.cake),
      labelText: 'วัน/เดือน/ปี เกิด',
      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
      fillColor: Colors.white,
      filled: true,
      errorStyle: TextStyle(color: Colors.red, fontSize: 20),
    ),
  );
}

/*Widget buildBtnRegister() {
  return Row(
    children: <Widget>[
      Expanded(
        child: MaterialButton(
          color: Theme.of(context).accentColor,
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: (){
            _formKey.currentState?.save();
            if (_formKey.currentState!.validate()) {
              print(_formKey.currentState?.value);
            } else {
              print("validation failed");
            }
          }
        ),
      )
    ],
  )
}
*/
