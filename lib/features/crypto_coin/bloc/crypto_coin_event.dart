part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinDetailsEvent extends Equatable {
  const CryptoCoinDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadCryptoDetails extends CryptoCoinDetailsEvent {
  const LoadCryptoDetails({
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  List<Object> get props => super.props..add(currencyCode);
}
