import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/step_slide.dart';
import 'package:focuspulse/widgets/home.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  int _currentStep = 0;
  final List<Map<String, String>> _steps = [
    {
      "title": "USE",
      "description": "Choose a task that you need to complete",
      "imagePath": "assets/images/step_use.png",
      "router": "/step_use",
    },
    {
      "title": "FOCUS",
      "description": "Concentrate fully on your work",
      "imagePath": "assets/images/step_focus.png",
      "router": "/step_foucs",
    },
    {
      "title": "BREAK",
      "description": "Take short breaks between test sections",
      "imagePath": "assets/images/step_break.png",
      "router": "/step_break",
    }
  ];

  void _nextStep() {
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    });
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = _steps[_currentStep];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          currentStepData["title"] ?? "",
          style: TextStyle(
            fontFamily: 'space_grotesk',
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      backgroundColor: AppColors.bgWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: StepSlide(
                  key: ValueKey<int>(_currentStep),
                  description: currentStepData["description"] ?? "",
                  imagePath: currentStepData["imagePath"] ?? "",
                  onNext: _nextStep,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Stack(
      //   children: [
      //     Center(
      //       child: AnimatedSwitcher(
      //         duration: const Duration(milliseconds: 500),
      //         transitionBuilder: (child, animation) {
      //           return FadeTransition(
      //             opacity: animation,
      //             child: child,
      //           );
      //         },
      //         child: StepSlide(
      //           key: ValueKey<int>(_currentStep),
      //           title: currentStepData["title"] ?? "",
      //           description: currentStepData["description"] ?? "",
      //           imagePath: currentStepData["imagePath"] ?? "",
      //           onNext: _nextStep,
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       top: 50.h,
      //       left: 15.w,
      //       child: TextButton(
      //         onPressed: _skip,
      //         style: TextButton.styleFrom(
      //           overlayColor: Colors.transparent,
      //         ),
      //         child: Text(
      //           "SKIP",
      //           style: TextStyle(
      //             fontFamily: 'howdy_duck',
      //             fontSize: 16.sp,
      //             color: AppColors.fontbrown,
      //             fontWeight: FontWeight.normal,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
