import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String nationalId;
  final String accountType;
  final String? criminalRecordImagePath;
  final DateTime? createdAt;

  UserProfile({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.accountType,
    this.criminalRecordImagePath,
    this.createdAt,
  });

  factory UserProfile.fromMap(String uid, Map<String, dynamic> map) {
    return UserProfile(
      uid: uid,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      nationalId: map['nationalId'] as String? ?? '',
      accountType: map['accountType'] as String? ?? 'customer',
      criminalRecordImagePath: map['criminalRecordImagePath'] as String?,
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  Future<bool> isPhoneTaken(String phone) async {
    final query = await _users.where('phone', isEqualTo: phone).limit(1).get();
    return query.docs.isNotEmpty;
  }

  Future<bool> isNationalIdTaken(String nationalId) async {
    final query = await _users
        .where('nationalId', isEqualTo: nationalId)
        .limit(1)
        .get();
    return query.docs.isNotEmpty;
  }

  Future<void> saveUserProfile({
    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String nationalId,
    required String accountType,
    String? criminalRecordImagePath,
  }) async {
    await _users.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'accountType': accountType,
      'criminalRecordImagePath': criminalRecordImagePath,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    final snapshot = await _users.doc(uid).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return UserProfile.fromMap(uid, snapshot.data()!);
  }
}
