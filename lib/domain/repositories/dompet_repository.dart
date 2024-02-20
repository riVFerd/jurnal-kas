import '../entities/dompet.dart';

abstract class DompetRepository {
  Future<List<Dompet>> getDompetList();

  Future<Dompet> getDompet(String id);

  Future<Dompet> createDompet(Dompet dompet);

  Future<Dompet> updateDompet(Dompet dompet);

  Future<void> deleteDompet(String id);
}
