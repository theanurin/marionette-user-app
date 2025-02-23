import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_app/application/trade/error_mesegge_provider.dart';
import 'package:user_app/application/trade/market_or_limit_provider.dart';
import 'package:user_app/application/trade/market_percet_provider.dart';
import 'package:user_app/application/trade/selet_market_future_provider.dart';
import 'package:user_app/application/trade/tranding_tab_provider.dart';
import 'package:user_app/domain/platform/platform_type_state.dart';
import 'package:user_app/domain/trade/order_type.dart';
import 'package:user_app/domain/trade/orderbook/orderbook_item.dart';
import 'package:user_app/presentation/app/trade/mobile/trade_buy_sell_mobile_screen.dart';
import 'package:user_app/presentation/constants/colors.dart';
import 'package:user_app/presentation/helpers/formatters/number_format_with_precision.dart';

class OrderBookSellSideMobile extends HookConsumerWidget {
  const OrderBookSellSideMobile({
    Key? key,
    required this.orderBookWatch,
    required this.withTradingBalance,
  }) : super(key: key);

  final List<OrderBookItem> orderBookWatch;
  final bool withTradingBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketDataWatch = ref.watch(selectMarketsNotifierProvider);
    final marketOrLimitProviderState = ref.read(marketOrLimitProvider.notifier);
    final tradingTabState = ref.read(tradingTabProvider.notifier);
    final marketPercentState = ref.read(marketPercentProviderProvider.notifier);

    final priceController = TextEditingController();
    final amountController = TextEditingController();
    final totalController = TextEditingController();

    final errorMinOrMaxPriceRead =
        ref.read(errorMinOrMaxPriceProvider.notifier);
    final errorMinAmountRead = ref.read(errorMinAmountProvider.notifier);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 15.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    tr('trade.price'),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 13.sp,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                  ),
                ),
                Text(
                  tr('trade.cumulative_total'),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        letterSpacing: -0.65.sp,
                        fontSize: 13.sp,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orderBookWatch.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  marketOrLimitProviderState.state = OrderType.limit;
                  marketPercentState.state = 0;

                  errorMinOrMaxPriceRead.state = false;
                  errorMinAmountRead.state = false;

                  tradingTabState.state = 2;
                  priceController.text = orderBookWatch[index]
                      .price
                      .toStringAsFixed(
                          marketDataWatch.trading_price_precision);

                  amountController.text = marketDataWatch.trading_min_amount.toStringAsFixed(
                          marketDataWatch.trading_amount_precision);

                  totalController.text = (orderBookWatch[index].price *
                          marketDataWatch.trading_min_amount)
                      .toStringAsFixed(
                          marketDataWatch.quote_currency.precision);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TradeBuySellScreenMobile(
                        item: marketDataWatch,
                        tradingTabWatch: 2,
                        priceController: priceController,
                        amountController: amountController,
                        totalController: totalController,
                        withTradingBalance: withTradingBalance,
                        platformType: PlatformTypeState.mobile,
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: ((180 / orderBookWatch.last.cumulativeAmount) *
                                orderBookWatch[index].cumulativeAmount)
                            .w,
                        height: 24..h,
                        color: MainColorsApp.redColor.withOpacity(0.25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              numberFormatWithPrecision(
                                      marketDataWatch.trading_price_precision)
                                  .format(orderBookWatch[index].price),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    letterSpacing: -0.65.sp,
                                    fontSize: 13.sp,
                                    color: MainColorsApp.redColor,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              abbreviateNumber(
                                number: orderBookWatch[index].cumulativeAmount,
                                precision:
                                    marketDataWatch.trading_amount_precision,
                              ),
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    fontSize: 13.sp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
