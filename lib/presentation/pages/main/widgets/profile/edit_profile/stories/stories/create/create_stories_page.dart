import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../../../../components/image/stories_image_picker.dart';
import '../widgets/products_modal.dart';

class CreateStoriesPage extends ConsumerStatefulWidget {
  const CreateStoriesPage({super.key});

  @override
  ConsumerState<CreateStoriesPage> createState() => _CreateStoriesPageState();
}

class _CreateStoriesPageState extends ConsumerState<CreateStoriesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editStoriesProvider.notifier).setStoryDetails(null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editStoriesProvider);
    final notifier = ref.read(editStoriesProvider.notifier);
    return KeyboardDisable(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderItem(title: TrKeys.stories),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    label: AppHelpers.getTranslation(TrKeys.product),
                    textController: state.textEditingController,
                    onTap: () {
                      AppHelpers.showAlertDialog(
                          context: context,
                          child: SizedBox(
                              height: MediaQuery.sizeOf(context).height / 1.5,
                              width: MediaQuery.sizeOf(context).width / 3,
                              child: const ProductsModal()));
                    },
                  ),
                  24.verticalSpace,
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                isLoading: state.isLoading,
                onTap: () {
                  if (state.listOfUrls.isEmpty && state.images.isEmpty) {
                    AppHelpers.errorSnackBar(context,
                        text: TrKeys.imageCantEmpty);
                    return;
                  }
                  notifier.createStories(
                    context,
                    created: () {
                      ref
                          .read(storiesProvider.notifier)
                          .fetchStories(context: context, isRefresh: true);
                      context.maybePop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
