import 'package:bwnp/redux/profile/ProfileAction.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  const ProfileState({
    // ✅ แก้ไข: เปลี่ยนจาก 'John RMUTP BUS' เป็นค่าว่าง หรือดึงจากแหล่งข้อมูลจริง
    this.profile = const {'name': '', 'email': '', 'role': ''},
  });

  ProfileState copyWith({Map<String, dynamic>? profile}) {
    return ProfileState(profile: profile ?? this.profile);
  }

  dynamic operator [](String key) => profile[key];
}

ProfileState profileReducer(ProfileState state, dynamic action) {
  if (action is GetProfileAction) {
    // ดึง Map profile จาก action มาใส่ใน State
    return state.copyWith(profile: action.profile);
  }
  return state;
}