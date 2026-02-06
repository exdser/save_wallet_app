import 'package:flutter/material.dart';

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
      body: Center(
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
                    style: theme.textTheme.labelMedium?.copyWith(fontSize: 25),
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
      ),
    );
  }
}
