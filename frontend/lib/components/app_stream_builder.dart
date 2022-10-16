import 'package:flutter/material.dart';

/// Works like StreamBuilder except you can set the loadingBuilder which will be returned when the builder waiting for data
class AppStreamBuilder<T> extends StatelessWidget {
  final T? initialData;
  final Stream<T>? stream;
  final AsyncWidgetBuilder<T> builder;
  final Widget? loadingBuilder;

  const AppStreamBuilder({
    required this.builder,
    this.initialData,
    this.stream,
    this.loadingBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        initialData: initialData,
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingBuilder ??
                const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) return Text(snapshot.error.toString());

          return builder(context, snapshot);
        });
  }
}
