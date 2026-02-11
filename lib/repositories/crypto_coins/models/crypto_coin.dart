import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coins_details.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_ce/hive.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
class CryptoCoin extends Equatable {
  const CryptoCoin({
    this.name = '',
    required this.details, // Теперь мы храним все данные внутри объекта details
  });
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetail details;

  @override
  List<Object?> get props => [name, details];
}
