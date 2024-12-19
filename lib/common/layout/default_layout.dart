import 'package:flutter/material.dart';

import '../const/app_colors.dart';

// 전체 view에 특정 기능을 적용하고 싶을때 사용
class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget child;

  const DefaultLayout({
    required this.child,
    this.title,
    this.backgroundColor,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      // 키보드 올라올 때 화면 조정
      resizeToAvoidBottomInset: true,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: AppColors.PRIMARY_GREEN,
        // elevation: 0, // 앞으로 튀어나와보이는 효과
        /// TODO : 왼쪽으로 배치 , 폰트 변경
        title: Text(
          title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.TextTertiary,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
      );
    }
  }
}
