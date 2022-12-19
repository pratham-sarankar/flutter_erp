import 'package:flutter/material.dart';

class PlusNavigationRail extends StatefulWidget {
  const PlusNavigationRail(
      {Key? key,
      required this.destinations,
      required this.width,
      required this.path,
      this.onChanged})
      : super(key: key);
  final List<PlusNavigationRailItem> destinations;
  final double width;
  final String path;
  final Function(String)? onChanged;
  @override
  State<PlusNavigationRail> createState() => _PlusNavigationRailState();
}

class _PlusNavigationRailState extends State<PlusNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < widget.destinations.length; i++)
          InkWell(
            onTap: () {
              if (widget.onChanged == null) return;
              widget.onChanged!(widget.destinations[i].path);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 0, bottom: 13, right: 30),
              padding: const EdgeInsets.only(left: 0),
              decoration: BoxDecoration(
                color: widget.path == widget.destinations[i].path
                    ? Colors.grey.shade100
                    : null,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(5),
                ),
              ),
              child: Container(
                width: widget.width,
                padding: const EdgeInsets.only(
                    left: 15, top: 5, bottom: 5, right: 15),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        width: 2,
                        color: widget.path == widget.destinations[i].path
                            ? Colors.black
                            : Colors.transparent),
                  ),
                ),
                child: Text(
                  widget.destinations[i].label,
                  style: TextStyle(
                    fontSize: 13,
                    color: widget.path == widget.destinations[i].path
                        ? Colors.black
                        : Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class PlusNavigationRailItem {
  final String label;
  final String path;

  PlusNavigationRailItem({required this.label, required this.path});
}
