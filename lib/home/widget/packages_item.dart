import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure to import flutter_bloc
import 'package:quicklab/bookmark/cubit/get_bookmark_cubit.dart';
import 'package:quicklab/home/models/products_data.dart';
import '../../detail/detail.dart';

class PackagesItem extends StatefulWidget {
  final ProductsData items;
  late bool inBookmark;

   PackagesItem(this.items, {super.key, required this.inBookmark});

  @override
  State<PackagesItem> createState() => _PackagesItemState();
}

class _PackagesItemState extends State<PackagesItem> {
  late IconData icon;

  @override
  void initState() {
    super.initState();
    icon = widget.items.isBookmarked! ? Icons.favorite : Icons.favorite_border;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => DetailPage(items:widget.items)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(8.dm),
                  height: 170.h,
                  width: 200.w,
                  child: Image.network(
                    widget.items.image!,
                    height: 170.h,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 15,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.inBookmark = !widget.inBookmark;
                        widget.items.isBookmarked = widget.inBookmark;
                        if (icon == Icons.favorite_border) {
                          icon = Icons.favorite;
                          context.read<GetBookmarkCubit>().addBookmark(
                            widget.items.id!,
                            widget.items.isTest!,
                            widget.inBookmark,
                            context,
                          );
                        } else {
                          icon = Icons.favorite_border;
                          context.read<GetBookmarkCubit>().removeBookmark(
                            widget.items.id!,
                            widget.items.isTest!,
                            widget.inBookmark,
                            context,
                          );
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.dm),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: Colors.red,
                        size: 20.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.items.name!,
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.5.h),
            ),
            Text(
              '${widget.items.price} EGP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5.h,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
