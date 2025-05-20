import 'package:flutter/material.dart';
import 'package:usersphere/core/app_colors.dart';
import '../../../../core/text_styles.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 80, color: AppColors.textHint),
          const SizedBox(height: 32),
          Text(
            'No Internet Connection',
            style: CustomTextStyle.of(context).headingSmallTextStyle(),
          ),
          const SizedBox(height: 6),
          Text(
            'Please make sure you are connected to an active network and try again',
            textAlign: TextAlign.center,
            style: CustomTextStyle.of(context).bodyMediumStyle(),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textHint,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Retry',
                style: CustomTextStyle.of(context).titleMediumStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
