import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationLoader extends StatelessWidget {
  final bool loading;

  const PaginationLoader({
    super.key,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: (loading)
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            : SizedBox.shrink());
  }
}
