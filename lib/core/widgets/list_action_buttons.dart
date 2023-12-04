import 'package:flutter/cupertino.dart';

class ListActionButtons extends StatefulWidget {
  const ListActionButtons({super.key});

  @override
  State<ListActionButtons> createState() => _ListActionButtonsState();
}

class _ListActionButtonsState extends State<ListActionButtons>
    with SingleTickerProviderStateMixin {
  var loading = false;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
