import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final BannerController _bannerController = BannerController();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 232, 232),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: StreamBuilder<List<String>>(
        stream: _bannerController.getBannerUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Banner available'));
          } else {
            print('length: $snapshot.data!.length');

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: snapshot.data!.length,

                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: snapshot.data![index],
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  },
                ),
                _buildPageIndicator(snapshot.data!.length, _currentPage),
              ],
            );
          }
        },
      ),
    );
  }
}

Widget _buildPageIndicator(int pageCount, int currentIndex) {
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: currentIndex == index ? 12 : 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.green : Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
        );
      }),
    ),
  );
}

/** show images in a row to test 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final BannerController _bannerController = BannerController();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 232, 232),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: StreamBuilder<List<String>>(
        stream: _bannerController.getBannerUrls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Banner available'));
          } else {
            print('length: ${snapshot.data!.length}');

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Make the list scroll horizontally
              child: Row(
                children: snapshot.data!.map((imageUrl) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CachedNetworkImage(
                      width: 150, // Set width for each image
                      height: 170, // Set height for each image
                      fit: BoxFit.fill,
                      imageUrl: imageUrl,
                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
*/
