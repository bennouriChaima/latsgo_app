part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  //common routes
  static const SIGN_IN = _Paths.SIGN_IN;

  //passenger routes
  static const SPLASH = _Paths.SPLASH;
  static const TYPE_SELECTOR = _Paths.TYPE_SELECTOR;
  static const OTP_CONFIRMATION = _Paths.OTP_CONFIRMATION;
  static const PASSENGER_SIGN_UP = _Paths.PASSENGER_SIGN_UP;
  static const PASSENGER_SEARCH = _Paths.PASSENGER_SEARCH;
  static const PROFILE = _Paths.PROFILE;
  static const DRIVER_SIGN_UP = _Paths.DRIVER_SIGN_UP;
  static const DRIVER_TRIPS_MANAGEMENT = _Paths.DRIVER_TRIPS_MANAGEMENT;
  static const DRIVER_CREATE_NEW_TRIP = _Paths.DRIVER_CREATE_NEW_TRIP;
  static const PASSENGER_TRIP_DETAILS = _Paths.PASSENGER_TRIP_DETAILS;
  static const PASSENGER_MY_TRIPS = _Paths.PASSENGER_MY_TRIPS;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const CONTACT_US = _Paths.CONTACT_US;
  static const ABOUT = _Paths.ABOUT;
}

abstract class _Paths {
  _Paths._();
  //common routes
  static const SPLASH = '/splash';
  static const TYPE_SELECTOR = '/type-selector';
  static const SIGN_IN = '/sign-in';
  static const OTP_CONFIRMATION = '/otp-confirmation';
  static const PROFILE = '/profile';

  //passenger routes
  static const PASSENGER_SIGN_UP = '/passenger-sign-up';
  static const PASSENGER_SEARCH = '/passenger-search';
  static const PASSENGER_TRIP_DETAILS = '/passenger-trip-details';
  static const PASSENGER_MY_TRIPS = '/my-trips';

  //driver routes
  static const DRIVER_SIGN_UP = '/driver-sign-up';
  static const DRIVER_TRIPS_MANAGEMENT = '/driver-trips-management';
  static const DRIVER_CREATE_NEW_TRIP = '/driver-create-new-trip';
  static const NOTIFICATIONS = '/notifications';
  static const CONTACT_US = '/contact-us';
  static const ABOUT = '/about';
}
