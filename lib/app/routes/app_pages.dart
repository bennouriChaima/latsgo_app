import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/driver_screens/create_new_trip/bindings/create_new_trip_binding.dart';
import '../modules/driver_screens/create_new_trip/views/create_new_trip_view.dart';
import '../modules/driver_screens/sign_up/bindings/sign_up_binding.dart' as d;
import '../modules/driver_screens/sign_up/views/sign_up_view.dart' as d;
import '../modules/driver_screens/trips_management/bindings/trips_management_binding.dart';
import '../modules/driver_screens/trips_management/views/trips_management_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/otp_confirmation/bindings/otp_confirmation_binding.dart';
import '../modules/otp_confirmation/views/otp_confirmation_view.dart';
import '../modules/passenger_screens/my_trips/bindings/my_trips_binding.dart';
import '../modules/passenger_screens/my_trips/views/my_trips_view.dart';
import '../modules/passenger_screens/search/bindings/search_binding.dart';
import '../modules/passenger_screens/search/views/search_view.dart';
import '../modules/passenger_screens/sign_up/views/sign_up_view.dart' as p;
import '../modules/passenger_screens/trip_details/bindings/trip_details_binding.dart';
import '../modules/passenger_screens/trip_details/views/trip_details_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/type_selector/bindings/type_selector_binding.dart';
import '../modules/type_selector/views/type_selector_view.dart';

import '../modules/passenger_screens/sign_up/bindings/sign_up_binding.dart'
    as p;

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.TYPE_SELECTOR,
      page: () => const TypeSelectorView(),
      binding: TypeSelectorBinding(),
    ),
    GetPage(
      name: _Paths.OTP_CONFIRMATION,
      page: () => const OtpConfirmationView(),
      binding: OtpConfirmationBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_SIGN_UP,
      page: () => const p.SignUpView(),
      binding: p.SignUpBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_SIGN_UP,
      page: () => const d.SignUpView(),
      binding: d.SignUpBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_TRIPS_MANAGEMENT,
      page: () => const TripsManagementView(),
      binding: TripsManagementBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_CREATE_NEW_TRIP,
      page: () => const CreateNewTripView(),
      binding: CreateNewTripBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_TRIP_DETAILS,
      page: () => const TripDetailsView(),
      binding: TripDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_MY_TRIPS,
      page: () => const MyTripsView(),
      binding: MyTripsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
