import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/repositories/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryCubit(this._categoryRepository) : super(CategoryInitial());

  void getCategoryList() async {
    final categoryList = await _categoryRepository.getCategoryList();
    emit(CategoryLoaded(categoryList));
  }

  void createCategory(Category category) async {
    await _categoryRepository.createCategory(category);
    getCategoryList();
  }

  void resetState() {
    emit(CategoryInitial());
  }
}
