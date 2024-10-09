import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());
  List bannerList = [];
  void getBanners() async{
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      emit(BannerLoadingState());
      QuerySnapshot querySnapshot = await firestore.collection('banners').get();
      final x = querySnapshot.docs[0].data() as Map<String, dynamic>;
       bannerList = x['links'];
      emit(BannerSuccessState());
    } catch (e) {
      emit(BannerErrorState(e.toString()));
    }
  }
}
