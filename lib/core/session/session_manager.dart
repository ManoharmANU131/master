import 'package:my_contacts_app/core/helpers/shared_preference_helper.dart';

class SessionManager {
  static const String _onboardingKey = "has_completed_onboarding";

  static Future<void> setOnboardingCompleted(bool value) async {
    await SharedPreferenceHelper.setValue(_onboardingKey, value);
  }

  static Future<bool> hasCompletedOnboarding() async {
    return await SharedPreferenceHelper.getValue(_onboardingKey) ?? false;
  }
}
