import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../../../../../../../theme/theme/theme.dart';
import '../riverpod/service_master/add/add_service_master_provider.dart';
import '../riverpod/service_master/service_master_provider.dart';
import '../widgets/masters_modal.dart';
import '../widgets/services_modal.dart';

class AddServiceMasterPage extends ConsumerStatefulWidget {
  const AddServiceMasterPage({super.key});

  @override
  ConsumerState<AddServiceMasterPage> createState() => _AddServicePageState();
}

class _AddServicePageState extends ConsumerState<AddServiceMasterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController commission;
  late TextEditingController pause;
  late TextEditingController price;
  late TextEditingController interval;
  late TextEditingController master;
  late TextEditingController service;
  UserData? selectMaster;
  ServiceData? selectService;

  @override
  void initState() {
    commission = TextEditingController();
    pause = TextEditingController();
    price = TextEditingController();
    interval = TextEditingController();
    master = TextEditingController();
    service = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(addServiceMasterProvider.notifier).clear());
  }

  @override
  void dispose() {
    commission.dispose();
    pause.dispose();
    price.dispose();
    interval.dispose();
    master.dispose();
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addServiceMasterProvider);
    final notifier = ref.read(addServiceMasterProvider.notifier);
    return KeyboardDisable(
      child: CustomScaffold(
        body: (CustomColorSet colors) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      ref.read(catalogueProvider.notifier).changeState(3);
                    },
                  ),
                  20.horizontalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.addServiceToMaster),
                    style: Style.interMedium(size: 20),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          readOnly: true,
                          onTap: () {
                            AppHelpers.showAlertDialog(
                              context: context,
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height / 1.5,
                                width: MediaQuery.sizeOf(context).width / 2,
                                child: ServicesModal(
                                  onChange: (value) {
                                    selectService = value;
                                    service.text =
                                        value.translation?.title ?? '';
                                    interval.text = "${value.interval ?? 0}";
                                    pause.text = "${value.pause ?? 0}";
                                    price.text = "${value.price ?? 0}";
                                  },
                                ),
                              ),
                            );
                          },
                          label:
                              "${AppHelpers.getTranslation(TrKeys.service)}*",
                          textInputAction: TextInputAction.next,
                          validator: AppValidators.emptyCheck,
                          textController: service,
                        ),
                        12.verticalSpace,
                        OutlinedBorderTextField(
                          readOnly: true,
                          onTap: () {
                            AppHelpers.showAlertDialog(
                              context: context,
                              child: SizedBox(
                                height: MediaQuery.sizeOf(context).height / 1.5,
                                width: MediaQuery.sizeOf(context).width / 2,
                                child: MastersModal(
                                  user: selectMaster,
                                  onChange: (value) {
                                    selectMaster = value;
                                    master.text = value.firstname ?? '';
                                  },
                                ),
                              ),
                            );
                          },
                          label: "${AppHelpers.getTranslation(TrKeys.master)}*",
                          textInputAction: TextInputAction.next,
                          validator: AppValidators.emptyCheck,
                          textController: master,
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label:
                              '${AppHelpers.getTranslation(TrKeys.interval)}*',
                          textInputAction: TextInputAction.next,
                          textController: interval,
                          inputType: TextInputType.number,
                          validator: AppValidators.isNumberValidator,
                          inputFormatters: [InputFormatter.digitsOnly],
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label: '${AppHelpers.getTranslation(TrKeys.pause)}*',
                          textInputAction: TextInputAction.next,
                          inputType: TextInputType.number,
                          textController: pause,
                          validator: AppValidators.isNumberValidator,
                          inputFormatters: [InputFormatter.digitsOnly],
                        ),
                        16.verticalSpace,
                        OutlinedBorderTextField(
                          label: '${AppHelpers.getTranslation(TrKeys.price)}*',
                          textInputAction: TextInputAction.next,
                          textController: price,
                          inputType: TextInputType.number,
                          validator: AppValidators.emptyCheck,
                          inputFormatters: [InputFormatter.currency],
                        ),
                        12.verticalSpace,
                        OutlinedBorderTextField(
                          label:
                              AppHelpers.getTranslation(TrKeys.commissionFee),
                          textInputAction: TextInputAction.done,
                          textController: commission,
                          inputType: TextInputType.number,
                          inputFormatters: [InputFormatter.currency],
                        ),
                        16.verticalSpace,
                        OutlineDropDown(
                          label: TrKeys.gender,
                          hint: TrKeys.gender,
                          list: DropDownValues.genderList,
                          onChanged: notifier.setGender,
                        ),
                        60.verticalSpace,
                        CustomButton(
                          textColor: Style.white,
                          title: AppHelpers.getTranslation(TrKeys.save),
                          isLoading: state.isLoading,
                          onTap: () {
                            if ((_formKey.currentState?.validate() ?? false) &&
                                selectMaster?.id != null) {
                              notifier.createService(
                                context,
                                created: (service) {
                                  AppHelpers.showSnackBar(
                                    context,
                                    AppHelpers.getTranslation(
                                        TrKeys.successfullyCreated),
                                  );
                                  ref
                                      .read(serviceMasterProvider.notifier)
                                      .fetchServices(
                                          context: context, isRefresh: true);
                                  context.maybePop();
                                },
                                onError: () {},
                                price: price.text,
                                interval: interval.text,
                                pause: pause.text,
                                masterId: selectMaster!.id!,
                                serviceId: selectService?.id ?? 0,
                                commissionFee: commission.text,
                              );
                            }
                          },
                        ),
                        60.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
