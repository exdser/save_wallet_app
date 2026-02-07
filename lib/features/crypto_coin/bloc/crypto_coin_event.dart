part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinDetailsEvent extends Equatable {}

class LoadCryptoDetails extends CryptoCoinDetailsEvent {
  final Completer? completer;

  LoadCryptoDetails({this.completer});

  @override
  List<Object?> get props => [completer];
}
