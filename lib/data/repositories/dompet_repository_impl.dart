import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretest/data/models/dompet_model.dart';
import 'package:pretest/domain/entities/dompet.dart';
import 'package:pretest/domain/repositories/dompet_repository.dart';

class DompetRepositoryImpl implements DompetRepository {
  @override
  Future<DompetModel> createDompet(Dompet dompet) {
    final document = FirebaseFirestore.instance.collection('dompet').doc();
    final dompetModel = DompetModel(
      id: document.id,
      iconPath: dompet.iconPath,
      name: dompet.name,
      saldo: dompet.saldo,
      userId: dompet.userId,
    );
    document.set(dompetModel.toJson());
    return Future.value(dompetModel);
  }

  @override
  Future<void> deleteDompet(String id) {
    return FirebaseFirestore.instance.collection('dompet').doc(id).delete();
  }

  @override
  Future<DompetModel> getDompet(String id) {
    return FirebaseFirestore.instance.collection('dompet').doc(id).get().then(
          (value) => DompetModel.fromJson(value.data()!),
        );
  }

  @override
  Future<List<DompetModel>> getDompetList() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('dompet')
        .where('userId', isEqualTo: user?.uid)
        .get()
        .then(
          (value) => value.docs.map((e) => DompetModel.fromJson(e.data())).toList(growable: false),
        );
  }

  @override
  Future<DompetModel> updateDompet(Dompet dompet) {
    // TODO: implement updateDompet
    throw UnimplementedError();
  }
}
