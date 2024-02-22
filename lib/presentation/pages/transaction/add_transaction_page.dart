import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/common/datetime_extentions.dart';
import 'package:pretest/domain/entities/dompet.dart';
import 'package:pretest/presentation/constants/style_constant.dart';
import 'package:pretest/presentation/widgets/numpad_widget.dart';

import '../../../data/models/transaction_model.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/category/category_cubit.dart';
import '../../bloc/dompet/dompet_cubit.dart';
import '../../bloc/transaction/transaction_cubit.dart';
import '../../constants/color_constant.dart';
import '../../widgets/card_button.dart';
import '../../widgets/rounded_divider.dart';
import '../../widgets/selectable_tab.dart';
import '../category/add_category_modal.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  static const routeName = '/add-transaction';

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSelectDompet = false;
  Category? _selectedCategory;
  Dompet? _selectedDompet;
  DateTime _selectedDate = DateTime.now();
  final _nameController = TextEditingController();
  final _nominalController = TextEditingController();
  final _today = DateTime.now();
  TransactionType _transactionType = TransactionType.income;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isSelectDompet = _tabController.index == 0;
      });
    });
    _tabController.index = 1;
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          primary: true,
          child: Column(
            children: [
              RoundedDivider(
                width: MediaQuery.of(context).size.width / 5,
                height: 4,
                color: Colors.grey,
                borderRadius: 24,
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableTab(
                    isSelected: _isSelectDompet,
                    label: 'Dompet',
                    iconPath: 'assets/icons/wallet-outlined.png',
                    onTap: () => setState(() {
                      _isSelectDompet = true;
                      _tabController.animateTo(0);
                    }),
                  ),
                  SelectableTab(
                    isSelected: !_isSelectDompet,
                    label: 'Kategori',
                    iconPath: 'assets/icons/category-flat.png',
                    onTap: () => setState(() {
                      _isSelectDompet = false;
                      _tabController.animateTo(1);
                    }),
                  ),
                ],
              ),
              const Gap(24),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5 - 32,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _dompetListTab(),
                    _categoryListTab(),
                  ],
                ),
              ),
              const Gap(16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/category-flat.png',
                              scale: 2,
                              height: 24,
                              color: blue,
                            ),
                            Text(
                              _selectedCategory?.name ?? 'Pilih Kategori',
                              style: StyleConstant.bodyStyle.copyWith(color: blue),
                            ),
                          ],
                        ),
                        switch (_selectedDompet) {
                          null => const Text('Pilih Dompet'),
                          Dompet _ => Image.asset(
                              _selectedDompet!.iconPath,
                              height: 32,
                            ),
                        },
                      ],
                    ),
                    const Gap(16),
                    ToggleButtons(
                      isSelected: [
                        _transactionType == TransactionType.income,
                        _transactionType == TransactionType.expense,
                      ],
                      onPressed: (index) {
                        setState(() {
                          _transactionType =
                              index == 0 ? TransactionType.income : TransactionType.expense;
                        });
                      },
                      selectedColor: blue,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.arrow_downward,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              'Pemasukan',
                              style: StyleConstant.bodyPoppinsStyle
                                  .copyWith(color: blue, fontWeight: FontWeight.bold),
                            ),
                            const Gap(8),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.arrow_upward,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              'Pengeluaran',
                              style: StyleConstant.bodyPoppinsStyle.copyWith(
                                color: blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(8),
                          ],
                        ),
                      ],
                    ),
                    TextField(
                      controller: _nameController,
                      style: StyleConstant.bodyPoppinsStyle.copyWith(color: blue),
                      decoration: StyleConstant.underlinInputDecoration.copyWith(
                        label: const Text('Keterangan'),
                      ),
                    ),
                    const Gap(16),
                    TextField(
                      controller: _nominalController,
                      style: StyleConstant.bodyPoppinsStyle.copyWith(color: blue),
                      decoration: StyleConstant.underlinInputDecoration.copyWith(
                        label: const Text('Nominal'),
                        prefix: Text(
                          'Rp ',
                          style: StyleConstant.bodyPoppinsStyle.copyWith(color: blue),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => _selectDate(context),
                              icon: const Icon(Icons.calendar_today, color: blue),
                            ),
                            Text(
                              _selectedDate.isSameDay(_today)
                                  ? 'Hari ini'
                                  : '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: StyleConstant.bodyStyle.copyWith(color: blue),
                            ),
                          ],
                        ),
                        Flexible(
                          child: NumpadWidget(
                            onNumberPressed: (value) {
                              _nominalController.text += value;
                            },
                            onDeletePressed: () {
                              if (_nominalController.text.isNotEmpty) {
                                _nominalController.text = _nominalController.text.substring(
                                  0,
                                  _nominalController.text.length - 1,
                                );
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: blue,
                            size: 32,
                          ),
                          onPressed: () {
                            BlocProvider.of<TransactionCubit>(context).createTransaction(
                              TransactionModel(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                type: _transactionType,
                                categoryId: _selectedCategory!.id,
                                dompetId: _selectedDompet!.id,
                                amount: double.parse(_nominalController.text),
                                date: _selectedDate,
                                name: _nameController.text,
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _categoryListTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          switch (state) {
            case CategoryInitial _:
              BlocProvider.of<CategoryCubit>(context).getCategoryList();
              return const Center(
                child: CircularProgressIndicator(),
              );
            case CategoryLoaded _:
              final categoryList = state.categoryList;
              return Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.center,
                children: List.generate(
                  categoryList.length + 1,
                  (index) {
                    if (index == categoryList.length) {
                      return CardButton(
                        icon: 'assets/icons/add.png',
                        iconSize: 32,
                        title: '',
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return const AddCategoryModal();
                            },
                          );
                        },
                      );
                    } else {
                      return CardButton(
                        icon: categoryList[index].iconPath,
                        title: categoryList[index].name,
                        onTap: () {
                          setState(() {
                            _selectedCategory = categoryList[index];
                          });
                        },
                      );
                    }
                  },
                ),
              );
          }
        },
      ),
    );
  }

  SingleChildScrollView _dompetListTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<DompetCubit, DompetState>(
        builder: (context, state) {
          switch (state) {
            case DompetInitial _:
              BlocProvider.of<DompetCubit>(context).getDompetList();
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DompetLoaded _:
              final dompetList = state.dompetList;
              return Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.center,
                children: List.generate(
                  dompetList.length,
                  (index) {
                    return CardButton(
                      icon: dompetList[index].iconPath,
                      title: dompetList[index].name,
                      onTap: () {
                        setState(() {
                          _selectedDompet = dompetList[index];
                        });
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
