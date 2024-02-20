import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretest/data/repositories/category_repository_impl.dart';
import 'package:pretest/data/repositories/dompet_repository_impl.dart';
import 'package:pretest/data/repositories/transaction_repository_impl.dart';
import 'package:pretest/presentation/bloc/category/category_cubit.dart';
import 'package:pretest/presentation/bloc/dompet/dompet_cubit.dart';
import 'package:pretest/presentation/router/app_router.dart';

import 'firebase_options.dart';
import 'presentation/bloc/transaction/transaction_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DompetCubit(DompetRepositoryImpl()),
        ),
        BlocProvider(
          create: (_) => CategoryCubit(CategoryRepositoryImpl()),
        ),
        BlocProvider(create: (_) => TransactionCubit(TransactionRepositoryImpl())),
      ],
      child: MaterialApp(
        title: 'Pretest Otak Kanan',
        theme: ThemeData(
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
