import 'package:flutter/material.dart';

import '../../../core/utils/utils_import.dart';
import 'app_inkwell.dart';
import 'app_loader.dart';
import 'app_text_field.dart';
import 'container_decoration.dart';
import 'empty_list_view.dart';

class SearchTextField<T> extends StatefulWidget {
  final void Function(T) onItemTapEvent;
  final Function() onTextChange;
  final String searchText;
  final List<T> itemList;
  final double maxHeight;
  final String Function(T)? itemLabel;
  final TextEditingController controller;
  final bool isLoading;

  const SearchTextField(
      {super.key,
      this.maxHeight = Dimens.containerXMedium,
      required this.onItemTapEvent,
      required this.searchText,
      required this.itemList,
      this.itemLabel,
      required this.controller,
      required this.onTextChange,
      required this.isLoading});

  @override
  State<SearchTextField<T>> createState() => _SearchTextFieldState<T>();
}

class _SearchTextFieldState<T> extends State<SearchTextField<T>> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _textFieldKey = GlobalKey();
  late List<T> _filteredItemList;
  StateSetter? _setStateOverlay;
  late FocusNode _focusNode;
  Offset? _lastPosition;

  @override
  void initState() {
    super.initState();
    _filteredItemList = List<T>.from(widget.itemList);
    widget.controller.addListener(_updateOverlay);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusEvent);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _trackTextFieldPosition());
  }

  @override
  void didUpdateWidget(covariant SearchTextField<T> oldWidget) {
    if (oldWidget.isLoading != widget.isLoading) {
      _updateOverlay();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _trackTextFieldPosition() {
    if (_textFieldKey.currentContext != null) {
      RenderBox renderBox =
          _textFieldKey.currentContext!.findRenderObject() as RenderBox;
      Offset newPosition = renderBox.localToGlobal(Offset.zero);

      if (_lastPosition == null || _lastPosition != newPosition) {
        _lastPosition = newPosition;
        _updateOverlayPosition();
      }
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _trackTextFieldPosition());
  }

  void _updateOverlay() {
    if (widget.controller.text.length == 2) {
      _filterList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showOverlay();
        if (_setStateOverlay != null) {
          _setStateOverlay!(() {});
        }
      });
    } else if (widget.controller.text.length > 2) {
      _filterList();
      if (_overlayEntry == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_setStateOverlay != null) {
          _setStateOverlay!(() {});
        }
      });
    } else {
      if (_overlayEntry == null) return;
      _removeOverlay();
    }
  }

  void _updateOverlayPosition() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null || _textFieldKey.currentContext == null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox =
        _textFieldKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double width = renderBox.size.width;

    return OverlayEntry(
        builder: (_) => StatefulBuilder(builder: (_, setState) {
              _setStateOverlay = setState;
              return Positioned(
                  left: offset.dx,
                  top: offset.dy + renderBox.size.height,
                  width: width,
                  child: _OverLayView(
                      maxHeight: widget.maxHeight,
                      filteredItemList: _filteredItemList,
                      onItemTapEvent: (item) {
                        widget.onItemTapEvent(item);

                        _removeOverlay();
                      },
                      isLoading: widget.isLoading,
                      itemLabel: widget.itemLabel));
            }));
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _setStateOverlay = null;
  }

  _onTapEvent() {
    if (widget.controller.text.length > 2 && widget.itemList.isNotEmpty) {
      _filterList();
      WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    }
  }

  _filterList() => _filteredItemList = widget.itemList.where((item) {
        final itemLabel = widget.itemLabel?.call(item);
        return itemLabel != null &&
            itemLabel
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase());
      }).toList();

  void _onFocusEvent() =>
      (!_focusNode.hasFocus) ? _removeOverlay() : _onTapEvent();

  @override
  void dispose() {
    super.dispose();
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      key: _textFieldKey,
      textEditingController: widget.controller,
      isLoading: widget.isLoading,
      labelText: widget.searchText,
      suffixIconType: TextFieldSuffixIconType.cancel,
      textChanged: (_) => widget.onTextChange(),
      onTap: () => _onTapEvent(),
      focusNode: _focusNode,
    );
  }
}

class _OverLayView<T> extends StatelessWidget {
  final double maxHeight;
  final List<T> filteredItemList;
  final String Function(T)? itemLabel;
  final void Function(T) onItemTapEvent;
  final bool isLoading;

  _OverLayView(
      {super.key,
      required this.maxHeight,
      required this.filteredItemList,
      this.itemLabel,
      required this.onItemTapEvent,
      required this.isLoading});

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: Dimens.elevationLarge,
      borderRadius: BorderRadius.circular(Dimens.radius2xSmall),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: maxHeight),
            decoration: ContainerDecoration(radius: Dimens.radius2xSmall),
            child: filteredItemList.isEmpty
                ? Center(
                    child: isLoading
                        ? const AppLoader()
                        : const EmptyListView(message: 'No Data Found'))
                : Scrollbar(
                    trackVisibility: true,
                    thumbVisibility: true,
                    interactive: true,
                    controller: scrollController,
                    child: ListView.separated(
                        shrinkWrap: true,
                        controller: scrollController,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (_, index) {
                          final item = filteredItemList[index];
                          final label = itemLabel?.call(item) ?? '';
                          return _ItemView(
                              onChanged: () => onItemTapEvent(item),
                              itemLabel: label);
                        },
                        itemCount: filteredItemList.length,
                        separatorBuilder: (_, __) => const Divider(
                            thickness: Dimens.borderWidthXSmall,
                            height: Dimens.dividerThicknessSmall,
                            color: AppColors.dividerColor)),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ItemView extends StatelessWidget {
  final Function() onChanged;
  final String itemLabel;

  const _ItemView({
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.spaceSmall, vertical: Dimens.space3xSmall),
        child: Text(
          itemLabel,
          overflow: TextOverflow.visible,
          style: AppFontTextStyles.textStyleMedium()
              .copyWith(fontSize: Dimens.fontSizeSixteen),
        ),
      ),
    );
  }
}
