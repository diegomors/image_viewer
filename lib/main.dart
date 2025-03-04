// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'custom_slider/custom_slider.dart';
import 'network_image/network_image.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: MyCustomSlider(
                  'https://assets.flutterhub.dev/dash.svg',
                  lineColor: Colors.blue.shade50,
                  pointColor: Colors.blue,
                  onChange: (value) => print(value),
                ),
              ),
              const Divider(height: 5),
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
