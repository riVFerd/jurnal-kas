import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretest/data/repositories/category_repository_impl.dart';
import 'package:pretest/data/repositories/dompet_repository_impl.dart';
import 'package:pretest/data/repositories/transaction_repository_impl.dart';
import 'package:pretest/data/repositories/user_repository_impl.dart';
import 'package:pretest/presentation/bloc/category/category_cubit.dart';
import 'package:pretest/presentation/bloc/dompet/dompet_cubit.dart';
import 'package:pretest/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:pretest/presentation/router/app_router.dart';

import 'bloc/user/user_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

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
        BlocProvider(
          create: (_) => TransactionCubit(TransactionRepositoryImpl()),
        ),
        BlocProvider(
          create: (_) => UserCubit(UserRepositoryImpl()),
        ),
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
