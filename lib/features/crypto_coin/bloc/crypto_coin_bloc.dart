import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coins_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository) : super(CryptoCoinDetailsInitial()) {
    on<LoadCryptoDetails>(_load);
  }
  final AbstractCoinsRepository coinsRepository;
  Future<void> _load(LoadCryptoDetails event,Emitter<CryptoCoinDetailsState> emit) async{
      try {
        if (state is! CryptoCoinDetailsLoaded) {
          emit(CryptoCoinDetailsLoading());
        }
        final coinsDetails = await coinsRepository.getCoinDetails();
        emit(CryptoCoinDetailsLoaded(coinsDetail:coinsDetails));
      } catch (e) {
        emit(CryptoCoinDetailsLoadingFailure(exception: e));
      }
  }
}
