import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class AddCustomerDialog extends ConsumerStatefulWidget {
  const AddCustomerDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCustomDialogState();
}

class _AddCustomDialogState extends ConsumerState<AddCustomerDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController newPassword;
  late TextEditingController confirmPassword;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    newPassword = TextEditingController();
    confirmPassword = TextEditingController();
    phone = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    phone.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(customerProvider.notifier);
    final state = ref.watch(customerProvider);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppHelpers.getTranslation(TrKeys.addCustomer),
            style: GoogleFonts.inter(
                fontSize: 22.sp,
                color: Style.black,
                fontWeight: FontWeight.w600),
          ),
          IconButton(
              splashRadius: 28.r,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Remix.close_fill))
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedBorderTextField(
                validator: (s) {
                  if (s?.isEmpty ?? true) {
                    return AppHelpers.getTranslation(TrKeys.enterName);
                  }
                  return null;
                },
                textController: firstName,
                border: Style.transparent,
                color: Style.editProfileCircle,
                label: '${AppHelpers.getTranslation(TrKeys.firstname)}*',
                style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Style.black,
                    fontWeight: FontWeight.w500),
              ),
              12.verticalSpace,
              OutlinedBorderTextField(
                  validator: (s) {
                    if (s?.isEmpty ?? true) {
                      return AppHelpers.getTranslation(TrKeys.enterLastName);
                    }
                    return null;
                  },
                  textController: lastName,
                  border: Style.transparent,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Style.black,
                      fontWeight: FontWeight.w500),
                  color: Style.editProfileCircle,
                  label: '${AppHelpers.getTranslation(TrKeys.lastname)}*'),
              12.verticalSpace,
              OutlinedBorderTextField(
                  validator: (s) {
                    if (s?.isEmpty ?? true) {
                      return AppHelpers.getTranslation(TrKeys.enterPhone);
                    }
                    return null;
                  },
                  textController: phone,
                  border: Style.transparent,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Style.black,
                      fontWeight: FontWeight.w500),
                  color: Style.editProfileCircle,
                  label: '${AppHelpers.getTranslation(TrKeys.phone)}*'),
              12.verticalSpace,
              OutlinedBorderTextField(
                  validator: (s) {
                    if (s?.isEmpty ?? true) {
                      return AppHelpers.getTranslation(TrKeys.enterEmail);
                    }
                    return null;
                  },
                  textController: email,
                  border: Style.transparent,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Style.black,
                      fontWeight: FontWeight.w500),
                  color: Style.editProfileCircle,
                  label: '${AppHelpers.getTranslation(TrKeys.email)}*'),
              48.verticalSpace,
              Row(
                children: [
                  SizedBox(
                    height: 52.r,
                    width: 148.r,
                    child: LoginButton(
                        isLoading: state.createUserLoading,
                        title: AppHelpers.getTranslation(TrKeys.save),
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            notifier.createCustomer(context,
                                email: email.text,
                                lastName: lastName.text,
                                name: firstName.text,
                                phone: phone.text, created: (c) {
                               context.maybePop();
                            });
                          }
                        }),
                  ),
                  21.horizontalSpace,
                  CustomButton(
                    onTap: () => Navigator.pop(context),
                    bgColor: Style.transparent,
                    title: AppHelpers.getTranslation(TrKeys.cancel),
                    textColor: Style.black,
                    borderColor: Style.iconColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
