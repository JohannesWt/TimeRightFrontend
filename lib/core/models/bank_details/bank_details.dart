import 'package:json_annotation/json_annotation.dart';

part 'bank_details.g.dart';

@JsonSerializable()
class BankDetails {
  BankDetails({this.receiver, this.bankName, this.iBAN, this.validFrom});

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsToJson(this);

  String receiver;
  String bankName;
  String iBAN;
  String validFrom;
}
