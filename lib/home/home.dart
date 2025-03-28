import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_ui_transition/const.dart';
import 'package:food_ui_transition/home/components/food.dart';
import 'package:food_ui_transition/home/components/rotate_food.dart';
import 'package:food_ui_transition/home/providers/transition_provider.dart';
import 'package:food_ui_transition/home/utils/utils.dart';
import 'package:food_ui_transition/services/precache_service.dart';
import 'package:unicons/unicons.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    PreCacheImages.preCacheImages(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: _floatingButton(context),
      body: Stack(
        children: [
          _pageViewBuilder(),
          _foodPart(),
          _rotateAnimation(height, width),
        ],
      ),
     
    );
  }































  Positioned _rotateAnimation(double height, double width) {
    return Positioned(
      top: height / 2 - (width * 0.88) / 2,
      left: width / 2 - 20,
      child: RotateFood(
        currentIndex: currentIndex,
        width: width,
        pageController: _pageController,
      ),
    );
  }

  Food _foodPart() {
    return Food(
        foodDetail: foodList[currentIndex], pageController: _pageController);
  }

  PageView _pageViewBuilder() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (value) {
        setState(() {
          currentIndex = value;
        });
        ref.read(textAnimationIndex.notifier).state = null;
      },
      itemBuilder: (context, index) {
        return Container(
          color: foodList[index].colorScheme!.surface,
        );
      },
      itemCount: foodList.length,
    );
  }

  Transform _floatingButton(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateZ(pi / 4),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: const Color(0xff45C37B).withOpacity(0.5),
            offset: const Offset(2, 5),
            blurRadius: 15,
          )
        ]),
        child: FloatingActionButton(
          mini: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 244, 207, 74),
          onPressed: () => navigateToDetail(foodList[currentIndex], context),
          child: Transform(
            transform: Matrix4.identity()..rotateZ(-pi / 4),
            alignment: Alignment.center,
            child: const Icon(
              UniconsLine.arrow_right,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
