import 'dart:async';

import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? imageUrl;
  String? coinName;
  double? high24h;
  double? low24h;
  double? priceInUsd;
  final _cryptoDetailsBloc = CryptoCoinDetailsBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );
  @override
  void initState() {
    _cryptoDetailsBloc.add(LoadCryptoDetails());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Set<Object>, 'You must provide args');
    if (args is Set<Object>) {
      coinName = args.elementAt(0) as String;
      high24h = args.elementAt(1) as double;
      low24h = args.elementAt(2) as double;
      imageUrl = args.elementAt(3) as String;
      priceInUsd = args.elementAt(4) as double;
    }
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoDetailsBloc.add(LoadCryptoDetails(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
          bloc: _cryptoDetailsBloc,
          builder: (context, state) {
            if (state is CryptoCoinDetailsLoaded) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.network(imageUrl ?? 'IMAGE'),
                    ),
                    Text(
                      coinName ?? '...',
                      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "${priceInUsd!.toStringAsFixed(2)}\$",
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "High 24 Hour            ${high24h!.toStringAsFixed(2)}\$",
                              style: theme.textTheme.labelMedium,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Low 24 Hour             ${low24h!.toStringAsFixed(2)}\$',
                              style: theme.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CryptoCoinDetailsLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(fontSize: 25),
                    ),
                    Text(
                      'Please try again later',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      onPressed: () {
                        _cryptoDetailsBloc.add(LoadCryptoDetails());
                      },
                      child: Text('Try again', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),

      //
    );
  }
}
