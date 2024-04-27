import 'package:flutter/foundation.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthMethode _authMethode = AuthMethode();

  Users? get user => _user;

  Future<void> refreshUser() async {
    final Users? user = await _authMethode.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
