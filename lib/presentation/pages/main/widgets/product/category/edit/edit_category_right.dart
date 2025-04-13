import 'package:admin_desktop/application/edit_category/edit_category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../../../../../application/edit_category/edit_category_state.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../components/custom_toggle.dart';
import '../../../../../../components/image/white_single_image_picker.dart';

class EditCategoryRight extends StatelessWidget {
  final EditCategoryNotifier notifier;
  final EditCategoryState state;

  const EditCategoryRight(
      {super.key, required this.notifier, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(left: 18, bottom: 18, right: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WhiteSingleImagePicker(
            width: MediaQuery.sizeOf(context).width / 3,
            height: 220.r,
            isAdding: state.category?.img == null,
            imageFilePath: state.imageFile,
            imageUrl: state.category?.img,
            onImageChange: notifier.setImageFile,
            onDelete: () => notifier.setImageFile(null),
          ),
          24.verticalSpace,
          Container(
            width: double.infinity,
            padding: REdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.active),
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                12.verticalSpace,
                CustomToggle(
                  controller: ValueNotifier(state.active),
                  onChange: notifier.changeActive,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
