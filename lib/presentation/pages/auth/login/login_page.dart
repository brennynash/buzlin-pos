import 'package:admin_desktop/app_constants.dart';
import 'package:admin_desktop/presentation/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:admin_desktop/application/providers.dart';
import '../../../assets.dart';
import '../../../../infrastructure/services/utils.dart';
import '../../../components/components.dart';
import '../../../components/text_fields/custom_textformfield.dart';
import '../../main/widgets/language/languages_modal.dart';
import 'widgets/custom_passwords.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(languagesProvider.notifier).checkLanguage(),
    );
  }

  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      languagesProvider,
      (previous, next) {
        if (next.isSelectLanguage &&
            next.isSelectLanguage != previous?.isSelectLanguage) {
          AppHelpers.showAlertDialog(
            context: context,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              width: MediaQuery.sizeOf(context).width / 4,
              child: LanguagesModal(
                afterUpdate: () {
                  context.maybePop();
                },
              ),
            ),
          );
        }
      },
    );
    final notifier = ref.read(loginProvider.notifier);
    final state = ref.watch(loginProvider);
    return KeyboardDismisser(
      child: AbsorbPointer(
        absorbing: state.isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Style.mainBack,
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                SafeArea(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 500.r),
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.r, right: 50.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          42.verticalSpace,
                          Row(
                            children: [
                              
                              Expanded(
                                child: Text(
                                  "Buzlin POS",
                                  style: GoogleFonts.inter(
                                      fontSize: 32.sp,
                                      color: const Color(0xFF327878),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          56.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.login),
                            style: GoogleFonts.inter(
                                fontSize: 32.sp,
                                color: Style.black,
                                fontWeight: FontWeight.bold),
                          ),
                          36.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.email),
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Style.black,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomTextField(
                            hintText:
                                AppHelpers.getTranslation(TrKeys.typeSomething),
                            onChanged: notifier.setEmail,
                            textController: login,
                            inputType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            isError:
                                state.isLoginError || state.isEmailNotValid,
                            descriptionText: state.isEmailNotValid
                                ? AppHelpers.getTranslation(
                                    TrKeys.emailIsNotValid)
                                : (state.isLoginError
                                    ? AppHelpers.getTranslation(
                                        TrKeys.loginCredentialsAreNotValid)
                                    : null),
                            onFieldSubmitted: (value) => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.emailNotVerifiedYet),
                                );
                              },
                              goToMain: () {
                                context.replaceRoute(const MainRoute());
                              },
                            ),
                          ),
                          50.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.password),
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Style.black,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomTextField(
                            textController: password,
                            hintText:
                                AppHelpers.getTranslation(TrKeys.typeSomething),
                            obscure: state.showPassword,
                            onChanged: notifier.setPassword,
                            textCapitalization: TextCapitalization.none,
                            isError:
                                state.isLoginError || state.isPasswordNotValid,
                            descriptionText: state.isPasswordNotValid
                                ? AppHelpers.getTranslation(TrKeys
                                    .passwordShouldContainMinimum8Characters)
                                : (state.isLoginError
                                    ? AppHelpers.getTranslation(
                                        TrKeys.loginCredentialsAreNotValid)
                                    : null),
                            suffixIcon: IconButton(
                              splashRadius: 25.r,
                              icon: Icon(
                                state.showPassword
                                    ? Remix.eye_line
                                    : Remix.eye_close_line,
                                color: Style.black,
                                size: 20.r,
                              ),
                              onPressed: () =>
                                  notifier.setShowPassword(!state.showPassword),
                            ),
                            onFieldSubmitted: (value) => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.emailNotVerifiedYet),
                                );
                              },
                              goToMain: () {
                                bool checkPin =
                                    LocalStorage.getPinCode().isEmpty;
                                context.replaceRoute(
                                    PinCodeRoute(isNewPassword: checkPin));
                              },
                            ),
                          ),
                          42.verticalSpace,
                          Row(
                            children: [
                              CustomCheckbox(isActive: true, onTap: () {}),
                              14.horizontalSpace,
                              Text(
                                AppHelpers.getTranslation(TrKeys.keepMe),
                                style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    color: Style.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          56.verticalSpace,
                          LoginButton(
                            isLoading: state.isLoading,
                            title: AppHelpers.getTranslation(TrKeys.login),
                            onPressed: () => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.emailNotVerifiedYet),
                                );
                              },
                              goToMain: () {
                                context.replaceRoute(
                                    PinCodeRoute(isNewPassword: true));
                              },
                            ),
                          ),
                         
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFF327878),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://blogs.buzlin.ca/wp-content/uploads/2025/04/1.2-Buzlin_White-Mark_-Transparent-BG-Icon-300x300.png',
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Connecting you to excellence',
                          style: Style.interMedium(
                            size: 35,
                            color: Style.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
