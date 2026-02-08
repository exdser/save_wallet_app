
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinsDetails extends CryptoCoin {
  final double high24h;
  final double low24h;
  final DateTime lastUpdate;

  const CryptoCoinsDetails({
    required this.high24h,
    required this.low24h,
    required this.lastUpdate,
    required super.name, required super.details,
  });

  @override
  List<Object> get props {
    return [high24h, low24h, name, lastUpdate];
  }
}
