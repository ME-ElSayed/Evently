import 'package:flutter/widgets.dart';

class NoBody extends StatelessWidget {
  final String content;
  const NoBody({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
