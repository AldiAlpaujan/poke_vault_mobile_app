import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresh extends StatefulWidget {
  final bool noDataToLoad;
  final Future Function() onRefresh;
  final Future Function()? onLoading;
  final Widget child;
  const AppRefresh({
    super.key,
    required this.onRefresh,
    this.onLoading,
    this.noDataToLoad = true,
    required this.child,
  });

  @override
  State<AppRefresh> createState() => _AppRefreshState();
}

class _AppRefreshState extends State<AppRefresh> {
  final controller = RefreshController(initialRefresh: false);

  bool get noDataToLoad {
    if (widget.onLoading == null) return true;
    return widget.noDataToLoad;
  }

  Future<void> onRefresh() async {
    await widget.onRefresh();
    controller.refreshCompleted();
  }

  Future<void> onLoad() async {
    if (!noDataToLoad) {
      await widget.onLoading!();
      controller.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoad,
      footer: _footer(),
      child: widget.child,
    );
  }

  Widget _footer() {
    return CustomFooter(
      height: noDataToLoad ? 0 : 60.0,
      builder: (context, mode) {
        List<Widget> body;
        if (mode == LoadStatus.idle) {
          body = [
            const Icon(CupertinoIcons.arrow_up, size: 18),
            const SizedBox(width: 8),
            const Text("Tarik untuk memuat data"),
          ];
        } else if (mode == LoadStatus.loading) {
          body = [
            const CupertinoActivityIndicator(),
            const SizedBox(width: 8),
            const Text("Loading..."),
          ];
        } else if (mode == LoadStatus.canLoading) {
          body = [
            const Icon(CupertinoIcons.arrow_up, size: 18),
            const SizedBox(width: 8),
            const Text("Lepas untuk memuat data"),
          ];
        } else {
          body = [];
        }
        return Visibility(
          visible: !noDataToLoad,
          child: SizedBox(
            height: 55.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: body,
              ),
            ),
          ),
        );
      },
    );
  }
}
