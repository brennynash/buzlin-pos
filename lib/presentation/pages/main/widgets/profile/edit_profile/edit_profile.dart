import 'package:admin_desktop/application/edit_profile/edit_profile_state.dart';
import 'package:admin_desktop/application/profile/profile_notifier.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import '../../../../../../../domain/models/data/user_data.dart';
import '../../../../../assets.dart';
import 'package:admin_desktop/application/edit_profile/edit_profile_notifier.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';
import '../../../../../components/text_fields/outlined_phone_field.dart';
import '../../product/edit/widgets/custom_date_textform.dart';

class EditProfileWidget extends StatefulWidget {
  final EditProfileState state;
  final EditProfileNotifier notifier;
  final ProfileNotifier profileNotifier;

  const EditProfileWidget(
      {super.key,
      required this.state,
      required this.notifier,
      required this.profileNotifier});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController confirmPassword;
  late TextEditingController newPassword;
  late TextEditingController dateOfBirth;
  late TextEditingController personalPinCode;

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    dateOfBirth = TextEditingController();
    confirmPassword = TextEditingController();
    newPassword = TextEditingController();
    personalPinCode = TextEditingController();
    getInfo();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    dateOfBirth.dispose();
    confirmPassword.dispose();
    newPassword.dispose();
    personalPinCode.dispose();
    super.dispose();
  }

  getInfo() {
    firstName.text = LocalStorage.getUser()?.firstname ?? '';
    lastName.text = LocalStorage.getUser()?.lastname ?? '';
    dateOfBirth.text = LocalStorage.getUser()?.birthday.toString() ?? '';
    firstName.text = LocalStorage.getUser()?.firstname ?? '';
    email.text = LocalStorage.getUser()?.email ?? '';
    dateOfBirth.text = TimeService.dateFormatDay(
        DateTime.tryParse(LocalStorage.getUser()?.birthday.toString() ?? ''));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.notifier.setGender(LocalStorage.getUser()?.gender ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final notifier = ref.read(editProfileProvider.notifier);
    // final state = ref.watch(editProfileProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 16, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Style.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            shrinkWrap: true,
            children: [
              24.verticalSpace,
              Row(
                children: [
                  CustomEditWidget(
                      image: widget.state.url,
                      imagePath: widget.state.imagePath,
                      isEmptyorNot:
                          (LocalStorage.getUser()?.img?.isNotEmpty ?? false) &&
                              widget.state.imagePath.isEmpty,
                      isEmptyorNot2: widget.state.imagePath.isNotEmpty,
                      localStoreImage: LocalStorage.getUser()?.img ?? "",
                      onthisTap: () {
                        widget.notifier.getPhoto();
                      }),
                  24.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.state.userData?.firstname ?? LocalStorage.getUser()?.firstname ?? ""}'
                          '${widget.state.userData?.lastname?.substring(0, 1).toUpperCase() ?? LocalStorage.getUser()?.lastname?.substring(0, 1).toUpperCase() ?? ""}',
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              color: Style.black,
                              fontWeight: FontWeight.bold),
                        ),
                        8.verticalSpace,
                        Text(
                          widget.state.userData?.role ??
                              LocalStorage.getUser()?.role ??
                              TrKeys.seller,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Style.iconColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  _walletItem(widget.state, widget.profileNotifier),
                  12.horizontalSpace,
                ],
              ),
              42.verticalSpace,
              Row(
                children: [
                  for (int index = 0; index < 2; index++)
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            widget.notifier.changeIndex(index);
                            widget.notifier.setGender(
                                index == 0 ? TrKeys.male : TrKeys.female);
                          },
                          child: CircleChoosingButton(
                            isActive: widget.state.selectIndex == index,
                          ),
                        ),
                        12.horizontalSpace,
                        Text(
                          index == 0
                              ? AppHelpers.getTranslation(TrKeys.male)
                              : AppHelpers.getTranslation(TrKeys.female),
                          style: Style.interNormal(),
                        ),
                        24.horizontalSpace,
                      ],
                    )
                ],
              ),
              18.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: OutlinedBorderTextField(
                        textController: firstName,
                        label: TrKeys.firstname,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: OutlinedBorderTextField(
                        textController: lastName,
                        label: TrKeys.lastname,
                      ),
                    ),
                  )
                ],
              ),
              24.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: OutlinedBorderTextField(
                        inputType: TextInputType.emailAddress,
                        textController: email,
                        label: TrKeys.email,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: OutlinedBorderTextField(
                        maxLine: 1,
                        label: TrKeys.newPassword,
                        textController: confirmPassword,
                        obscure: widget.state.showOldPassword,
                        suffixIcon: GestureDetector(
                          child: Icon(
                            widget.state.showOldPassword
                                ? Remix.eye_line
                                : Remix.eye_close_line,
                            color: Style.black,
                            size: 20,
                          ),
                          onTap: () => widget.notifier.setShowOldPassword(
                              !widget.state.showOldPassword),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              24.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: REdgeInsets.only(right: 100),
                        child: OutlinedPhoneField(
                          onchange: (v) => widget.notifier.setPhoneNumber(v),
                          initialValue: LocalStorage.getUser()?.phone ??
                              widget.state.phoneNumber,
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: OutlinedBorderTextField(
                        maxLine: 1,
                        label: TrKeys.confirmNewPassword,
                        textController: newPassword,
                        obscure: widget.state.showPassword,
                        suffixIcon: IconButton(
                          splashRadius: 25.r,
                          icon: Icon(
                            widget.state.showPassword
                                ? Remix.eye_line
                                : Remix.eye_close_line,
                            color: Style.black,
                            size: 20.r,
                          ),
                          onPressed: () => widget.notifier
                              .setShowPassword(!widget.state.showPassword),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: CustomDateFormField(
                        controller: dateOfBirth,
                        text: AppHelpers.getTranslation(TrKeys.dateOfBirth),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: OutlinedBorderTextField(
                        maxLength: 4,
                        maxLine: 1,
                        label: TrKeys.personalPincode,
                        textController: personalPinCode,
                        inputType: TextInputType.number,
                        obscure: widget.state.showPincode,
                        suffixIcon: IconButton(
                          splashRadius: 25,
                          icon: Icon(
                            widget.state.showPincode
                                ? Remix.eye_line
                                : Remix.eye_close_line,
                            color: Style.black,
                            size: 20,
                          ),
                          onPressed: () => widget.notifier
                              .setShowPersonalPincode(
                                  !widget.state.showPincode),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              24.verticalSpace,
              Row(
                children: [
                  SizedBox(
                    width: 250.r,
                    child: LoginButton(
                        isLoading: widget.state.isLoading,
                        title: AppHelpers.getTranslation(TrKeys.save),
                        onPressed: () {
                          widget.notifier.editProfile(
                              context,
                              UserData(
                                birthday: dateOfBirth.text,
                                img: widget.state.imagePath,
                                firstname: firstName.text,
                                lastname: lastName.text,
                                email: email.text,
                                phone: widget.state.phoneNumber.isNotEmpty
                                    ? widget.state.phoneNumber
                                    : LocalStorage.getUser()?.phone ?? '',
                              ));
                          if (newPassword.text.isNotEmpty &&
                              confirmPassword.text.isNotEmpty) {
                            widget.notifier.updatePassword(context,
                                password: confirmPassword.text,
                                confirmPassword: newPassword.text);
                          }
                          if (personalPinCode.text.isNotEmpty &&
                              personalPinCode.text.length == 4) {
                            LocalStorage.setPinCode(personalPinCode.text);
                          }
                        }),
                  ),
                ],
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  _walletItem(EditProfileState state, ProfileNotifier profileNotifier) {
    return ButtonEffectAnimation(
      onTap: () => profileNotifier.changeIndex(8),
      child: Container(
        height: 72,
        width: MediaQuery.sizeOf(context).width / 5,
        padding: REdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: Style.walletShadow,
          borderRadius: BorderRadius.circular(12),
          gradient: Style.walletGradient,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Style.white.withOpacity(.2),
              child: Padding(
                padding: REdgeInsets.only(top: 12),
                child: Center(
                  child: SvgPicture.asset(Assets.svgDollarIcon),
                ),
              ),
            ),
            5.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.balance),
                    style: Style.interNormal(
                      color: Style.white,
                      size: 12,
                    ),
                  ),
                  AutoSizeText(
                    AppHelpers.numberFormat(
                      number: state.userData?.wallet?.price ??
                          LocalStorage.getWallet()?.price,
                      isOrder: true,
                      symbol: LocalStorage.getWallet()?.symbol,
                    ),
                    style: Style.interSemi(size: 16, color: Style.white),
                    minFontSize: 12,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
