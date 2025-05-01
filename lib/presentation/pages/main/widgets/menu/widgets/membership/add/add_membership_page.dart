import 'package:admin_desktop/app_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:remixicon_updated/remixicon_updated.dart';
import 'package:admin_desktop/application/membership/add/add_membership_notifier.dart';
import 'package:admin_desktop/application/membership/add/add_membership_state.dart';
import 'package:admin_desktop/application/providers.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../widget/service_multi_selection.dart';

class AddMembershipPage extends ConsumerStatefulWidget {
  const AddMembershipPage({super.key});

  @override
  ConsumerState<AddMembershipPage> createState() => _AddMembershipPageState();
}

class _AddMembershipPageState extends ConsumerState<AddMembershipPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;
  late TextEditingController term;
  late TextEditingController price;
  late TextEditingController sessionsCount;
  late AddMembershipNotifier notifier;

  @override
  void initState() {
    title = TextEditingController();
    desc = TextEditingController();
    term = TextEditingController();
    price = TextEditingController();
    sessionsCount = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(addMembershipProvider.notifier).clear(),
    );
  }

  @override
  void didChangeDependencies() {
    notifier = ref.read(addMembershipProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    term.dispose();
    price.dispose();
    sessionsCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addMembershipProvider);
    return KeyboardDisable(
      child: Scaffold(
        body: state.membership == null || state.isLoading
            ? const Loading()
            : Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.addMembership),
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Style.black),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                           context.maybePop();
                        },
                        icon: const Icon(Remix.close_fill),
                      )
                    ],
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            24.verticalSpace,
                            OutlinedBorderTextField(
                              label:
                                  '${AppHelpers.getTranslation(TrKeys.title)}*',
                              textInputAction: TextInputAction.next,
                              textController: title,
                              validator: AppValidators.emptyCheck,
                            ),
                            12.verticalSpace,
                            OutlinedBorderTextField(
                              label:
                                  '${AppHelpers.getTranslation(TrKeys.description)}*',
                              textInputAction: TextInputAction.next,
                              textController: desc,
                              validator: AppValidators.emptyCheck,
                            ),
                            12.verticalSpace,
                            OutlinedBorderTextField(
                              label:
                                  '${AppHelpers.getTranslation(TrKeys.term)}*',
                              textInputAction: TextInputAction.next,
                              textController: term,
                              validator: AppValidators.emptyCheck,
                            ),
                            12.verticalSpace,
                            _servicesItem(state),
                            12.verticalSpace,
                            OutlinedBorderTextField(
                              label: AppHelpers.getPriceLabel,
                              textInputAction: TextInputAction.next,
                              textController: price,
                              inputFormatters: [InputFormatter.currency],
                              validator: AppValidators.isNumberValidator,
                            ),
                            12.verticalSpace,
                            OutlineDropDown(
                              value: state.membership?.time,
                              list: DropDownValues.timeOptionsList,
                              onChanged: notifier.setTime,
                              label: TrKeys.time,
                            ),
                            12.verticalSpace,
                            OutlineDropDown(
                              value: DropDownValues.sessionsList[
                                  ((state.membership?.sessions ?? 2) - 1)],
                              list: DropDownValues.sessionsList,
                              onChanged: notifier.setSession,
                              label: TrKeys.session,
                            ),
                            12.verticalSpace,
                            if (state.membership?.sessions == 1)
                              OutlinedBorderTextField(
                                label: TrKeys.sessionsCount,
                                textInputAction: TextInputAction.next,
                                textController: sessionsCount,
                                inputFormatters: [InputFormatter.currency],
                                validator: AppValidators.isNumberValidator,
                              ),
                            16.verticalSpace,
                            ColorPicker(
                              pickerAreaBorderRadius: BorderRadius.circular(
                                AppConstants.radius / 0.8,
                              ),
                              enableAlpha: false,
                              displayThumbColor: true,
                              labelTypes: ColorLabelType.values,
                              colorPickerWidth: 160.r,
                              pickerColor:
                                  state.membership?.color ?? Style.primary,
                              onColorChanged: notifier.setColor,
                            ),
                            56.verticalSpace,
                            CustomButton(
                              title: AppHelpers.getTranslation(TrKeys.save),
                              isLoading: state.isLoading,
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (state.services.isEmpty) {
                                    AppHelpers.errorSnackBar(
                                      context,
                                      text: AppHelpers.getTranslation(
                                          TrKeys.serviceIsRequired),
                                    );
                                    return;
                                  }
                                  notifier.createMembership(
                                    context,
                                    created: (value) {
                                      ref
                                          .read(membershipProvider.notifier)
                                          .fetchMemberships(
                                            context: context,
                                            isRefresh: true,
                                          );
                                       context.maybePop();
                                    },
                                    title: title.text,
                                    description: desc.text,
                                    term: term.text,
                                    price: price.text,
                                    sessionCount: sessionsCount.text,
                                  );
                                }
                              },
                            ),
                            56.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _servicesItem(AddMembershipState state) {
    return GestureDetector(
      onTap: () {
        AppHelpers.showAlertDialog(
          context: context,
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 1.5,
              width: MediaQuery.sizeOf(context).width / 2,
              child: const ServiceMultiSelection()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Style.colorGrey, width: 0.5.r),
          ),
        ),
        height: 40.r,
        padding: REdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.sizeOf(context).width,
        child: state.services.isEmpty
            ? Text(
                AppHelpers.getTranslation(TrKeys.select),
                style: Style.interNormal(size: 14, color: Style.colorGrey),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.services.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final service = state.services[index];
                  return CustomChip(
                    label: service.translation?.title,
                    onDeleted: () {
                      notifier.deleteService(service.id);
                    },
                  );
                },
              ),
      ),
    );
  }
}
