import 'package:vendors/core/service/service_export.dart';

class Serviceinjector {
  RouterService routerService = RouterService();
  UtilityService utilityService = UtilityService();
  FirebaseService firebaseService = FirebaseService();
  AuthService authService = AuthService();
  DialogService dialogService = DialogService();
}

Serviceinjector si = Serviceinjector();
