import 'package:bwnp/pages/CustomerPage.dart';
import 'package:bwnp/pages/LoginPage.dart';
import 'package:bwnp/pages/RegisterPage.dart';
import 'package:bwnp/pages/UpdateProfilePage.dart';
import 'package:bwnp/pages/new_page.dart';
import 'package:bwnp/pages/webview_page.dart';
import 'package:bwnp/redux/AppReducer.dart';
//import 'package:bwnp/redux/AppState.dart'; // ตรวจสอบ path ให้ถูก
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_stack.dart';
import 'pages/product_stack.dart';
import 'dart:convert' as convert;
import 'package:bwnp/redux/profile/ProfileAction.dart';
import 'package:redux_thunk/redux_thunk.dart';

// Redux
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // 1. ดึงข้อมูล Token และ Profile จากเครื่อง
  String? token = prefs.getString('token');
  String? profileString = prefs.getString('profile');

  // 2. สร้าง store พร้อมค่าเริ่มต้น
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(), // เติม , ตรงนี้
    middleware: [thunkMiddleware], // เติม k ที่ชื่อ middleware
  );
  // 3. ✅ ตรวจสอบว่าถ้ามีข้อมูล Profile ในเครื่อง ให้ Dispatch เข้า Redux ทันที
  if (profileString != null) {
    Map<String, dynamic> profile = convert.jsonDecode(profileString);
    store.dispatch(GetProfileAction(profile)); // ✅ ส่ง Map เข้าไป
  }

  // 4. ส่ง store เข้าไปใน MyApp
  runApp(MyApp(store: store, token: token));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final String? token;

  const MyApp({Key? key, required this.store, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const chelseaBlue = Color.fromARGB(255, 0, 63, 158);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false, // ปิดป้าย Debug (ถ้าต้องการ)
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: chelseaBlue,
            secondary: chelseaBlue,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: chelseaBlue,
            foregroundColor: Color.fromARGB(
              255,
              0,
              0,
              0,
            ), // ปรับเป็นสีขาวให้อ่านง่ายขึ้น
          ),
        ),
        // ถ้าไม่มี token ให้ไปหน้า Login ถ้ามีแล้วให้ไปหน้า Home
        home: token == null ? loginpage() : const HomeStack(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => loginpage(),
          '/register': (BuildContext context) => RegisterPage(),
          '/home': (BuildContext context) => const HomeStack(),
          '/product': (BuildContext context) => const ProductStack(),
          '/newsstack': (BuildContext context) => NewsPage(),
          '/newsstack/webview': (context) => WebViewPage(),
          '/homestack/updateprofile': (context) => const UpdateProfilePage(),
          'homestack/updateprofile': (context) => const UpdateProfilePage(),
          '/customer': (context) => const CustomerPage(),
        },
      ),
    );
  }
}
