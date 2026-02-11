import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
      cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD!.compareTo(a.details.priceInUSD!));
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,XRP,DOGE,USDT,USDC,LINK,DOT,XMR,ZEC,DASH,ALEO,MINA,UNI,CAKE,TWT,ADA,TRX,APT,LNEX,SHIB,TON,BONK,FTM,GRT,AAVE,AXS,MATIC&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(name: e.key, details: details);
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCryptoCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  Future<CryptoCoin> _fetchCryptoCoinDetailsFromApi(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,XRP,DOGE,USDT,USDC,LINK,DOT,XMR,ZEC,DASH,ALEO,MINA,UNI,CAKE,TWT,ADA,TRX,APT,LNEX,SHIB,TON,BONK,FTM,GRT,AAVE,AXS,MATIC&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final rawData = data['RAW'] as Map<String, dynamic>;
    final coinData = rawData[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(name: currencyCode, details: details);
  }
}
