class BankInfo {

  int id;
  String fullName;
  int mobile;
  String email;
  int accountNum;
  int ifsc;
  int balance;

  BankInfo({
    this.id,
    this.fullName,
    this.mobile,
    this.email,
    this.accountNum,
    this.ifsc,
    this.balance,
  });

  factory BankInfo.fromMap(Map<String, dynamic> json) =>
      BankInfo(
        id: json["id"],
        fullName: json["fullName"],
        mobile: json["mobile"],
        email: json["email"],
        accountNum: json["accountNum"],
        ifsc: json["ifsc"],
        balance: json["balance"],
      );

  Map<String, dynamic> toMap() => {
      "id": id,
      "fullName": fullName,
      "mobile": mobile,
      "email": email,
      "accountNum": accountNum,
      "ifsc": ifsc,
      "balance": balance,
    };
}
