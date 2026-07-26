class FirestoreService {
  final List<Map<String, dynamic>> _users = [];

  Future<bool> isPhoneTaken(String phone) async {
    return _users.any((user) => user['phone'] == phone);
  }

  Future<bool> isNationalIdTaken(String nationalId) async {
    return _users.any((user) => user['nationalId'] == nationalId);
  }

  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String nationalId,
  }) async {
    _users.add({
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }
}
