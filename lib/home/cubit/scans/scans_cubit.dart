import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:quicklab/home/models/products_data.dart';

part 'scans_state.dart';

class ScansCubit extends Cubit<ScansState> {
  ScansCubit() : super(ScansInitial());
  List<ProductsData> scansList = [];

  void getScans() async {
    emit(ScansLoadingState());
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore.collection('scans').get();
      scansList = querySnapshot.docs.map((doc) {
        return ProductsData.fromJson(doc.data() as Map<String, dynamic>,doc.id, false);
      }).toList();
      emit(ScansSuccessState());
    } catch (e) {
      emit(ScansErrorState(e.toString()));
    }
  }
}
