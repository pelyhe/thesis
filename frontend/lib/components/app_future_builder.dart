import 'package:flutter/material.dart';

/// Works like FutureBuilder except you can set the loadingBuilder which will be returned when the builder waiting for data
class AppFutureBuilder<T> extends StatelessWidget {
  final T? initialData;
  final Future<T>? future;
  final AsyncWidgetBuilder<T> builder;
  final Widget? loadingBuilder;

  const AppFutureBuilder({
    required this.builder,
    this.initialData,
    this.future,
    this.loadingBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      key: key,
      initialData: initialData,
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingBuilder ??
              const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) return Text(snapshot.error.toString());

        return builder(context, snapshot);
      },
    );
  }
}
