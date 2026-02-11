import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart'; // ВАЖНО: hive_ce
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coins_details.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    this.priceInUSD = 0.0,
    this.imageUrl = '',
    this.toSym = '',
    required this.lastUpdate,
    this.high24Hour = 0.0,
    this.low24Hour = 0.0,
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
  static DateTime _dateTimeFromJson(dynamic milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch((milliseconds as num).toInt());

  @override
  List<Object?> get props => [priceInUSD, imageUrl, toSym, lastUpdate, high24Hour, low24Hour];
}
