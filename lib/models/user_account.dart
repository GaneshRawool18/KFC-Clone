class UserAccount {
  String? uid;
  String name;
  String email;
  String? mobileNumber;
  bool? receiveKfcNews;
  bool? receiveMarketingEmails;
  bool? receiveSms;

  UserAccount({
    this.uid,
    required this.name,
    required this.email,
    this.mobileNumber,
    this.receiveKfcNews = false,
    this.receiveMarketingEmails = false,
    this.receiveSms = false,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      uid: json['uid'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'],
      receiveKfcNews: json['receiveKfcNews'] as bool? ?? false,
      receiveMarketingEmails: json['receiveMarketingEmails'] as bool? ?? false,
      receiveSms: json['receiveSms'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobileNumber': mobileNumber,
      'receiveKfcNews': receiveKfcNews,
      'receiveMarketingEmails': receiveMarketingEmails,
      'receiveSms': receiveSms,
    };
  }
}