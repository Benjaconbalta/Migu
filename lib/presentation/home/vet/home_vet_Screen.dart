import 'package:flutter/material.dart';
import 'package:migu/presentation/views/vet/patient_view.dart';
import 'package:migu/presentation/views/vet/profile_view.dart';
import 'package:migu/widgets/shared/custom_bottom_navigation.dart';
import 'package:migu/widgets/shared/custom_bottom_vet.dart';


class HomeVetScreen extends StatelessWidget {
  final int pageIndex;
  const HomeVetScreen({super.key,required this.pageIndex});

  final viewRoutes = const [
    PatientView(),
    // SizedBox(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomVet(currentIndex:pageIndex ),
    );
  }
}