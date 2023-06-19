enum UserRole {
  member,
  clubPvst,
  regionCoordinator,
  departmentChairperson,
  districtMember,
  districtPvst,
  pvst
}

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String homeClub;
  final String region;
  final String department;
  final String designation;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.homeClub,
    required this.region,
    required this.department,
    required this.designation,
  });
}
