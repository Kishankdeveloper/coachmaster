import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return w < 600 ? mobileTabWidget(h, w) : webWidget(h, w);
  }

  Widget webWidget(var h, var w) {
    return Container(
      height: 50,
      width: w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [   Colors.blue,
            Colors.blueAccent,
            Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10,),
              const AutoSizeText(
                'Designed and Developed by ',
                style: TextStyle(
                  fontFamily: 'madaSemiBold',
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('assets/images/cris-logo.png', color: Colors.white,),
              )
            ],
          ),
          const AutoSizeText(
            'Last updated on: 22/08/2025 11:43',
            style: TextStyle(
              fontFamily: 'madaSemiBold',
              color: Colors.white,
            ),
          ),
          const AutoSizeText(
            '2025 © Ministry of Railways, India. All Rights Reserved    ',
            style: TextStyle(
              fontFamily: 'madaSemiBold',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileTabWidget(var h, var w) {
    return Container(
      height: 70,
      width: w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [   Colors.blue,
            Colors.blueAccent,
            Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AutoSizeText(
            'Last updated on: 22/08/2025 11:43',
            style: TextStyle(
              fontFamily: 'madaSemiBold',
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5,),
          const AutoSizeText(
            '2025 © Ministry of Railways, India. All Rights Reserved    ',
            style: TextStyle(
              fontFamily: 'madaSemiBold',
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AutoSizeText(
                'Designed and Developed by ',
                style: TextStyle(
                  fontFamily: 'madaSemiBold',
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10,),
              Image.asset('assets/images/cris-logo.png',height: 30,width: 40, color: Colors.white,),
            ],
          ),
        ],
      ),
    );
  }
}
