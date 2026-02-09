import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coins_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSym,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });
  @HiveField(0)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;
  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;
  @HiveField(2)
  @JsonKey(name: 'TOSYMBOL')
  final String toSym;
  @HiveField(3)
  @JsonKey(
    name: 'LASTUPDATE',
    toJson: _dateTimeToJson,
    fromJson: _dateTimeFromJson,
  )
  final DateTime lastUpdate;
  @HiveField(4)
  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hour;
  @HiveField(5)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hour;

  String get fullImageUrl => 'https://www.cryptocompare.com$imageUrl';

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  static int _dateTimeToJson(DateTime datetime) =>
      datetime.millisecondsSinceEpoch;
  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);
  @override
  List<Object?> get props => [
        priceInUSD,
        imageUrl,
        toSym,
        lastUpdate,
        high24Hour,
        low24Hour,
      ];
}
