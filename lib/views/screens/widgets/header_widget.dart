import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Stack(
        children: [
          Image.asset(
            'assets/icons/searchBanner.jpeg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 48,
            top: 68,
            child: SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Text",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.white),

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 17,
                  ),
                  prefixIcon: Image.asset('assets/icons/search.png'),
                  suffixIcon: Image.asset('assets/icons/cam.png'),
                  fillColor: Colors.grey.shade600,
                  filled: true,
                  focusColor: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: 311,
            top: 80,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/bell.png'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Positioned(
            left: 375,
            top: 78,

            child: Material(
              type: MaterialType.transparency,
              child: Ink(
                width: 31,
                height: 31,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icons/message.png'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
