import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/bookmark/cubit/get_bookmark_cubit.dart';
import 'package:quicklab/home/cubit/scans/scans_cubit.dart';
import 'package:quicklab/home/cubit/tests/tests_cubit.dart';
import 'package:quicklab/home/models/products_data.dart';

class DetailPage extends StatelessWidget {
  final ProductsData items;

  const DetailPage({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
              color: Colors.cyan, fontSize: 26.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.cyan,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      bottomNavigationBar: Row(
        children: [
          Container(
            height: 60.h,
            width: screenWidth / 1.2,
            decoration: const BoxDecoration(
              color: Colors.cyan,
            ),
            child: Center(
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          AddFavoriteInDetail(
              screenWidth: screenWidth, item: items),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              child: SizedBox(
                height: screenHeight / 2.5,
                width: screenWidth,
                child: Image.network(
                  items.image!,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Text(
                items.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 28.sp,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Text(
                items.description!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddFavoriteInDetail extends StatefulWidget {
  const AddFavoriteInDetail({
    super.key,
    required this.screenWidth,
    required this.item,
  });

  final double screenWidth;
  final ProductsData item;

  @override
  State<AddFavoriteInDetail> createState() => _AddFavoriteInDetail();
}

class _AddFavoriteInDetail extends State<AddFavoriteInDetail> {
  late IconData icon;

  @override
  void initState() {
    icon = widget.item.isBookmarked! ? Icons.favorite : Icons.favorite_border_rounded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<GetBookmarkCubit>().addBookmark(widget.item.id!, widget.item.isTest!, false, context);
        widget.item.isTest!?context.read<TestsCubit>().getTests():context.read<ScansCubit>().getScans();
        setState(() {
          icon = icon == Icons.favorite ? Icons.favorite_border_rounded : Icons.favorite;
        });
      },
        child: SizedBox(
            width: widget.screenWidth - (widget.screenWidth / 1.2),
            child: Icon(
              icon,
              size: 36.r,
              color: Colors.cyan,
            )));
  }
}
