import 'package:bwnp/redux/AppReducer.dart';
import 'package:bwnp/redux/profile/ProfileReducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late SharedPreferences prefs; // ประกาศไว้

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    prefs =
        await SharedPreferences.getInstance(); // กำหนดค่า (ใช้เวลาโหลดสักพัก)
    setState(() {}); // แจ้งว่าโหลดเสร็จแล้วนะ
  }
  /*Map<String, dynamic> profile = {
    'name': '',
    'email': '',
    'avatar': '',
    'role': '',
  };*/

  /*@override
  void initState() {
    super.initState();
    //_getProfile();
  }*/

  /*Future<void> _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    String? profileString = prefs.getString('profile');
    if (profileString != null) {
      Map<String, dynamic> storedProfile = convert.jsonDecode(profileString);
      profile = {
        'name': storedProfile['name'] ?? '',
        'email': storedProfile['email'] ?? '',
        'avatar': storedProfile['avatar'] ?? '',
        'role': storedProfile['role'] ?? '',
      };
      setState(() {});
    }
  }*/

  Future<void> _logout() async {
    await prefs.clear();
    setState(() {
      //profile = {'name': '', 'email': '', 'avatar': '', 'role': ''};
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            StoreConnector<AppState, ProfileState>(
              converter: (store) => store.state.profileState,
              builder: (context, profileState) {
                // เปลี่ยนชื่อตัวแปรเป็น profileState เพื่อกันงง
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 44, 243),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                // แก้ตรงนี้: profileState.profile['avatar']
                                image:
                                    profileState.profile['avatar'] != null &&
                                        profileState.profile['avatar'] != ''
                                    ? NetworkImage(
                                        profileState.profile['avatar'],
                                      )
                                    : const AssetImage('assets/images/user.png')
                                          as ImageProvider,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // แก้ตรงนี้: profileState.profile['name']
                                profileState.profile['name'] != null &&
                                        profileState.profile['name'] != ''
                                    ? profileState.profile['name']
                                    : 'ชื่อผู้ใช้',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                // แก้ตรงนี้: profileState.profile['email']
                                profileState.profile['email'] != null &&
                                        profileState.profile['email'] != ''
                                    ? profileState.profile['email']
                                    : 'email@example.com',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () async {
                            await Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed('/homestack/updateprofile');
                            // อย่าลืมเช็คว่าในไฟล์ Menu นี้มีฟังก์ชัน _getProfile() หรือยังนะครับ
                            // _getProfile();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              trailing: const Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/home', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.all_out),
              title: const Text('Products'),
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/product', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('News'),
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/newsstack', (route) => false);
              },
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                _logout();
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
