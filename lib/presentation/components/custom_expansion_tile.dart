import 'package:flutter/material.dart';
import '../styles/style.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  const CustomExpansionTile(
      {super.key, required this.title, required this.children});

  @override
  CustomExpansionTileState createState() => CustomExpansionTileState();
}

class CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.title,
              Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            ],
          ),
        ),
        // 12.verticalSpace,
        const Divider(color: Style.hint),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Column(children: widget.children),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
