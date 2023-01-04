import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlusAccordion extends StatefulWidget {
  const PlusAccordion({Key? key, required this.child, required this.title})
      : super(key: key);
  final Widget child;
  final String title;
  @override
  State<PlusAccordion> createState() => _PlusAccordionState();
}

class _PlusAccordionState extends State<PlusAccordion> {
  late bool _isExpanded;

  @override
  void initState() {
    _isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        elevation: 0,
        children: [
          ExpansionPanel(
            backgroundColor: context.theme.hoverColor,
            isExpanded: _isExpanded,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  widget.title,
                  style: TextStyle(
                    color: context.theme.colorScheme.onBackground,
                  ),
                ),
              );
            },
            canTapOnHeader: true,
            body: widget.child,
          ),
        ],
      ),
    );
  }
}
