import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _bannerImages = [];

  Future<void> getBanner() async {
    try {
      final snapshot = await _firestore.collection("banners").get();
      final images =
          snapshot.docs
              .map((doc) => doc['image'] as String?)
              .where((url) => url != null && url.isNotEmpty)
              .toList();

      print("Fetched Images: $images");

      setState(() {
        _bannerImages.addAll(images.cast<String>());
      });
    } catch (e) {
      print("Error fetching banners: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: MediaQuery.of(context).size.width,
      child:
          _bannerImages.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : PageView.builder(
                itemCount: _bannerImages.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    _bannerImages[index],
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Center(child: Text('Image failed to load')),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
    );
  }
}
