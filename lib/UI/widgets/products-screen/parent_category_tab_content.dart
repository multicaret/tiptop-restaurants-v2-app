import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tiptop_v2/models/category.dart';

import 'child_categories_tabs.dart';
import 'child_category_products.dart';

class ParentCategoryTabContent extends StatefulWidget {
  final List<Category> children;

  ParentCategoryTabContent({@required this.children});

  @override
  _ParentCategoryTabContentState createState() => _ParentCategoryTabContentState();
}

class _ParentCategoryTabContentState extends State<ParentCategoryTabContent> {
  int selectedChildCategoryId;

  AutoScrollController childCategoriesScrollController;
  final childCategoriesScrollDirection = Axis.horizontal;

  AutoScrollController productsScrollController;
  final productsScrollDirection = Axis.horizontal;

  bool scrollIsAtTheTop = true;

  @override
  void initState() {
    childCategoriesScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: childCategoriesScrollDirection,
    );

    productsScrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: childCategoriesScrollDirection,
    )..addListener(() {
        if (productsScrollController.offset == 0) {
          setState(() {
            scrollIsAtTheTop = true;
          });
          scrollSpy(0);
        } else {
          setState(() {
            scrollIsAtTheTop = false;
          });
        }
      });

    selectedChildCategoryId = widget.children[0].id;
    super.initState();
  }

  void scrollToCategoryAndProducts(int index) {
    scrollToCategory(index);
    scrollToProducts(index);
  }

  void scrollToCategory(int index) {
    childCategoriesScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  void scrollToProducts(int index) {
    productsScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  void scrollSpy(int index) {
    setState(() {
      selectedChildCategoryId = widget.children[index].id;
    });
    scrollToCategory(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChildCategoriesTabs(
          children: widget.children,
          itemScrollController: childCategoriesScrollController,
          selectedChildCategoryId: selectedChildCategoryId,
          action: (i) {
            setState(() {
              selectedChildCategoryId = widget.children[i].id;
            });
            scrollToCategoryAndProducts(i);
          },
        ),
        Expanded(
          child: ListView(
            children: List.generate(
              widget.children.length,
              (i) => ChildCategoryProducts(
                index: i,
                child: widget.children[i],
                productsScrollController: productsScrollController,
              ),
            ),
            controller: productsScrollController,
          ),
        )
      ],
    );
  }
}