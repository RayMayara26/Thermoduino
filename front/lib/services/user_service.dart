import '../models/user.model.dart' as model;

class UserService {
  static final List<model.User> _users = [];
  static model.User? _currentUser;

  static model.User? get currentUser => _currentUser;

  static Future<bool> login(String email, String password) async {
  try {
    final user = _users.firstWhere(
      (u) => u.email == email && u.password == password,
    );
    _currentUser = user;
    return true;
  } catch (e) {
    return false;
  }
}

  static Future<bool> register(model.User user) async {
    if (_users.any((u) => u.email == user.email)) return false;
    _users.add(user);
    return true;
  }

  static Future<bool> updateUser(model.User updated) async {
    final index = _users.indexWhere((u) => u.email == updated.email);
    if (index == -1) return false;
    _users[index] = updated;
    _currentUser = updated;
    return true;
  }

  static Future<void> deleteUser(String email) async {
    _users.removeWhere((u) => u.email == email);
    if (_currentUser?.email == email) _currentUser = null;
  }

  static Future<void> logout() async {
    _currentUser = null;
  }
}
