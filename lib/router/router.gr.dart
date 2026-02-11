// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CryptoCoinScreen]
class CryptoCoinRoute extends PageRouteInfo<CryptoCoinRouteArgs> {
  CryptoCoinRoute({
    Key? key,
    required CryptoCoin coin,
    List<PageRouteInfo>? children,
  }) : super(
          CryptoCoinRoute.name,
          args: CryptoCoinRouteArgs(key: key, coin: coin),
          initialChildren: children,
        );

  static const String name = 'CryptoCoinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CryptoCoinRouteArgs>();
      return CryptoCoinScreen(key: args.key, coin: args.coin);
    },
  );
}

class CryptoCoinRouteArgs {
  const CryptoCoinRouteArgs({this.key, required this.coin});

  final Key? key;

  final CryptoCoin coin;

  @override
  String toString() {
    return 'CryptoCoinRouteArgs{key: $key, coin: $coin}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CryptoCoinRouteArgs) return false;
    return key == other.key && coin == other.coin;
  }

  @override
  int get hashCode => key.hashCode ^ coin.hashCode;
}

/// generated route for
/// [CryptoListScreen]
class CryptoListRoute extends PageRouteInfo<void> {
  const CryptoListRoute({List<PageRouteInfo>? children})
      : super(CryptoListRoute.name, initialChildren: children);

  static const String name = 'CryptoListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CryptoListScreen();
    },
  );
}
