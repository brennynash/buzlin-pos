import 'package:admin_desktop/application/customer/customer_notifier.dart';
import 'package:admin_desktop/application/customer/customer_state.dart';
import 'package:admin_desktop/application/masters/new_masters/new_masters_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class AddMasterPage extends StatefulWidget {
  final CustomerState state;
  final CustomerNotifier notifier;
  final NewMastersNotifier newMastersNotifier;

  const AddMasterPage(
      {super.key,
      required this.state,
      required this.notifier,
      required this.newMastersNotifier});

  @override
  State<AddMasterPage> createState() => _AddMasterPageState();
}

class _AddMasterPageState extends State<AddMasterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController title;
  late TextEditingController description;

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
    return KeyboardDisable(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () {},
                ),
                Text(AppHelpers.getTranslation(TrKeys.addMaster)),
              ],
            ),
            // CommonAppBar(
            //     child: Row(
            //   children: [
            //     const PopButton(),
            //     Text(AppHelpers.getTranslation(TrKeys.addMaster)),
            //   ],
            // )),
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      16.verticalSpace,
                      SingleImagePicker(
                        height: MediaQuery.sizeOf(context).width / 3,
                        width: MediaQuery.sizeOf(context).width / 3,
                        imageFilePath: widget.state.imageFile,
                        onImageChange: widget.notifier.setImageFile,
                        onDelete: () => widget.notifier.setImageFile(null),
                      ),
                      16.verticalSpace,
                      OutlinedBorderTextField(
                        label:
                            '${AppHelpers.getTranslation(TrKeys.firstname)}*',
                        inputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        textController: firstName,
                        validator: AppValidators.emptyCheck,
                      ),
                      16.verticalSpace,
                      OutlinedBorderTextField(
                        label: AppHelpers.getTranslation(TrKeys.lastname),
                        inputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        textController: lastName,
                      ),
                      16.verticalSpace,
                      OutlinedBorderTextField(
                        label: '${AppHelpers.getTranslation(TrKeys.title)}*',
                        inputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        textController: title,
                        validator: AppValidators.emptyCheck,
                      ),
                      16.verticalSpace,
                      OutlinedBorderTextField(
                        label: AppHelpers.getTranslation(TrKeys.description),
                        inputType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        textController: description,
                      ),
                      16.verticalSpace,
                      OutlinedBorderTextField(
                        label: '${AppHelpers.getTranslation(TrKeys.phone)}*',
                        inputType: TextInputType.phone,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        textController: phone,
                        validator: AppValidators.isNumberValidator,
                      ),
                      16.verticalSpace,
                      OutlinedBorderTextField(
                        label: '${AppHelpers.getTranslation(TrKeys.email)}*',
                        inputType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        textController: email,
                        validator: AppValidators.emailCheck,
                      ),
                      24.verticalSpace,
                      OutlinedBorderTextField(
                        label: '${AppHelpers.getTranslation(TrKeys.password)}*',
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.done,
                        textController: password,
                        validator: AppValidators.emptyCheck,
                      ),
                      100.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            title: AppHelpers.getTranslation(TrKeys.save),
            isLoading: widget.state.isLoading,
            onTap: () {
              if (formKey.currentState?.validate() ?? false) {
                widget.notifier.createCustomer(
                  context,
                  created: (user) {
                    widget.newMastersNotifier.addCreatedUser(user);
                  },
                  name: firstName.text,
                  lastName: lastName.text,
                  email: email.text,
                  phone: phone.text,
                  description: description.text,
                  title: title.text,
                  createRole: TrKeys.master,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
