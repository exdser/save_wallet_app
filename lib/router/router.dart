import 'package:crypto_coins_list/features/crypto_coin/view/view.dart';
import 'package:crypto_coins_list/features/crypto_list/crypto_list.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';

final routes = {
  '/': (context) => CryptoListScreen(),
  '/coin': (context) => CryptoCoinScreen(coin: ModalRoute.of(context)?.settings.arguments as CryptoCoin) ,
  
};
