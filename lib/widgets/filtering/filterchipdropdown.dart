import 'package:flutter/material.dart';
import 'package:studee_app/widgets/model/filterchipitem.dart';

class FilterChipDropdown extends StatefulWidget {
  const FilterChipDropdown({
    super.key,
    required this.initialLabel,
    this.unselectedColor = const Color.fromARGB(255, 255, 251, 238),
    this.unselectedLabelColor = Colors.black,
    this.selectedColor = Colors.green,
    this.selectedLabelColor = Colors.white,
    required this.onSelectionChanged,
    this.labelPadding = 16,
    required this.items,
    this.leading,
  });
  final List<FilterChipItem> items;
  final Widget? leading;
  final String initialLabel;
  final Color unselectedColor;
  final Color unselectedLabelColor;
  final Color selectedColor;
  final Color selectedLabelColor;
  final Function(String?) onSelectionChanged;
  final double labelPadding;
  @override
  State<FilterChipDropdown> createState() => _FilterChipDropdownState();
}

class _FilterChipDropdownState extends State<FilterChipDropdown> {
  final GlobalKey _chipKey = GlobalKey();
  late String _selectedLabel;
  bool _isSelected = false;
  bool _isDropdownOpen = false;
  double _maxItemWidth = 0;

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.initialLabel;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxItemWidth();
    });
  }

  void _toggleDropdown(bool? value) {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _selectItem(FilterChipItem item) {
    setState(() {
      _selectedLabel = item.label;
      _isSelected = true;
      _isDropdownOpen = false;
    });
    widget.onSelectionChanged(item.value);
  }

  void _clearSelection() {
    setState(() {
      _selectedLabel = widget.initialLabel;
      _isSelected = false;
      _isDropdownOpen = false;
    });
    widget.onSelectionChanged(null);
  }

  void _handleOutsideTap(PointerDownEvent evt) {
    if (_isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  void _showDropdownMenu() {
    final RenderBox chipBox =
        _chipKey.currentContext!.findRenderObject() as RenderBox;
    final position = chipBox.localToGlobal(Offset.zero);
    showMenu(
      color: const Color.fromARGB(255, 255, 251, 238),
      elevation: 4,
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + chipBox.size.height,
        position.dx + chipBox.size.width,
        position.dy + chipBox.size.height,
      ),
      items:
          widget.items.map((item) {
            return PopupMenuItem(value: item, child: Text(item.label));
          }).toList(),
      constraints: BoxConstraints(minWidth: _maxItemWidth),
    ).then((selectedItem) {
      if (selectedItem != null) {
        _selectItem(selectedItem);
      }
    });
  }

  void _calculateMaxItemWidth() {
    double maxWidth = 0.0;
    for (var item in widget.items) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: item.label,
          style: DefaultTextStyle.of(context).style,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth =
          maxWidth < textPainter.width
              ? textPainter.width + 2 * widget.labelPadding
              : maxWidth;
    }

    final chipBox = _chipKey.currentContext?.findRenderObject() as RenderBox?;
    double chipWidth = chipBox?.size.width ?? 0;
    setState(() {
      _maxItemWidth = maxWidth > chipWidth ? maxWidth : chipWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TapRegion(
      onTapOutside: _handleOutsideTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChip.elevated(
            key: _chipKey,
            label: _isSelected ? Text('Selected') : Text(_selectedLabel),
            iconTheme: IconThemeData(
              color:
                  _isSelected
                      ? widget.selectedLabelColor
                      : widget.unselectedLabelColor,
            ),
            labelStyle: TextStyle(
              color:
                  _isSelected
                      ? widget.selectedLabelColor
                      : widget.unselectedLabelColor,
            ),
            backgroundColor:
                _isSelected ? widget.selectedColor : widget.unselectedColor,
            deleteIcon:
                _isSelected
                    ? Icon(Icons.close, color: widget.selectedLabelColor)
                    : Icon(
                      Icons.arrow_drop_down,
                      color: widget.unselectedLabelColor,
                    ),
            onDeleted:
                _isSelected ? _clearSelection : () => _toggleDropdown(false),
            onSelected: (_) => _showDropdownMenu(),
          ),
        ],
      ),
    );
  }
}
