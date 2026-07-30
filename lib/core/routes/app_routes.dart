import 'dart:io';

import 'package:flutter/material.dart';
import 'package:san3a/payment/payment_screen.dart';

import '../../features/onboarding/models/account_type_model.dart';
import '../../features/onboarding/presentation/screens/booking_confirmation_screen.dart';
import '../../features/onboarding/presentation/screens/category_list_screen.dart';
import '../../features/onboarding/presentation/screens/home_page.dart';
import '../../features/onboarding/presentation/screens/live_tracking_screen.dart';
import '../../features/onboarding/presentation/screens/offers_page.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/orders_screen.dart';
import '../../features/onboarding/presentation/screens/placeholder_screen.dart';
import '../../features/onboarding/presentation/screens/profile_screen.dart';
import '../../features/onboarding/presentation/screens/rating_screen.dart';
import '../../features/onboarding/presentation/screens/services_page.dart';
import '../../features/onboarding/presentation/screens/settings_screen.dart';
import '../../features/onboarding/presentation/screens/technicians_page.dart';
import '../../services/elfanyscreen.dart';
import '../../services/loginscreen.dart';
import '../../services/signup_otp_screen.dart';
import '../../services/signup_step_two_screen.dart';
import '../../services/signupstep1.dart';
import '../../thefanypov/fany_home_page.dart';
import '../../thefanypov/service_request_page.dart';

class SignUpFlowArgs {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String nationalId;
  final AccountType accountType;
  final String? criminalRecordImagePath;

  const SignUpFlowArgs({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.nationalId,
    required this.accountType,
    this.criminalRecordImagePath,
  });
}

abstract final class AppRoutes {
  static const String onboarding = '/';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String technicianSignUp = '/signup/technician';
  static const String signUpStepTwo = '/signup/step-two';
  static const String signUpOtp = '/signup/otp';
  static const String services = '/services';
  static const String offers = '/offers';
  static const String technicians = '/technicians';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String settings = '/settings';
  static const String categories = '/categories';
  static const String placeholder = '/placeholder';
  static const String payment = '/payment';
  static const String bookingConfirmation = '/booking-confirmation';
  static const String liveTracking = '/live-tracking';
  static const String rating = '/rating';
  static const String technicianHome = '/technician-home';
  static const String createRequest = '/create-request';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (_) => const OnboardingScreen(),
      splash: (_) => const SplashScreen(),
      home: (_) => const HomePage(),
      login: (_) => const LoginScreen(),
      signUp: (_) => const SignUpStepOneScreen(),
      technicianSignUp: (_) => const ElFanyScreen(),
      services: (_) => const ServicesPage(),
      offers: (_) => const OffersPage(),
      technicians: (_) => const TechniciansPage(),
      profile: (_) => const ProfileScreen(),
      orders: (_) => const OrdersScreen(),
      settings: (_) => const SettingsScreen(),
      categories: (_) => const CategoryListScreen(),
      placeholder: (_) => const PlaceholderScreen(),
      payment: (_) => const PaymentScreen(),
      bookingConfirmation: (_) => const BookingConfirmationScreen(),
      liveTracking: (_) => const LiveTrackingScreen(),
      rating: (_) => const RatingScreen(),
      technicianHome: (_) => const TechnicianHomePage(),
      createRequest: (_) => const ServiceRequestsPage(),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUpStepTwo:
        if (settings.arguments is SignUpFlowArgs) {
          final args = settings.arguments as SignUpFlowArgs;
          return MaterialPageRoute(
            builder: (_) => SignUpStepTwoScreen(
              fullName: args.fullName,
              email: args.email,
              phoneNumber: args.phoneNumber,
              nationalId: args.nationalId,
              accountType: args.accountType,
              criminalRecordImage: args.criminalRecordImagePath == null
                  ? null
                  : File(args.criminalRecordImagePath!),
            ),
          );
        }
        return _errorRoute();
      case signUpOtp:
        if (settings.arguments is SignUpFlowArgs) {
          final args = settings.arguments as SignUpFlowArgs;
          return MaterialPageRoute(
            builder: (_) => SignUpOtpScreen(
              fullName: args.fullName,
              email: args.email,
              phoneNumber: args.phoneNumber,
              nationalId: args.nationalId,
              accountType: args.accountType,
              criminalRecordImagePath: args.criminalRecordImagePath,
            ),
          );
        }
        return _errorRoute();
      default:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Route not found'))),
    );
  }
}
