import 'package:flutter/material.dart';

class HobbyTag<T> extends StatelessWidget {
  const HobbyTag(
      {super.key,
      required this.displayName,
      required this.value,
      required this.selected,
      this.onSelect});
  final String displayName;
  final T value;
  final bool selected;
  final void Function(T)? onSelect;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: InkWell(
        onTap: onSelect != null ? () => onSelect!(value) : null,
        radius: 20,
        borderRadius: BorderRadius.circular(20),
        customBorder: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: selected ? Theme.of(context).primaryColor : Colors.white,
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
              borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: Text(
            displayName,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: selected ? Colors.white : null,
                ),
          ),
        ),
      ),
    );
  }
}
