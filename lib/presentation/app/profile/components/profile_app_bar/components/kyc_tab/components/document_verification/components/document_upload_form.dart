import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_app/application/kyc/documents_state_provider.dart';
import 'package:user_app/domain/platform/platform_type_state.dart';
import 'package:user_app/presentation/app/profile/actions/kyc/document_verification.dart';
import 'package:user_app/presentation/helpers/get_size_from_platform_type.dart';
import 'package:user_app/presentation/helpers/theme.dart';
import 'package:user_app/presentation/constants/colors.dart';

class DocumentUploadForm extends HookConsumerWidget {
  const DocumentUploadForm({
    super.key,
    required this.platformType,
  });

  final PlatformTypeState platformType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsState = ref.read(kycDocumentsStateNotifierProvider.notifier);
    final documents = ref.watch(kycDocumentsStateNotifierProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getSizeFromPlatformType(
              platformType: platformType,
              webValue: 31,
              tabletValue: 25,
              mobileValue: 15,
            ).h,
            bottom: getSizeFromPlatformType(
              platformType: platformType,
              webValue: 31,
              tabletValue: 25,
              mobileValue: 13,
            ).h,
          ),
          child: Text(
            tr('profile.upload_your_photo_ID'),
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 20.sp),
          ),
        ),
        DottedBorder(
          color: Theme.of(context).primaryColor.withOpacity(0.25),
          child: Padding(
            padding: documents.uploadedImages.isNotEmpty
                ? EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 5.h,
                  )
                : const EdgeInsets.all(0),
            child: SizedBox(
              width: double.infinity,
              height: getSizeFromPlatformType(
                platformType: platformType,
                webValue: 115,
                tabletValue: 87,
                mobileValue: 100,
              ).h,
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(
                        height: getSizeFromPlatformType(
                          platformType: platformType,
                          webValue: 115,
                          tabletValue: 87,
                          mobileValue: 100,
                        ).h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.uploadedImages.isEmpty
                              ? 0
                              : documents.uploadedImages.length,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  0,
                                  10.h,
                                  10.w,
                                  0,
                                ),
                                height: getSizeFromPlatformType(
                                  platformType: platformType,
                                  webValue: 95,
                                  tabletValue: 75,
                                  mobileValue: 80,
                                ).h,
                                width: getSizeFromPlatformType(
                                  platformType: platformType,
                                  webValue: 95,
                                  tabletValue: 75,
                                  mobileValue: 80,
                                ).w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: MemoryImage(
                                      documents.uploadedImages[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                    0,
                                    11.h,
                                    0,
                                    0,
                                  ),
                                  height: 15.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5.r),
                                      topLeft: Radius.circular(5.r),
                                    ),
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        final List<Uint8List> temp = [];
                                        temp.addAll(documents.uploadedImages);
                                        temp.removeAt(index);
                                        documentsState.updateImageList(temp);
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: isLightTheme(context)
                                            ? AppColors.whiteColor
                                            : Theme.of(context)
                                                .primaryColorLight,
                                        size: 12.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          DocumentVerificationAction().uploadDocumentFile(
                            ref: ref,
                          );
                        },
                        child: documents.uploadedImages.length != 5
                            ? SizedBox(
                                width: documents.uploadedImages.isEmpty
                                    ? double.infinity
                                    : getSizeFromPlatformType(
                                        platformType: platformType,
                                        webValue: 95,
                                        tabletValue: 75,
                                        mobileValue: 80,
                                      ).w,
                                height: documents.uploadedImages.isEmpty
                                    ? getSizeFromPlatformType(
                                        platformType: platformType,
                                        webValue: 95,
                                        tabletValue: 75,
                                        mobileValue: 80,
                                      ).h
                                    : getSizeFromPlatformType(
                                        platformType: platformType,
                                        webValue: 95,
                                        tabletValue: 75,
                                        mobileValue: 80,
                                      ).h,
                                child: DottedBorder(
                                  radius:  Radius.circular(1.r),
                                  strokeWidth: 1,
                                  color: documents.uploadedImages.isEmpty
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0)
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.25),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          documents.uploadedImages.isEmpty
                                              ? Icons.photo_camera
                                              : Icons.add,
                                          size: 52.h,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SizedBox(
              child: Text(
                tr('profile.max_file_size'),
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: getSizeFromPlatformType(
                        platformType: platformType,
                        webValue: 15,
                        tabletValue: 13,
                        mobileValue: 10,
                      ).sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
              ),
            ),
            SizedBox(
              width: 3.w,
            )
          ],
        ),
      ],
    );
  }
}
