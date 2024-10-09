import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/banner/banner_cubit.dart';

class Banners extends StatelessWidget {
   const Banners({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 130.h,width: double.infinity,
      child: BlocProvider(
        create: (context) => BannerCubit()..getBanners(),
        child: BlocConsumer<BannerCubit, BannerState>(
          listener: (context, state) {
            if (state is BannerErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is BannerLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is BannerSuccessState){
              final banners = context.read<BannerCubit>().bannerList;
              return CarouselSlider(
                items: banners.map((bannerItem) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.network(
                      bannerItem ,
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                            child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 125.h,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 850),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              );
            }
            return const SizedBox.shrink();

          },
        ),
      ),
    );
  }
}
