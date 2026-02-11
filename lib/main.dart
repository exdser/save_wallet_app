import 'dart:async';

import 'package:crypto_coins_list/crypto_app.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() {
  // 1. Сначала инициализируем Talker, так как он нужен для логирования ошибок в зоне
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  // 2. Оборачиваем всё выполнение в runZonedGuarded
  runZonedGuarded(() async {
    // Теперь ВСЕ вызовы внутри этой зоны
    WidgetsFlutterBinding.ensureInitialized();

    // Инициализация Firebase
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    talker.info('Firebase App ID: ${app.options.appId}');
    talker.debug('Talker started...');
    const cryptoCoinsBoxName = 'crypto_coins_box';
    //Инициализация Hive
    await Hive.initFlutter();
    Hive.registerAdapter(CryptoCoinAdapter());
    Hive.registerAdapter(CryptoCoinDetailAdapter());

    final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

    // Настройка Dio
    final dio = Dio();
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(printResponseData: false),
      ),
    );

    // Настройка Bloc Observer
    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
        printStateFullData: false,
        printEventFullData: false,
      ),
    );

    // Регистрация репозитория
    GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(
        dio: dio,
        cryptoCoinsBox: cryptoCoinsBox,
      ),
    );

    // Обработка ошибок Flutter внутри зоны
    FlutterError.onError = (details) {
      talker.handle(details.exception, details.stack);
    };

    // Запуск приложения
    runApp(const CryptoCurrenciesListApp());
  }, (error, stack) {
    // Глобальный перехват ошибок Dart (out of zone/async errors)
    GetIt.I<Talker>().handle(error, stack);
  });
}
