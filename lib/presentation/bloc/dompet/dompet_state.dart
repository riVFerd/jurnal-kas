part of 'dompet_cubit.dart';

sealed class DompetState extends Equatable {
  const DompetState();
}

class DompetInitial extends DompetState {
  @override
  List<Object> get props => [];
}

class DompetLoaded extends DompetState {
  final List<Dompet> dompetList;

  const DompetLoaded(this.dompetList);

  @override
  List<Object> get props => [dompetList];
}
