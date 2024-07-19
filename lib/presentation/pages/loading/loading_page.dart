import 'package:auto_route/auto_route.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((r) {
      if (FirebaseAuth.instance.currentUser != null) {
        context.router
            .pushAndPopUntil(const ChatListRoute(), predicate: (r) => false);
      } else {
        context.router
            .pushAndPopUntil(const LoginRoute(), predicate: (r) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child:
          LoadingAnimationWidget.fourRotatingDots(color: Colors.blue, size: 48),
    ));
  }
}
