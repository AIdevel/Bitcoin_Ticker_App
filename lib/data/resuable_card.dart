import 'package:flutter/material.dart';

class ResuableCard extends StatefulWidget {
  const ResuableCard(
      {super.key, required this.rate,
      required this.selectedCurrency,
      required this.currentCurrency});

  final double rate;
  final String selectedCurrency;
  final String currentCurrency;

  @override
  _ResuableCardState createState() => _ResuableCardState();
}

class _ResuableCardState extends State<ResuableCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 18.0, 15.0, 0),
      child: Card(
        color: Colors.lightBlue,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28.0),
          child: Text(
            '1 ${widget.currentCurrency} = ${widget.rate.toStringAsFixed(2)} ${widget.selectedCurrency}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
