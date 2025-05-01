import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/presentation/styles/style.dart';
import 'extras_filter_item.dart';

class ExtrasScreen extends StatelessWidget {
  final List<Groups> group;
  final List<int> listExtras;
  final ValueChanged<int> onChange;

  const ExtrasScreen({
    super.key,
    required this.group,
    required this.listExtras,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: group.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.r),
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
                color: Style.white, borderRadius: BorderRadius.circular(16.r)),
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Style.transparent,
                  primaryColor: Style.black,
                  colorScheme: Theme.of(context)
                      .colorScheme
                      .copyWith(secondary: Style.black, primary: Style.black)),
              child: ExpansionTile(
                title: Text(
                  group[index].title ?? "",
                  style: Style.interNormal(color: Style.black, size: 16),
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: group[index]
                              .extras
                              ?.map((e) => InkWell(
                                    onTap: () => onChange(e.id ?? 0),
                                    child: ExtrasFilterItem(
                                      list: listExtras,
                                      type: group[index].type ?? "",
                                      extra: e,
                                    ),
                                  ))
                              .toList() ??
                          [],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
