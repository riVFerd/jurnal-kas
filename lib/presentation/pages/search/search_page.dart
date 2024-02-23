import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:pretest/presentation/widgets/button_with_asset.dart';
import 'package:pretest/presentation/widgets/transaction_card.dart';

import '../../../common/debouncer.dart';
import '../../bloc/category/category_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/rounded_divider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;
  late final Debouncer _debouncer;

  @override
  void initState() {
    _searchController = TextEditingController();
    _debouncer = Debouncer(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const RoundedDivider(
                width: 64,
                height: 4,
                color: Colors.grey,
                borderRadius: 24,
              ),
              const Gap(24),
              Row(
                children: [
                  const Spacer(),
                  ButtonWithAsset(
                    onPressed: () {},
                    buttonText: 'Pengaturan',
                    iconAsset: 'assets/icons/settings.png',
                    borderRadius: 24,
                    backgroundColor: blue,
                  ),
                  const Spacer(),
                ],
              ),
              const Gap(16),
              Text(
                'Temukan Catatanmu',
                style: StyleConstant.subTitleStyle,
              ),
              PhysicalModel(
                color: Colors.grey,
                elevation: 4,
                borderRadius: BorderRadius.circular(24),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _debouncer.run(() {
                      setState(() {});
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan kata kunci',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              const Gap(24),
              Expanded(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is! CategoryLoaded) {
                      BlocProvider.of<CategoryCubit>(context).getCategoryList();
                    }
                    final categoryList = (state as CategoryLoaded).categoryList;
                    return BlocBuilder<TransactionCubit, TransactionState>(
                      builder: (context, state) {
                        if (state is! TransactionLoaded) {
                          BlocProvider.of<TransactionCubit>(context).getTransactionList();
                          return const CircularProgressIndicator();
                        } else {
                          final transactionList = state.transactionList.where((element) {
                            return element.name
                                .toLowerCase()
                                .contains(_searchController.text.toLowerCase());
                          }).toList();
                          return ListView.builder(
                            itemCount: transactionList.length,
                            itemBuilder: (context, index) {
                              final category = categoryList.firstWhere(
                                (category) => category.id == transactionList.first.categoryId,
                              );
                              return TransactionCard(
                                category: category,
                                transaction: transactionList[index],
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
