import 'package:admin_desktop/presentation/components/header_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class AddDeliverymanPage extends ConsumerStatefulWidget {
  const AddDeliverymanPage({super.key});

  @override
  ConsumerState<AddDeliverymanPage> createState() => _AddDeliverymanPageState();
}

class _AddDeliverymanPageState extends ConsumerState<AddDeliverymanPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerProvider);
    final notifier = ref.read(customerProvider.notifier);

    return KeyboardDisable(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderItem(title: TrKeys.addDeliveryman),
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                child: Consumer(
                  builder: (context, ref, child) {
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleImagePicker(
                                  height: MediaQuery.sizeOf(context).width / 3,
                                  width: MediaQuery.sizeOf(context).width / 3,
                                  imageFilePath: state.imageFile,
                                  onImageChange: notifier.setImageFile,
                                  onDelete: () => notifier.setImageFile(null),
                                ),
                              ),
                              30.horizontalSpace,
                              Expanded(
                                child: Column(
                                  children: [
                                    OutlinedBorderTextField(
                                      label:
                                          '${AppHelpers.getTranslation(TrKeys.firstname)}*',
                                      inputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.next,
                                      textController: firstName,
                                      validator: AppValidators.emptyCheck,
                                    ),
                                    16.verticalSpace,
                                    OutlinedBorderTextField(
                                      label: AppHelpers.getTranslation(
                                          TrKeys.lastname),
                                      inputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputAction: TextInputAction.next,
                                      textController: lastName,
                                    ),
                                    16.verticalSpace,
                                    OutlinedBorderTextField(
                                      label:
                                          '${AppHelpers.getTranslation(TrKeys.phone)}*',
                                      inputType: TextInputType.phone,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      textInputAction: TextInputAction.next,
                                      textController: phone,
                                      validator:
                                          AppValidators.isNumberValidator,
                                    ),
                                    16.verticalSpace,
                                    OutlinedBorderTextField(
                                      label:
                                          '${AppHelpers.getTranslation(TrKeys.email)}*',
                                      inputType: TextInputType.emailAddress,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      textInputAction: TextInputAction.next,
                                      textController: email,
                                      validator: AppValidators.emailCheck,
                                    ),
                                    16.verticalSpace,
                                    OutlinedBorderTextField(
                                      label:
                                          '${AppHelpers.getTranslation(TrKeys.password)}*',
                                      textCapitalization:
                                          TextCapitalization.none,
                                      textInputAction: TextInputAction.done,
                                      textController: password,
                                      validator: AppValidators.emptyCheck,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: REdgeInsets.symmetric(horizontal: 16),
                                child: CustomButton(
                                  title: AppHelpers.getTranslation(TrKeys.save),
                                  isLoading: state.isLoading,
                                  onTap: () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      notifier.createCustomer(
                                        context,
                                        createRole: TrKeys.deliveryman,
                                        name: firstName.text,
                                        lastName: lastName.text,
                                        email: email.text,
                                        phone: phone.text,
                                        created: (user) {
                                          context.maybePop();
                                          ref
                                              .read(
                                                  deliverymanProvider.notifier)
                                              .addCreatedUser(user);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
