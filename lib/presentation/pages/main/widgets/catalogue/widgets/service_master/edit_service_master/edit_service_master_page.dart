import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../application/providers.dart';
import '../../../../../../../../../domain/models/models.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../styles/style.dart';
import '../../../../../../../theme/theme/theme.dart';
import '../riverpod/service_master/edit/edit_service_master_provider.dart';
import '../riverpod/service_master/service_master_provider.dart';

class EditServiceMasterPage extends ConsumerStatefulWidget {
  const EditServiceMasterPage({super.key});

  @override
  ConsumerState<EditServiceMasterPage> createState() => _EditLooksPageState();
}

class _EditLooksPageState extends ConsumerState<EditServiceMasterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController commission;
  late TextEditingController pause;
  late TextEditingController price;
  late TextEditingController master;
  late TextEditingController interval;
  late TextEditingController service;
  UserData? selectMaster;
  ServiceData? selectService;

  @override
  void initState() {
    final ServiceData? serviceData =
        ref.read(editServiceMasterProvider).serviceData;
    commission =
        TextEditingController(text: "${serviceData?.commissionFee ?? ''}");
    pause = TextEditingController(text: "${serviceData?.pause ?? 0}");
    price = TextEditingController(text: "${serviceData?.price ?? 0}");
    interval = TextEditingController(text: "${serviceData?.interval ?? ''}");
    master =
        TextEditingController(text: "${serviceData?.master?.firstname ?? 0}");
    service = TextEditingController(
        text: "${serviceData?.service?.translation?.title ?? 0}");
    selectMaster = serviceData?.master;
    selectService = serviceData?.service;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(editServiceMasterProvider.notifier).fetchServiceDetails(
          context: context,
          id: ref.read(editServiceMasterProvider).serviceData?.id,
          onSuccess: (ServiceData? value) {
            selectMaster = value?.master;
            selectService = value?.service;
            master.text = value?.master?.firstname ?? '';
          }),
    );
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
    final state = ref.watch(editServiceMasterProvider);
    final notifier = ref.read(editServiceMasterProvider.notifier);
    return KeyboardDisable(
      child: CustomScaffold(
        body: (CustomColorSet colors) {
          return state.serviceData == null || state.isLoading
              ? const Loading()
              : Column(
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
                          AppHelpers.getTranslation(TrKeys.editServiceToMaster),
                          style: Style.interMedium(size: 20),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              16.verticalSpace,
                              OutlinedBorderTextField(
                                readOnly: true,
                                onTap: () {
                                  // AppHelpers.showCustomModalBottomSheet(
                                  //   context: context,
                                  //   modal: ModalWrap(
                                  //     body: ServicesModal(
                                  //       onChange: (value) {
                                  //         selectService = value;
                                  //         service.text =
                                  //             value.translation?.title ?? '';
                                  //         interval.text =
                                  //             "${value.interval ?? 0}";
                                  //         pause.text = "${value.pause ?? 0}";
                                  //         price.text = "${value.price ?? 0}";
                                  //       },
                                  //     ),
                                  //   ),
                                  // );
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
                                  // AppHelpers.showCustomModalBottomSheet(
                                  //   context: context,
                                  //   modal: ModalWrap(
                                  //     body: MastersModal(
                                  //       user: selectMaster,
                                  //       onChange: (value) {
                                  //         selectMaster = value;
                                  //         master.text = value.firstname ?? '';
                                  //       },
                                  //     ),
                                  //   ),
                                  // );
                                },
                                label:
                                    "${AppHelpers.getTranslation(TrKeys.master)}*",
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
                                label:
                                    '${AppHelpers.getTranslation(TrKeys.pause)}*',
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.number,
                                textController: pause,
                                validator: AppValidators.isNumberValidator,
                                inputFormatters: [InputFormatter.digitsOnly],
                              ),
                              16.verticalSpace,
                              OutlinedBorderTextField(
                                label:
                                    '${AppHelpers.getTranslation(TrKeys.price)}*',
                                textInputAction: TextInputAction.next,
                                textController: price,
                                inputType: TextInputType.number,
                                validator: AppValidators.emptyCheck,
                                inputFormatters: [InputFormatter.currency],
                              ),
                              12.verticalSpace,
                              OutlinedBorderTextField(
                                label: AppHelpers.getTranslation(
                                    TrKeys.commissionFee),
                                textInputAction: TextInputAction.done,
                                textController: commission,
                                inputType: TextInputType.number,
                                inputFormatters: [InputFormatter.currency],
                              ),
                              16.verticalSpace,
                              OutlineDropDown(
                                label: TrKeys.gender,
                                list: DropDownValues.genderList,
                                onChanged: notifier.setGender,
                                value: state.serviceData?.gender,
                              ),
                              60.verticalSpace,
                              CustomButton(
                                textColor: Style.white,
                                title: AppHelpers.getTranslation(TrKeys.save),
                                isLoading: state.isUpdating,
                                onTap: () {
                                  if ((_formKey.currentState?.validate() ??
                                          false) &&
                                      selectMaster?.id != null) {
                                    notifier.updateService(
                                      context,
                                      updated: (service) {
                                        AppHelpers.showSnackBar(
                                          context,
                                          AppHelpers.getTranslation(
                                              TrKeys.successfullyUpdated),
                                        );
                                        ref
                                            .read(
                                                serviceMasterProvider.notifier)
                                            .fetchServices(
                                                context: context,
                                                isRefresh: true);
                                        context.maybePop();
                                      },
                                      price: price.text,
                                      interval: interval.text,
                                      pause: pause.text,
                                      serviceId: selectService!.id!,
                                      masterId: selectMaster?.id ?? 0,
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
