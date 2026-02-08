import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required this.dio});
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,XRP,DOGE,USDT,USDC,LINK,DOT,XMR,ZEC,DASH,ALEO,MINA,UNI,CAKE,TWT,ADA,TRX,APT,LNEX,SHIB,TON,BONK,FTM,GRT,AAVE,AXS,MATIC&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

      return CryptoCoin(
        name: e.key,
        details: CryptoCoinDetail(
          priceInUSD: (usdData['PRICE'] as num).toDouble(),
          imageUrl: usdData['IMAGEURL'],
          toSym: usdData['TOSYMBOL'],
          lastUpdate: DateTime.fromMillisecondsSinceEpoch(
            (usdData['LASTUPDATE'] as int) * 1000,
          ),
          high24Hour: (usdData['HIGH24HOUR'] as num).toDouble(),
          low24Hour: (usdData['LOW24HOUR'] as num).toDouble(),
        ),
      );
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,XRP,DOGE,USDT,USDC,LINK,DOT,XMR,ZEC,DASH,ALEO,MINA,UNI,CAKE,TWT,ADA,TRX,APT,LNEX,SHIB,TON,BONK,FTM,GRT,AAVE,AXS,MATIC&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final rawData = data['RAW'] as Map<String, dynamic>;
    final coinData = rawData[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    return CryptoCoin(
      name: currencyCode,
      details: CryptoCoinDetail(
        priceInUSD: (usdData['PRICE'] as num).toDouble(),
        imageUrl: usdData['IMAGEURL'],
        toSym: usdData['TOSYMBOL'],
        lastUpdate: DateTime.fromMillisecondsSinceEpoch(
          (usdData['LASTUPDATE'] as int) * 1000,
        ),
        high24Hour: (usdData['HIGH24HOUR'] as num).toDouble(),
        low24Hour: (usdData['LOW24HOUR'] as num).toDouble(),
      ),
    );
  }
}
