part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<Category> categoryList;

  const CategoryLoaded(this.categoryList);

  @override
  List<Object> get props => [categoryList];
}
