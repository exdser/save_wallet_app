// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';

// class CryptoCoin extends Equatable {
//   final String name;
//   final double priceInUSD;
//   final String imageUrl;

//   const CryptoCoin({
//     required this.name,
//     required this.priceInUSD,
//     required this.imageUrl,
//   });

//   @override
//   List<Object> get props {
//     return [name, priceInUSD, imageUrl];
//   }
// }
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

class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSym,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hour,
  });

  final double priceInUSD;
  final String imageUrl;
  final String toSym;
  final DateTime lastUpdate;
  final double high24Hour;
  final double low24Hour;

  // Геттер для получения полного пути к картинке
  String get fullImageUrl => 'https://www.cryptocompare.com$imageUrl';

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
