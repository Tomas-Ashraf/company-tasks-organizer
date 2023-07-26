// ignore_for_file: prefer_typing_uninitialized_variables

abstract class AppStates {}

class AppInitailStates extends AppStates {}

class AppChangeBottomNavBar extends AppStates {}

class AppBottomNavState extends AppStates {}

class AppDatePickerState extends AppStates {}

class AppDropMenuState extends AppStates {}

class AppImagePickerState extends AppStates {}

class AppImageUploadState extends AppStates {}

class AppIsloadingState extends AppStates {}

class TaskCompanySecurePasswordState extends AppStates {}

class TaskCompanyChangeModeState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppThemeState extends AppStates {}

class AppTaskCompanyChangeBottomNavBar extends AppStates {}

class GiveMissionState extends AppStates {}

class GivePermissionState extends AppStates {}

class ChangeCheckBox extends AppStates {}

class RemoveCheck extends AppStates {}

class AddTaskSuccessful extends AppStates {}

class AddTaskError extends AppStates {
  final error;

  AddTaskError(this.error);
}

class DeleteTaskSuccessful extends AppStates {}

class DeleteTaskFinished extends AppStates {}

class EditTaskSuccessful extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class AddBackUpSuccessful extends AppStates {}

class AddBackUpError extends AppStates {
  final error;

  AddBackUpError(this.error);
}

class AddContact extends AppStates {}

// Login States

abstract class AppLoginStates {}

class TaskCompanyLoginInitialState extends AppLoginStates {}

class AppLoginSecurePassword extends AppLoginStates {}

class AppIntroState extends AppLoginStates {}

// Attending States

abstract class AttendingStates {}

class AppAttendingInitialState extends AttendingStates {}

class SelectPermission extends AppLoginStates {}

class GetName extends AppLoginStates {}

class ChangeCheckIn extends AppLoginStates {}

class ChangeCheckOut extends AppLoginStates {}

class AppLoginLoadingPage extends AppLoginStates {}
