import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/common/datetime_extentions.dart';
import 'package:pretest/common/format_decimal.dart';
import 'package:pretest/presentation/constants/style_constant.dart';
import 'package:pretest/presentation/widgets/rounded_divider.dart';
import 'package:pretest/presentation/widgets/selectable_tab.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../bloc/category/category_cubit.dart';
import '../../bloc/dompet/dompet_cubit.dart';
import '../../bloc/transaction/transaction_cubit.dart';
import '../../constants/color_constant.dart';
import '../../widgets/transaction_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCalendarSelected = true;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SelectableTab(
                                  isSelected: _isCalendarSelected,
                                  label: 'Kalender',
                                  iconPath: 'assets/icons/calendar.png',
                                  selectedBackgroundColor: Colors.white,
                                  textColor: Colors.white,
                                  selectedTextColor: blue,
                                  borderRadius: 12,
                                  selectedSize: 120,
                                  iconScale: 1,
                                  onTap: () => setState(() => _isCalendarSelected = true),
                                ),
                                SelectableTab(
                                  isSelected: !_isCalendarSelected,
                                  label: 'Detail',
                                  iconPath: 'assets/icons/detail-book.png',
                                  selectedBackgroundColor: Colors.white,
                                  textColor: Colors.white,
                                  selectedTextColor: blue,
                                  borderRadius: 12,
                                  selectedSize: 120,
                                  iconScale: 1,
                                  onTap: () => setState(() => _isCalendarSelected = false),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.settings_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const MaxGap(32),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Uang',
                                style: StyleConstant.titleStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              BlocBuilder<DompetCubit, DompetState>(
                                builder: (context, state) {
                                  if (state is DompetLoaded) {
                                    final total = state.dompetList.fold(
                                      0.0,
                                      (prev, element) => prev + element.saldo,
                                    );
                                    return Text(
                                      'Rp ${FormatDecimal.format(total)}',
                                      style: StyleConstant.titleStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<DompetCubit>(context).getDompetList();
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -32,
                    right: 24,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/people.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const RoundedDivider(
                      width: 48,
                      height: 4,
                      color: Colors.grey,
                      borderRadius: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TableCalendar(
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _selectedDay.toFormattedString(),
                        style: StyleConstant.bodyBoldStyle.copyWith(
                          color: blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: BlocBuilder<TransactionCubit, TransactionState>(
                        builder: (context, state) {
                          if (state is TransactionLoaded) {
                            final transactionList = state.transactionList.where((transaction) {
                              return transaction.date.isSameDay(_selectedDay);
                            }).toList();
                            print(transactionList);
                            print(transactionList.length);
                            if (transactionList.isEmpty) {
                              return const Center(
                                child: Text('Tidak ada transaksi'),
                              );
                            }
                            return BlocBuilder<CategoryCubit, CategoryState>(
                              builder: (context, state) {
                                if (state is CategoryLoaded) {
                                  final categoryList = state.categoryList;
                                  return ListView.builder(
                                    itemCount: transactionList.length,
                                    itemBuilder: (context, index) {
                                      final category = categoryList.firstWhere(
                                        (category) =>
                                            category.id == transactionList[index].categoryId,
                                      );
                                      return TransactionCard(
                                        category: category,
                                        transaction: transactionList[index],
                                      );
                                    },
                                  );
                                } else {
                                  BlocProvider.of<CategoryCubit>(context).getCategoryList();
                                  return const CircularProgressIndicator();
                                }
                              },
                            );
                          } else {
                            BlocProvider.of<TransactionCubit>(context).getTransactionList();
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
