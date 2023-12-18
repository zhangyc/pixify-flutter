import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    this.title,
    this.content,
    this.onRefresh
  });
  final String? title;
  final String? content;
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/empty_yin_yang.png', width: 115),
          SizedBox(height: 32),
          Text(
              title ?? S.of(context).oopsNoDataRightNow,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500
              )
          ),
          Text(
            content ?? S.of(context).pleaseCheckYourInternetOrTapToRefreshAndTryAgain,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500
            )
          ),
          SizedBox(height: 12),
          if (onRefresh != null) FilledButton(onPressed: onRefresh, child: Text(S.of(context).buttonRefresh)),
          SizedBox(height: 32)
        ],
      )
    );
  }
}