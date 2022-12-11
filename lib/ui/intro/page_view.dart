import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nursing_home_dexter/data/entity/intro.dart';
import 'package:nursing_home_dexter/shared/app_constants/app_colors.dart';
import 'package:nursing_home_dexter/shared/utils/size_config.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    Key? key,
  }) : super(key: key);

  @override
  MyPageViewState createState() => MyPageViewState();
}

class MyPageViewState extends State<MyPageView> {
  PageController? _controller = PageController();
  List<Intro>? _pages;
  int pageIndex = 0;
  Timer? timer;
  bool isDisposing = false;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      itemBuilder: (BuildContext context, int index) {
        return createItem(context, _pages![index % _pages!.length]);
      },
      onPageChanged: (int p) {
        setState(() {
          pageIndex = p;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    timer ??= Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (pageIndex < 2) {
        pageIndex++;
      } else {
        pageIndex = 0;
      }
      if (isDisposing) timer.cancel();
      _controller!.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void didChangeDependencies() {
    if (_pages == null) iniatePages();
    super.didChangeDependencies();
  }

  Widget createItem(BuildContext context, Intro item) {
    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight / 7,
              child: SvgPicture.asset(item.image!),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
              child: Text(
                item.description!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            if (_controller != null && _controller!.positions.isNotEmpty)
              DotsIndicator(
                decorator: DotsDecorator(
                    activeColor: AppColors.mainAppColor,
                  color: AppColors.grey
                ),
                position: pageIndex.toDouble(),

                // color: AppColors.mTextColor,
                // controller: _controller!,
                // onPageSelected: (int page) {
                //   _controller!.animateToPage(
                //     page,
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.ease,
                //   );
                // },
                dotsCount: _pages == null ? 3 : _pages!.length,
              ),
          ],
        )
      ],
    );
  }

  void iniatePages() {
    _pages = [
      Intro(
        image: "assets/images/dexter_logo.svg",
        description: "The language assistant for care.",
      ),
      Intro(
        image: "assets/images/dexter_logo.svg",
        description: "Increase caregiver, patient and senior satisfaction with voice-enabled documentation and communication.",
      ),
      Intro(
        image: "assets/images/dexter_logo.svg",
        description: "Save double walking distances by knowing in advance what your patients need.",
      ),
    ];
  }

  @override
  void dispose() {
    isDisposing = true;
    _controller!.dispose();
    timer!.cancel();
    timer = null;
    _controller = null;
    super.dispose();
  }
}
