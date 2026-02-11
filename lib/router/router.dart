import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/view/view.dart';
import 'package:crypto_coins_list/features/crypto_list/crypto_list.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes =>[
      AutoRoute(page: CryptoListRoute.page,path: '/'),
      AutoRoute(page: CryptoCoinRoute.page),
  ];
}

