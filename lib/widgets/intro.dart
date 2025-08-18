import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/step_slide.dart';
import 'package:focuspulse/models/clear_audio_cache.dart';
import 'package:focuspulse/widgets/entry_point.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _StepsState();
}

class _StepsState extends State<Intro> {
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

  @override
  void initState() {
    super.initState();
    clearAudioCache();
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EntryPoint(),
          ),
        );
      }
    });
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const EntryPoint(),
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
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _skip(),
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
          padding: EdgeInsets.symmetric(vertical: 20.0.h),
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
    );
  }
}
