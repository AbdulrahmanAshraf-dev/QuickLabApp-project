import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:quicklab/home/models/products_data.dart';

part 'tests_state.dart';

class TestsCubit extends Cubit<TestsState> {
  TestsCubit() : super(TestsInitial());
  List<ProductsData> testsList = [];

  void getTests() async {
    emit(TestsLoadingState());
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore.collection('tests').get();
      testsList = querySnapshot.docs.map((doc) {
        return ProductsData.fromJson(doc.data() as Map<String, dynamic>,doc.id, true);
      }).toList();
      emit(TestsSuccessState());
    } catch (e) {
      emit(TestsErrorState(e.toString()));
    }
  }
}
