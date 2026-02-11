import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key, required this.coin});
  final CryptoCoin coin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  // Мы создаем Блок один раз. Переменные imageUrl, price и т.д. нам тут НЕ НУЖНЫ.
  late final CryptoCoinDetailsBloc _cryptoDetailsBloc;

  @override
  void initState() {
    super.initState();
    _cryptoDetailsBloc = CryptoCoinDetailsBloc(
      GetIt.I<AbstractCoinsRepository>(),
    );
    // Загружаем данные только один раз при старте
    _cryptoDetailsBloc.add(LoadCryptoDetails(currencyCode: widget.coin.name));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // Кнопка назад и имя монеты в заголовке
      appBar: AppBar(title: Text(widget.coin.name)),
      body: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
        bloc: _cryptoDetailsBloc,
        builder: (context, state) {
          // Если данные загружены успешно
          if (state is CryptoCoinDetailsLoaded) {
            final coin = state.coin; // Берем монету из стейта
            final details = coin.details; // Берем детали (нашу новую модель)

            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(
                      details.imageUrl,
                      // Защита от ошибок загрузки картинки
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.currency_bitcoin, size: 100),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    coin.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Карточка с ценой
                  _PriceCard(price: details.priceInUSD, theme: theme),
                  const SizedBox(height: 10),
                  // Карточка с High/Low
                  _StatsCard(details: details, theme: theme),
                ],
              ),
            );
          }

          // Если произошла ошибка
          if (state is CryptoCoinDetailsLoadingFailure) {
            return _ErrorWidget(
              onRetry: () {
                _cryptoDetailsBloc.add(
                  LoadCryptoDetails(currencyCode: widget.coin.name),
                );
              },
            );
          }

          // Показываем загрузку
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// Вынес блоки в отдельные виджеты для чистоты кода
class _PriceCard extends StatelessWidget {
  const _PriceCard({required this.price, required this.theme});
  final double price;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          "${price.toStringAsFixed(2)} \$",
          style: theme.textTheme.labelMedium?.copyWith(fontSize: 25),
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.details, required this.theme});
  final CryptoCoinDetail details;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _RowInfo(
            label: "High 24 Hour",
            value: "${details.high24Hour.toStringAsFixed(2)} \$",
          ),
          const SizedBox(height: 10),
          _RowInfo(
            label: "Low 24 Hour",
            value: "${details.low24Hour.toStringAsFixed(2)} \$",
          ),
        ],
      ),
    );
  }
}

class _RowInfo extends StatelessWidget {
  const _RowInfo({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Something went wrong', style: TextStyle(fontSize: 20)),
          TextButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    );
  }
}
