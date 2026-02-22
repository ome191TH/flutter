import 'package:bwnp/redux/product/ProductAction.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart'; // 1. ต้อง import ตัวนี้

@immutable
class ProductState extends Equatable {
  final List<dynamic> course;
  final bool isLoading;

  const ProductState({
    this.course = const [],
    this.isLoading = true,
  });

  // 2. ต้องมี ? เพื่อให้เป็น Optional (ส่งมาเฉพาะตัวที่จะเปลี่ยน)
  ProductState copyWith({List<dynamic>? course, bool? isLoading}) {
    return ProductState(
      course: course ?? this.course,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [course, isLoading];
}

// 3. ย้าย Reducer ออกมาไว้นอกคลาส ProductState
ProductState productReducer(ProductState state, dynamic action) {
  if (action is GetProductAction) {
    // 4. เช็กว่าใน GetProductAction ของคุณมีตัวแปรชื่ออะไร 
    // ถ้าคุณประกาศใน Action ว่า 'final ProductState productState' โค้ดนี้จะใช้ได้
    return state.copyWith(
      course: action.productState.course,
      isLoading: false, // ปกติโหลดเสร็จควรเป็น false
    );
  }
  return state;
}