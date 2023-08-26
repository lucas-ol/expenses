import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * .15,
            child: FittedBox(
              child: Text(
                'R\$${value.toStringAsFixed(2)}',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          SizedBox(
            height: constraints.maxHeight * .6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      )),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
