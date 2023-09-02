import 'package:get/get.dart';
import '../modules/Add_Shops/bindings/add_shops_binding.dart';
import '../modules/Add_Shops/views/add_shops_view.dart';
import '../modules/Add_Tolls/bindings/add_tolls_binding.dart';
import '../modules/Add_Tolls/views/add_tolls_view.dart';
import '../modules/Home_Screen/bindings/home_screen_binding.dart';
import '../modules/Home_Screen/views/home_screen_view.dart';
import '../modules/Login_Screen/bindings/login_screen_binding.dart';
import '../modules/Login_Screen/views/login_screen_view.dart';
import '../modules/Notification_Screen/bindings/notification_screen_binding.dart';
import '../modules/Notification_Screen/views/notification_screen_view.dart';
import '../modules/Pay_Shop_Rent/bindings/pay_shop_rent_binding.dart';
import '../modules/Pay_Shop_Rent/views/pay_shop_rent_view.dart';
import '../modules/Pay_Toll_Rent/bindings/pay_toll_rent_binding.dart';
import '../modules/Pay_Toll_Rent/views/pay_toll_rent_view.dart';
import '../modules/Setting_Screen/bindings/setting_screen_binding.dart';
import '../modules/Setting_Screen/views/setting_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => const LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SHOPS,
      page: () => const AddShopsView(),
      binding: AddShopsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TOLLS,
      page: () => const AddTollsView(),
      binding: AddTollsBinding(),
    ),
    GetPage(
      name: _Paths.PAY_SHOP_RENT,
      page: () => const PayShopRentView(),
      binding: PayShopRentBinding(),
    ),
    GetPage(
      name: _Paths.PAY_TOLL_RENT,
      page: () => const PayTollRentView(),
      binding: PayTollRentBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      page: () => const NotificationScreenView(),
      binding: NotificationScreenBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_SCREEN,
      page: () => const SettingScreenView(),
      binding: SettingScreenBinding(),
    ),
  ];
}
