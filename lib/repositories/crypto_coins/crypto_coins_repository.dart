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
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key,
        priceInUSD: price,
        imageUrl: 'https://www.cryptocompare.com/$imageUrl',
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
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw['USD']  as Map<String, dynamic>;
    final cryptoCoinsListDetails = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      final lastUpdate = usdData['LASTUPDATE'];
      final high24h = usdData['HIGH24HOUR'];
      final low24h = usdData['LOW24HOUR'];
      return  CryptoCoin(name: currencyCode, priceInUSD:price , imageUrl: imageUrl);
    }).toList();
    
  }
}
