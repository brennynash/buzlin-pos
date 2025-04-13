import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../../components/components.dart';
import '../../../../../../../../components/image/stories_image_picker.dart';
import '../../../../../../../../styles/style.dart';
import '../widgets/products_modal.dart';

class EditStoriesPage extends ConsumerWidget {
  const EditStoriesPage(this.onSave, {super.key});

  final Function() onSave;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(editStoriesProvider);
    final notifier = ref.read(editStoriesProvider.notifier);
    return KeyboardDisable(
      child: Scaffold(
        body: Column(
          children: [
            const HeaderItem(title: TrKeys.editStory),
            state.story == null
                ? const Loading()
                : Padding(
                    padding: REdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            24.verticalSpace,
                            StoriesImagePicker(
                              listOfImages: state.images,
                              imageUrls: state.listOfUrls,
                              onImageChange: notifier.setImageFile,
                              onDelete: notifier.deleteImage,
                            ),
                            24.verticalSpace,
                            OutlinedBorderTextField(
                              readOnly: true,
                              textController: state.textEditingController,
                              label: AppHelpers.getTranslation(TrKeys.product),
                              onTap: () {
                                AppHelpers.showAlertDialog(
                                    context: context,
                                    child: SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                3,
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                3,
                                        child: const ProductsModal()));
                              },
                            ),
                            24.verticalSpace,
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            bgColor: Style.primary,
            textColor: Style.white,
            title: AppHelpers.getTranslation(TrKeys.save),
            isLoading: state.isLoading,
            onTap: () {
              if (state.listOfUrls.isEmpty && state.images.isEmpty) {
                AppHelpers.errorSnackBar(context, text: TrKeys.imageCantEmpty);
                return;
              }
              notifier.updateStories(context, updated: () {
                ref
                    .read(storiesProvider.notifier)
                    .fetchStories(isRefresh: true);
                context.maybePop();
              });
            },
          ),
        ),
      ),
    );
  }
}
