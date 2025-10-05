import 'package:ecommerce_app/core/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TPrimaryHeaderContainer(child: Center(child: Text('Home Screen'),),),
    );
  }
}