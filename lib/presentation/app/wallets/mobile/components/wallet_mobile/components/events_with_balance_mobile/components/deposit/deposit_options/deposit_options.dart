import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_app/application/wallets/wallet_data_state_norifier_provider.dart';
import 'package:user_app/domain/wallet/wallet_payment_interface.dart';
import 'package:user_app/presentation/app/wallets/mobile/components/wallet_mobile/components/events_with_balance_mobile/components/deposit/deposit_options/components/fiat_deposit_options.dart';
import 'package:user_app/presentation/app/wallets/mobile/components/wallet_mobile/components/events_with_balance_mobile/components/deposit/deposit_options/components/generated_address_options.dart';
import 'package:user_app/presentation/components/buttons_mobile.dart';
import 'package:user_app/presentation/constants/colors.dart';
import 'package:user_app/presentation/helpers/theme.dart';
import 'package:user_app/presentation/helpers/wallet_color_helper.dart';

class DepositOptionsMobile extends StatefulHookConsumerWidget {
  const DepositOptionsMobile({
    required this.listWalletDepositPI,
    super.key,
  });

  final List<WalletPaymentInterface> listWalletDepositPI;

  @override
  ConsumerState<DepositOptionsMobile> createState() =>
      _DepositOptionsMobileState();
}

class _DepositOptionsMobileState extends ConsumerState<DepositOptionsMobile> {
  @override
  Widget build(BuildContext context) {
    final walletData = ref.watch(walletDataStateNotifierProvider);

    WalletPaymentInterface fiatDepositWallet =
        widget.listWalletDepositPI.firstWhere(
      (element) => element.type == 'fiat',
      orElse: () => WalletPaymentInterface.initialData(),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: getWalletColor(
          walletData.lightBgColor1,
          walletData.darkBgColor1,
          isLightTheme(context),
        ),
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50..h),
          child: Padding(
            padding: EdgeInsets.only(
              top: 15..h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
                  child: BackButtonMobile(
                    onTap: () => context.pop(),
                  ),
                ),
                Text(
                  'Receive ${walletData.id.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 15.sp,
                        letterSpacing: -0.75.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 70.w,
                  height: 25..h,
                )
              ],
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 10..h,
          ),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? AppColors.whiteColor
                : walletBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20..h, left: 15.w, right: 15.w),
            child: fiatDepositWallet.type == 'fiat'
                ? FiatDepositOptionsMobile(fiatDepositWallet: fiatDepositWallet)
                : GeneratedAddressOptionsMobile(
                    listWalletDepositPI: widget.listWalletDepositPI,
                  ),
          ),
        ),
      ),
    );
  }
}
