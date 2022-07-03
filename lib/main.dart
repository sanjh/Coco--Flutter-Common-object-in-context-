import 'package:coco_mobile/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/coco_bloc.dart';
import 'presentation_layer/pages/home.dart';

import 'push_container.dart';

void main() {
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: servLocator<CocoBloc>()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: servLocator<SearchProvider>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KC DEMO',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
