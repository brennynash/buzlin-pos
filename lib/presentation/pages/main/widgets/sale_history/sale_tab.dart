import 'package:flutter/material.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'package:intl/intl.dart';
import '../../../../../../domain/models/response/sale_history_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:admin_desktop/presentation/components/components.dart';

class SaleTab extends StatelessWidget {
  final List<SaleHistoryModel> list;
  final bool isLoading;
  final bool isMoreLoading;
  final bool hasMore;
  final VoidCallback viewMore;

  const SaleTab(
      {super.key,
      required this.list,
      required this.isLoading,
      required this.hasMore,
      required this.viewMore,
      required this.isMoreLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Style.white),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Style.black,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                    defaultColumnWidth: FixedColumnWidth(
                        (MediaQuery.sizeOf(context).width) / 7),
                    border: TableBorder.all(color: Style.transparent),
                    children: [
                      TableRow(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  AppHelpers.getTranslation(TrKeys.id),
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Style.black,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.client),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Style.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.3,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.amount),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Style.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.3,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.paymentType),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Style.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.3,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.note),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Style.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.3,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppHelpers.getTranslation(TrKeys.date),
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Style.black,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.3,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      for (int i = 0; i < list.length; i++)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      "#${AppHelpers.getTranslation(TrKeys.id)}${list[i].id}",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Style.iconColor,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Text(
                                    "${list[i].user?.firstname ?? ""} ${list[i].user?.lastname ?? ""}",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Style.iconColor,
                                      letterSpacing: -0.3,
                                    ),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Text(
                                    AppHelpers.numberFormat(
                                        number: list[i].totalPrice),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Style.iconColor,
                                      letterSpacing: -0.3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Text(
                                    (list[i].transactions?.isNotEmpty ?? false)
                                        ? list[i]
                                                .transactions
                                                ?.first
                                                .paymentSystem
                                                ?.tag ??
                                            ""
                                        : AppHelpers.getTranslation(TrKeys.na),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Style.iconColor,
                                      letterSpacing: -0.3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Text(
                                    list[i].note ??
                                        AppHelpers.getTranslation(TrKeys.na),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Style.iconColor,
                                      letterSpacing: -0.3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Text(
                                    DateFormat('d MMM yyyy').format(
                                        list[i].createdAt ?? DateTime.now()),
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Style.iconColor,
                                      letterSpacing: -0.3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  isMoreLoading
                      ? const Padding(
                          padding: EdgeInsets.only(top: 18),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Style.black,
                          )),
                        )
                      : hasMore
                          ? InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                viewMore.call();
                              },
                              child: ButtonEffectAnimation(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 64, vertical: 16),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Style.black.withOpacity(0.17),
                                      width: 1,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppHelpers.getTranslation(TrKeys.viewMore),
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Style.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                ],
              ),
            ),
    );
  }
}
