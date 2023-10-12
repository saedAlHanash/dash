library easy_autocomplete;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qareeb_dash/core/widgets/auto_complete/widgets/filterable_list.dart';
import 'package:qareeb_models/global.dart';

class EasyAutocomplete<T> extends StatefulWidget {
  /// The list of suggestions to be displayed
  final List<SpinnerItem>? suggestions;

  /// Fetches list of suggestions from a Future
  final Future<List<SpinnerItem>> Function(SpinnerItem searchValue)? asyncSuggestions;

  /// Text editing controller
  final TextEditingController? controller;

  /// Can be used to decorate the input
  final InputDecoration decoration;

  /// Function that handles the submission of the input
  final Function(SpinnerItem)? onSubmitted;

  /// Can be used to set custom inputFormatters to field
  final List<TextInputFormatter> inputFormatter;

  /// Can be used to set the textfield initial value
  final SpinnerItem? initialValue;

  /// Can be used to set the text capitalization type
  final TextCapitalization textCapitalization;

  /// Determines if should gain focus on screen open
  final bool autofocus;

  /// Can be used to set different keyboardTypes to your field
  final TextInputType keyboardType;

  /// Can be used to manage TextField focus
  final FocusNode? focusNode;

  /// Can be used to set a custom color to the input cursor
  final Color? cursorColor;

  /// Can be used to set custom style to the suggestions textfield
  final TextStyle inputTextStyle;

  /// Can be used to set custom style to the suggestions list text
  final TextStyle suggestionTextStyle;

  /// Can be used to set custom background color to suggestions list
  final Color? suggestionBackgroundColor;

  /// Used to set the debounce time for async data fetch
  final Duration debounceDuration;

  /// Can be used to customize suggestion items
  final Widget Function(SpinnerItem data)? suggestionBuilder;

  /// Can be used to display custom progress idnicator
  final Widget? progressIndicatorBuilder;

  /// Can be used to validate field value
  final SpinnerItem? Function(SpinnerItem?)? validator;

  /// Creates a autocomplete widget to help you manage your suggestions
  const EasyAutocomplete(
      {super.key,
      this.suggestions,
      this.asyncSuggestions,
      this.suggestionBuilder,
      this.progressIndicatorBuilder,
      this.controller,
      this.decoration = const InputDecoration(),
      this.onSubmitted,
      this.inputFormatter = const [],
      this.initialValue,
      this.autofocus = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.cursorColor,
      this.inputTextStyle = const TextStyle(),
      this.suggestionTextStyle = const TextStyle(),
      this.suggestionBackgroundColor,
      this.debounceDuration = const Duration(milliseconds: 400),
      this.validator})
      : assert(!(controller != null && initialValue != null),
            'controller and initialValue cannot be used at the same time'),
        assert(
            suggestions != null && asyncSuggestions == null ||
                suggestions == null && asyncSuggestions != null,
            'suggestions and asyncSuggestions cannot be both null or have values at the same time');

  @override
  State<EasyAutocomplete> createState() => _EasyAutocompleteState();
}

class _EasyAutocompleteState extends State<EasyAutocomplete> {
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _controller;
  bool _hasOpenedOverlay = false;
  bool _isLoading = false;
  OverlayEntry? _overlayEntry;
  List<SpinnerItem> _suggestions = [];
  Timer? _debounce;
  SpinnerItem _previousAsyncSearchText = SpinnerItem();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue?.name ?? '');
    _controller.addListener(() {
      updateSuggestions(SpinnerItem(name: _controller.text));
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        openOverlay();
      } else {
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            closeOverlay();
          },
        );
      }
    });
  }

  void openOverlay() {
    if (_overlayEntry == null) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      var size = renderBox.size;
      var offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry ??= OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5.0,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 5.0),
            child: FilterableList(
                loading: _isLoading,
                suggestionBuilder: widget.suggestionBuilder,
                progressIndicatorBuilder: widget.progressIndicatorBuilder,
                items: _suggestions,
                suggestionTextStyle: widget.suggestionTextStyle,
                suggestionBackgroundColor: widget.suggestionBackgroundColor,
                onItemTapped: (value) {

                  _controller.value = TextEditingValue(
                      text: value.name??'',
                      selection: TextSelection.collapsed(offset: value.name?.length??0));
                  widget.onSubmitted?.call(value);
                  closeOverlay();
                  _focusNode.unfocus();
                  _controller.text = value.name??'';
                }),
          ),
        ),
      );
    }
    if (!_hasOpenedOverlay) {
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _hasOpenedOverlay = true);
    }
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      _overlayEntry!.remove();
      setState(() {
        _previousAsyncSearchText = SpinnerItem();
        _hasOpenedOverlay = false;
      });
    }
  }

  Future<void> updateSuggestions(
    SpinnerItem input,
  ) async {
    rebuildOverlay();
    if (widget.suggestions != null) {
      _suggestions
        ..clear()
        ..addAll(widget.suggestions!.where((e) {
          if (e.isSelected) {
            _controller.text = e.name??'';
          }
          return (e.name?.toLowerCase().contains(input.name?.toLowerCase()??'')??false);
        }).toList());

      rebuildOverlay();
    } else if (widget.asyncSuggestions != null) {
      setState(() => _isLoading = true);
      if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
      _debounce = Timer(widget.debounceDuration, () async {
        if (_previousAsyncSearchText.hashCode != input.hashCode ||
            (_previousAsyncSearchText.name?.isEmpty??false) ||
            (input.name?.isEmpty??false)) {
          _suggestions = await widget.asyncSuggestions!(input);
          setState(() {
            _isLoading = false;
            _previousAsyncSearchText = input;
          });
          rebuildOverlay();
        }
      });
    }
  }

  void rebuildOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: widget.decoration,
                controller: _controller,
                inputFormatters: widget.inputFormatter,
                autofocus: widget.autofocus,
                focusNode: _focusNode,
                textCapitalization: widget.textCapitalization,
                keyboardType: widget.keyboardType,
                cursorColor: widget.cursorColor ?? Colors.blue,
                style: widget.inputTextStyle,
              )
            ]));
  }

  @override
  void dispose() {
    if (_overlayEntry != null) _overlayEntry!.dispose();
    if (widget.controller == null) {
      _controller.removeListener(() {
        updateSuggestions(SpinnerItem(name: _controller.text));
      });
      _controller.dispose();
    }
    if (_debounce != null) _debounce?.cancel();
    if (widget.focusNode == null) {
      _focusNode.removeListener(() {
        if (_focusNode.hasFocus) {
          openOverlay();
        } else {
          closeOverlay();
        }
      });
      _focusNode.dispose();
    }
    super.dispose();
  }
}
