import 'package:bwnp/redux/profile/ProfileReducer.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta.dart';

@immutable
class GetProfileAction {
  final Map<String, dynamic> profile;
  
  // รับข้อมูล Profile (ที่เป็น Map) เข้ามาเพื่อส่งต่อให้ Reducer
  GetProfileAction(this.profile);
}
// ฟังก์ชันสร้าง Action
// แก้ไขส่วน profileReducer
ProfileState profileReducer(ProfileState state, dynamic action) {
  if (action is GetProfileAction) {
    // แก้ตรงนี้: ให้รับ action.profile มาตรงๆ (อิงตามโครงสร้าง Action ปกติ)
    return state.copyWith(profile: action.profile);
  }
  return state;
}