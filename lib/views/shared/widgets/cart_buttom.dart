import 'package:flutter/material.dart';

class ActionButtom extends StatelessWidget {
  final int counterIndicator;
  final Function() onPressed;

  const ActionButtom(
      {Key? key, this.counterIndicator = 0, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Stack(
        alignment: const Alignment(-1, -1),
        children: [
          if (counterIndicator > 0)
            Container(
              child: Center(
                child: Text(
                  counterIndicator.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              constraints: const BoxConstraints(minHeight: 26, minWidth: 26),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red.withOpacity(0.9),
              ),
            ),
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
    );
  }
}
