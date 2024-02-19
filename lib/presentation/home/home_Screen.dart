import 'package:flutter/material.dart';
import 'package:migu/presentation/views/home_view.dart';
import 'package:migu/presentation/views/vet_view.dart';
import 'package:migu/widgets/shared/custom_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

final viewRoutes=const [
  HomeView(),
  // SizedBox(),
  VetView()
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex:pageIndex),
    );
  }
}
