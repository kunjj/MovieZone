import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../../../../core/utils/dimens.dart';
import '../../../../core/utils/styles.dart';
import 'app_inkwell.dart';
import 'app_text_field.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String labelText;
  final void Function(T?) onItemSelected;
  final dynamic selectedItem;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final bool showSearchBox;
  final double? dropdownHeight;
  final TextStyle? itemTextStyle;
  final Color? selectedItemBackgroundColor;
  final VoidCallback? onEmptyItems;
  final bool showClearIcon;
  final bool isMandatory;
  final bool isEnable;
  final String Function(T) itemLabel;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.itemLabel,
    this.selectedItem,
    required this.labelText,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.black,
    this.borderRadius = Dimens.space2xSmall,
    this.showSearchBox = true,
    this.dropdownHeight,
    this.itemTextStyle,
    this.selectedItemBackgroundColor,
    this.onEmptyItems,
    this.showClearIcon = true,
    this.isMandatory = false,
    this.isEnable = true,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool _isDropdownOpen = false;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    if (widget.selectedItem != null) {
      _textController.text = widget.selectedItem.toString();
    }
    _filteredItems = List.from(widget.items);
  }

  @override
  void didUpdateWidget(CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedItem != oldWidget.selectedItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _textController.text = widget.selectedItem.toString();
          });
        }
      });
    }

    if (_isDropdownOpen && widget.items != oldWidget.items) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _filteredItems = List.from(widget.items);
          _overlayEntry?.markNeedsBuild();
        }
      });
    }
  }

  void _filterList(String query) {
    if (_overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _filteredItems = widget.items.where((item) {
          final itemLabel = widget.itemLabel.call(item);
          return itemLabel.toLowerCase().contains(_searchController.text.toLowerCase());
        }).toList();
        setState(() => _overlayEntry?.markNeedsBuild());
      });
    }
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
      FocusScope.of(context).unfocus();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (widget.items.isEmpty) {
      widget.onEmptyItems?.call();
      return;
    }

    _searchController.clear();
    _filteredItems = List.from(widget.items);

    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isDropdownOpen = true);
    }
  }

  void _closeDropdown() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() => _isDropdownOpen = false);
      }
    }
  }

  void _resetSelection() {
    setState(() {
      _textController.text = '';
    });
    widget.onItemSelected(null);
    _closeDropdown();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    final double screenHeight = MediaQuery.of(context).size.height;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    final double spaceBelow = screenHeight - position.dy - size.height;
    const double itemHeight = Dimens.spaceSmall * 2 + Dimens.space3xMedium;
    final double searchBoxHeight = widget.showSearchBox ? Dimens.textFieldHeightLarge : 0;

    double contentHeight = (_filteredItems.length * itemHeight) + searchBoxHeight;

    double maxHeight = widget.dropdownHeight ?? MediaQuery.of(context).size.height * Dimens.bottomSheetMedium;

    double dropdownHeight = math.min(contentHeight, maxHeight);

    final bool showAbove = spaceBelow < dropdownHeight && position.dy > spaceBelow;

    if (showAbove) {
      dropdownHeight = math.min(dropdownHeight, position.dy - 10);
    } else {
      dropdownHeight = math.min(dropdownHeight, spaceBelow - 10);
    }

    final Offset offset = showAbove ? Offset(0, -dropdownHeight - 5) : Offset(0, size.height + 5);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerDown: (_) => _closeDropdown(),
              onPointerMove: (_) => _closeDropdown(),
              child: Container(color: AppColors.transparent),
            ),
          ),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: offset,
              child: Material(
                elevation: Dimens.space4xSmall,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Container(
                  height: dropdownHeight,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: Dimens.space2xSmall,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showSearchBox)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Dimens.space2xSmall,
                              top: Dimens.space2xSmall,
                              right: Dimens.space2xSmall,
                              bottom: Dimens.space4xSmall),
                          child: AppTextField(
                            hintText: 'Search',
                            textEditingController: _searchController,
                            prefix: const Icon(Icons.search, size: Dimens.iconSmall),
                            textChanged: _filterList,
                          ),
                        ),
                      Expanded(
                        child: _filteredItems.isEmpty
                            ? Center(
                                child: Text(
                                  'No Data Found',
                                  style: AppFontTextStyles.textStyleMedium(),
                                ),
                              )
                            : Scrollbar(
                                trackVisibility: true,
                                thumbVisibility: true,
                                controller: _scrollController,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.only(bottom: Dimens.space2xSmall),
                                  itemCount: _filteredItems.length,
                                  shrinkWrap: true,
                                  itemBuilder: (_, index) {
                                    final item = _filteredItems[index];
                                    final label = widget.itemLabel.call(item);
                                    final isSelected = widget.selectedItem == item;

                                    return AppInkWell(
                                      onTap: () {
                                        if (mounted) {
                                          widget.onItemSelected(item);
                                          _closeDropdown();
                                        }
                                      },
                                      child: Container(
                                        color: isSelected
                                            ? widget.selectedItemBackgroundColor ?? AppColors.secondaryGrey1
                                            : AppColors.transparent,
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: Dimens.spaceXMedium, vertical: Dimens.spaceSmall),
                                        child: Text(
                                          label,
                                          style: widget.itemTextStyle ??
                                              AppFontTextStyles.textStyleMedium().copyWith(
                                                color: isSelected ? AppColors.primaryBlue1 : AppColors.black,
                                                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                                              ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _closeDropdown();
    _scrollController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isDropdownOpen && ModalRoute.of(context)?.isCurrent == false) {
        _closeDropdown();
      }
    });

    return CompositedTransformTarget(
      link: _layerLink,
      child: AppTextField(
        enabled: widget.isEnable,
        isMandatory: widget.isMandatory,
        onTap: _toggleDropdown,
        readOnly: true,
        onTapOutside: () => FocusManager.instance.primaryFocus?.unfocus(),
        textEditingController: _textController,
        labelText: widget.labelText,
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (widget.selectedItem != null && widget.showClearIcon)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _resetSelection,
              ),
            Icon(
              _isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
            ),
            const Gap(Dimens.spaceSmall)
          ],
        ),
      ),
    );
  }
}
