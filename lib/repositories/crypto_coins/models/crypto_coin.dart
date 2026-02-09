
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coins_details.dart';
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  const CryptoCoin({
    required this.name,
    required this.details, // Теперь мы храним все данные внутри объекта details
  });

  final String name;
  final CryptoCoinDetail details;

  @override
  List<Object?> get props => [name, details];
}


