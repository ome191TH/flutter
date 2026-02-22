import 'package:bwnp/redux/product/ProductReducer.dart';
import 'package:bwnp/redux/profile/ProfileReducer.dart';
//import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ProfileState profileState;
  final ProductState productState;

  AppState({required this.profileState, required this.productState});

  factory AppState.initial() {
    return AppState(
      profileState: const ProfileState(), // เติม const ถ้า class รองรับ
      productState: const ProductState(),
    );
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    profileState: profileReducer(state.profileState, action),
    productState: productReducer(state.productState, action), // ห้ามลืมบรรทัดนี้!
  );
}
/*AppState appReducer(AppState state, dynamic action) {
  return AppState(profileState: profileReducer(state.profileState, action));
}*/
