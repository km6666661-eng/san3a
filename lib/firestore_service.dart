import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users => _db.collection('users');

  /// Returns true if a user document already exists with this phone number.
  Future<bool> isPhoneTaken(String phone) async {
    final query = await _users.where('phone', isEqualTo: phone).limit(1).get();
    return query.docs.isNotEmpty;
  }

  /// Returns true if a user document already exists with this national ID.
  Future<bool> isNationalIdTaken(String nationalId) async {
    final query = await _users.where('nationalId', isEqualTo: nationalId).limit(1).get();
    return query.docs.isNotEmpty;
  }

  /// Saves the user's profile data after their account is created and
  /// their phone number is verified.
  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String nationalId,
  }) async {
    await _users.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}