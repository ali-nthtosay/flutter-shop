import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/category_controller.dart';
import 'package:get/get.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 7,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _categoryController.categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Image.network(
                      _categoryController.categories[index].categoryImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Text(_categoryController.categories[index].categoryName),
                  ],
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
