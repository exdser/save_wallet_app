import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      trailing: const Icon(Icons.arrow_forward_ios),
      leading: Image.network(
        coin.details.imageUrl,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
      title: Text(coin.name, style: theme.textTheme.bodyLarge),
      subtitle: Text(
        '${coin.details.priceInUSD.toStringAsFixed(2)}\$',
        style: theme.textTheme.bodyMedium,
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coin);
      },
    );
  }
}
