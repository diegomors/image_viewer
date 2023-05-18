import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'my_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final loading = Shimmer(
      color: Colors.grey.shade500,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
      ),
    );

    final error = Center(
      child: Text(
        'Something went wrong!',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyNetworkImage('https://assets.flutterhub.dev/dash.png', loading: loading, error: error),
              const Divider(height: 5),
              MyNetworkImage('https://assets.flutterhub.dev/dash.jpg', loading: loading, error: error),
              const Divider(height: 5),
              MyNetworkImage('https://assets.flutterhub.dev/dash.svg', loading: loading, error: error),
            ],
          ),
        ),
      ),
    );
  }
}
