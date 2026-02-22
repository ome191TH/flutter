import 'package:bwnp/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sqflite/sqflite.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customers = [];
  late DBHelper dbHelper;
  late Database db;

  final _formKey = GlobalKey<FormBuilderState>();

  void _getCustomer() async {
    db = await dbHelper.db;
    var sql = 'SELECT * FROM customers ORDER BY id DESC';
    var cus = await db.rawQuery(sql);
    setState(() {
      customers = cus;
    });
  }

  void _addCustomer(Map<String, dynamic> values) async {
    db = await dbHelper.db;
    await db.rawInsert('INSERT INTO customers (name) VALUES (?)', [values['name']]);
    _getCustomer();
  }

  void _updateCustomer(int id, Map<String, dynamic> values) async {
    db = await dbHelper.db;
    await db.rawUpdate("UPDATE customers SET name = ? WHERE id = ?", [values['name'], id]);
    _getCustomer();
  }

  void _deleteCustomer(int id) async {
    db = await dbHelper.db;
    await db.rawDelete("DELETE FROM customers WHERE id = ?", [id]);
    _getCustomer();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _getCustomer();
  }

  _insertFor() {
    _formKey.currentState?.reset();
    Alert(
      context: context,
      title: "เพิ่มข้อมูลลูกค้า",
      content: FormBuilder(
        key: _formKey,
        initialValue: {"name": ''},
        child: buildInputName(),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              _addCustomer(_formKey.currentState!.value);
              Navigator.pop(context);
            }
          },
          child: const Text("เพิ่มข้อมูล", style: TextStyle(color: Colors.white)),
        ),
      ],
    ).show();
  }

  _editFor(Map item) {
    Alert(
      context: context,
      title: "แก้ไขชื่อลูกค้า",
      content: FormBuilder(
        key: _formKey,
        initialValue: {"name": item['name']},
        child: buildInputName(),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              _updateCustomer(item['id'], _formKey.currentState!.value);
              Navigator.pop(context);
            }
          },
          child: const Text("บันทึก", style: TextStyle(color: Colors.white)),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _insertFor(),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: customers.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 16),
        itemBuilder: (context, index) {
          final item = customers[index];
          return Dismissible(
            key: Key(item['id'].toString()),
            background: _buildSwipeBackground(Alignment.centerLeft, Colors.blue, Icons.edit, 'Edit'),
            secondaryBackground: _buildSwipeBackground(Alignment.centerRight, Colors.red, Icons.delete, ''),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                _editFor(item);
                return false;
              } else {
                // ✅ ส่วนยืนยันการลบข้อมูล (Confirm Delete)
                bool canDelete = false;
                await Alert(
                  context: context,
                  type: AlertType.warning, // ไอคอนตกใจสีเหลือง
                  title: "ยืนยันการลบข้อมูล",
                  desc: "ต้องการลบข้อมูล ${item['name']} ใช่หรือไม่",
                  style: const AlertStyle(
                    isCloseButton: false,
                    isOverlayTapDismiss: false,
                    animationType: AnimationType.fromTop,
                  ),
                  buttons: [
                    DialogButton(
                      onPressed: () {
                        canDelete = true;
                        Navigator.pop(context);
                      },
                      color: const Color.fromRGBO(0, 179, 134, 1.0), // สีเขียว
                      child: const Text("ใช่", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    DialogButton(
                      onPressed: () {
                        canDelete = false;
                        Navigator.pop(context);
                      },
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]), // สีม่วง-น้ำเงิน
                      child: const Text("ไม่ใช่", style: TextStyle(color: Colors.white, fontSize: 18)),
                    )
                  ],
                ).show();

                if (canDelete) {
                  _deleteCustomer(item['id']);
                  return true;
                }
                return false;
              }
            },
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                '${item['name']}',
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${item['id']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwipeBackground(Alignment alignment, Color color, IconData icon, String label) {
    return Container(
      color: color,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          if (label.isNotEmpty) Text(' $label', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget buildInputName() {
    return FormBuilderTextField(
      name: 'name',
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'ชื่อ-นามสกุล',
        filled: true,
        fillColor: Colors.white10,
      ),
      validator: FormBuilderValidators.required(errorText: 'กรุณากรอกชื่อลูกค้า'),
    );
  }
}