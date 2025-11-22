import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:podcast_demo/views/shared/app_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final bool showBack;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,

    this.showBack = true,
    this.actions,
    this.leading,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyActions: true,
      backgroundColor: backgroundColor,
      elevation: 0,

      title: AppIcon(),

      actions: [
        Row(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 13.w),
              margin: EdgeInsets.only(right: 23.w),

              decoration: BoxDecoration(
                borderRadius: .circular(18),
                color: Color.fromRGBO(62, 62, 62, 0.5),
              ),
              child: Row(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Image.asset("assets/images/avatar.png"),
                  SizedBox(width: 13.w),

                  Icon(Icons.notifications, color: Colors.white),
                  SizedBox(width: 13.w),
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.h);
}
