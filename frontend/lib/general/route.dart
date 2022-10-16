import 'package:formula/pages/home.dart';
import 'package:get/get.dart';

class AppRoutes {
//route with parameters example:
//    - static String myPage({required id}) => "mypage/:$id";
//    - :$id will be the parameter
//
//    - GetPage(
//          name: myPage(
//              id: '${MyPageScreen.idParameter}'),
//          page: () => MyPageScreen()),
//
//    - in the widget where the route goes should be a static String idParameter="<key>"
//    - get the parameter by Get.parameters[MyPageScreen.idParameter]
  static String home = "/";

  static final pages = [GetPage(name: home, page: () => HomePage())];
}
