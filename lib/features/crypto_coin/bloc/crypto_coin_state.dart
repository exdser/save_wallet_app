 part of 'crypto_coin_bloc.dart';
abstract class CryptoCoinDetailsState  extends Equatable{}

class CryptoCoinDetailsInitial extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoading extends CryptoCoinDetailsState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailsLoaded extends CryptoCoinDetailsState {
  final List<CryptoCoinsDetails> coinsDetail;

  CryptoCoinDetailsLoaded({required this.coinsDetail});
  
  @override
  List<Object?> get props => [coinsDetail];
}

class CryptoCoinDetailsLoadingFailure extends CryptoCoinDetailsState {
  final  Object? exception;

  CryptoCoinDetailsLoadingFailure({this.exception});
  
  @override
  List<Object?> get props => [exception];
}
