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
                              BlocBuilder<TransactionCubit, TransactionState>(
                                builder: (context, state) {
                                  BlocProvider.of<DompetCubit>(context).getDompetList();
                                  return BlocBuilder<DompetCubit, DompetState>(
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
                                  );
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
              child: Column(
                children: [
                  const RoundedDivider(
                    width: 48,
                    height: 4,
                    color: Colors.grey,
                    borderRadius: 24,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Visibility(
                                visible: _isCalendarSelected,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TableCalendar(
                                    rowHeight: 36,
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
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<TransactionCubit, TransactionState>(
                          builder: (context, state) {
                            if (state is TransactionLoaded) {
                              final transactionList = state.transactionList.where((transaction) {
                                return transaction.date.isSameDay(_selectedDay) ||
                                    !_isCalendarSelected;
                              }).toList();
                              if (transactionList.isEmpty) {
                                return SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    child: const Text('Tidak ada transaksi'),
                                  ),
                                );
                              }
                              return BlocBuilder<CategoryCubit, CategoryState>(
                                builder: (context, state) {
                                  if (state is CategoryLoaded) {
                                    final categoryList = state.categoryList;
                                    List<bool> isShowDate = [];
                                    transactionList.forEach((element) {
                                      if (isShowDate.isEmpty) {
                                        isShowDate.add(true);
                                      } else {
                                        isShowDate.add(
                                          !element.date.isSameDay(
                                              transactionList[isShowDate.length - 1].date),
                                        );
                                      }
                                    });
                                    final _today = DateTime.now();
                                    return SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          final category = categoryList.firstWhere(
                                            (category) =>
                                                category.id == transactionList[index].categoryId,
                                          );
                                          if (!isShowDate[index]) {
                                            return TransactionCard(
                                              category: category,
                                              transaction: transactionList[index],
                                            );
                                          } else {
                                            return Column(
                                              children: [
                                                const Gap(16),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    transactionList[index].date.isSameDay(_today)
                                                        ? 'Hari ini'
                                                        : transactionList[index]
                                                            .date
                                                            .toFormattedString(),
                                                    style: StyleConstant.bodyPoppinsStyle.copyWith(
                                                      color: blue,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                const Gap(4),
                                                TransactionCard(
                                                  category: category,
                                                  transaction: transactionList[index],
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                        childCount: transactionList.length,
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<CategoryCubit>(context).getCategoryList();
                                    return const SliverToBoxAdapter(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            } else {
                              BlocProvider.of<TransactionCubit>(context).getTransactionList();
                              return const SliverToBoxAdapter(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
