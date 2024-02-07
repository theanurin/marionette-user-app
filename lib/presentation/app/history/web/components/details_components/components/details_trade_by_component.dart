import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/presentation/app/history/web/components/details_components/components/detail_item_component.dart';
import 'package:user_app/presentation/components/user_app_image.dart';
import 'package:user_app/presentation/constants/colors.dart';
import 'package:user_app/presentation/helpers/theme.dart';

class DetailTradeByComponent extends StatelessWidget {
  const DetailTradeByComponent({
    super.key,
    required this.iconUrlFrom,
    required this.iconUrlTo,
    required this.currency,
    required this.date,
    required this.type,
    required this.rate,
    required this.amount,
    required this.total,
    required this.side,
    required this.showPriceTotal,
  });

  final String iconUrlFrom;
  final String iconUrlTo;
  final String currency;
  final String date;
  final String type;
  final String rate;
  final String amount;
  final String total;
  final String side;
  final bool showPriceTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            isLightTheme(context)
                ? AppColors.whiteColor
                : AppColors.whiteColor.withOpacity(0.1),
            isLightTheme(context)
                ? AppColors.whiteColor
                : AppColors.whiteColor.withOpacity(0),
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          isLightTheme(context)
              ? BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                )
              : BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 25.h,
          left: 25.w,
          right: 25.w,
        ),
        child: Column(
          children: [
            Text(
              tr('history.details'),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 30.sp,
                  ),
            ),
            Container(
              height: 80.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.25),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    tr('history.market_pair'),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 20.sp,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                  ),
                  const Spacer(),
                  UserAppImage(
                    clipBehavior: Clip.hardEdge,
                    path: iconUrlFrom,
                    width: 35.w,
                    height: 35.h,
                    isNetwork: true,
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Text(
                    currency,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 20.sp,
                        ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  UserAppImage(
                    clipBehavior: Clip.hardEdge,
                    path: iconUrlTo,
                    width: 35.w,
                    height: 35.h,
                    isNetwork: true,
                  ),
                ],
              ),
            ),
            DetailItemComponent(
              isBorder: true,
              name: tr('history.date'),
              value: date,
              valueColor: Theme.of(context).primaryColor,
            ),
            DetailItemComponent(
              isBorder: true,
              name: tr('history.type'),
              value: type,
              valueColor: Theme.of(context).primaryColor,
            ),
            DetailItemComponent(
                isBorder: true,
                name: tr('history.side'),
                value: side,
                valueColor: side == 'Buy'
                    ? MainColorsApp.greenColor
                    : Theme.of(context).colorScheme.error),
            showPriceTotal
                ? DetailItemComponent(
                    isBorder: true,
                    name: tr('history.price'),
                    value: rate,
                    valueColor: Theme.of(context).primaryColor,
                  )
                : const SizedBox(),
            DetailItemComponent(
              isBorder: true,
              name: tr('history.amount'),
              value: amount,
              valueColor: Theme.of(context).primaryColor,
            ),
            showPriceTotal
                ? DetailItemComponent(
                    isBorder: false,
                    name: tr('history.total'),
                    value: total,
                    valueColor: Theme.of(context).primaryColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}