// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String name;
  final double priceInUSD;
  final String imageUrl;

  const CryptoCoin({
    required this.name,
    required this.priceInUSD,
    required this.imageUrl,
  });

  @override
  List<Object> get props {
    return [name, priceInUSD, imageUrl];
  }
}
