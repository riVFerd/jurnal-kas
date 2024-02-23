import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/dompet.dart';
import '../../../domain/repositories/dompet_repository.dart';

part 'dompet_state.dart';

class DompetCubit extends Cubit<DompetState> {
  final DompetRepository _dompetRepository;
  DompetCubit(this._dompetRepository) : super(DompetInitial());

  Future<void> getDompetList() async {
    final dompetList = await _dompetRepository.getDompetList();
    emit(DompetLoaded(dompetList));
  }

  Future<void> createDompet(Dompet dompet) async {
    await _dompetRepository.createDompet(dompet);
    getDompetList();
  }

  void resetState() {
    emit(DompetInitial());
  }
}
