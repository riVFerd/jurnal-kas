import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserInitial()) {
    _userRepository.authCheck().then((user) {
      if (user != null) emit(UserAuthenticated(user));
    });
  }

  void createUserWithEmailAndPassword(String email, String password) async {
    if (state is UserAuthenticated) return emit(const UserError('User already login'));
    try {
      final user = await _userRepository.createUserWithEmailAndPassword(email, password);
      emit(UserAuthenticated(user));
    } on Exception catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void signInWithEmailAndPassword(String email, String password) async {
    if (state is UserAuthenticated) return emit(const UserError('User already login'));
    try {
      final user = await _userRepository.signInWithEmailAndPassword(email, password);
      emit(UserAuthenticated(user));
    } on Exception catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void signOut() async {
    await _userRepository.signOut();
    emit(UserInitial());
  }
}
