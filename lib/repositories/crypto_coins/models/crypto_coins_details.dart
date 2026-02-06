// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CryptoCoinsDetails extends Equatable {

  final double high24h;
  final double low24h;

  final String name;
  final double priceInUSD;
  final String imageUrl;

  const CryptoCoinsDetails({required this.name, required this.priceInUSD, required this.imageUrl, required this.high24h, required this.low24h});

  @override
  List<Object> get props {
    return [
      high24h,
      low24h,
      name,
      priceInUSD,
      imageUrl,
    ];
  }
}
