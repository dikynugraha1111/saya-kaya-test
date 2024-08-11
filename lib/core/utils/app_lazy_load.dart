import 'package:flutter/material.dart';

class AppLazyLoad {
  late ScrollController controller;

  void onListener({required Function onLoadMore, Function? addListener}) {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        onLoadMore();
      }
      if (addListener != null) {
        addListener();
      }
    });
  }
}

class AppLoadMoreWidget extends StatelessWidget {
  final bool status;
  final Duration? duration;
  const AppLoadMoreWidget({Key? key, required this.status, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: status
          ? Container(
              key: UniqueKey(),
              height: 50,
              child: Center(
                child: SizedBox(
                  key: UniqueKey(),
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    key: UniqueKey(),
                    strokeWidth: 3,
                  ),
                ),
              ),
            )
          : Container(height: 0.0),
    );
  }
}
