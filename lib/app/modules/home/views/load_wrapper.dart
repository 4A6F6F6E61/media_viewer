import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class LoadWrapper extends StatelessWidget {
  LoadWrapper({Key? key, required this.child, required this.onRefresh}) : super(key: key);

  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final Widget child;
  final Future<void> Function() onRefresh;

  void _onRefresh() async {
    await onRefresh();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        header: const ClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: child,
      ),
    );
  }
}
