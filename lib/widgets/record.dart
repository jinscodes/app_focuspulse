import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';

class RecordScreen extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> sessions;
  final String testKey;

  const RecordScreen({
    super.key,
    required this.sessions,
    required this.testKey,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecordState();
}

class _RecordState extends ConsumerState<RecordScreen> {
  late List<Map<String, dynamic>> _sessions;
  late String _testKey;
  List<Map<String, dynamic>> result = [];
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _sessions = widget.sessions;
    _testKey = widget.testKey;
    for (var session in _sessions) {
      _controllers[session['label']] = TextEditingController();
    }
  }

  void _onSave() {
    Map finalResult = {};
    final List<Map<String, dynamic>> result = _sessions.map((session) {
      final label = session['label'];
      final score = _controllers[label]?.text ?? '';
      return {
        'label': label,
        'score': score,
      };
    }).toList();

    finalResult.addAll({'test': _testKey, "result": result});

    print('record: $finalResult');

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close_outlined, size: 24.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Record',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _sessions.length,
                separatorBuilder: (_, __) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final session = _sessions[index];
                  final label = session['label'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'space_grotesk',
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _controllers[label],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Score',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'space_grotesk',
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: AppColors.borderGray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                onPressed: _onSave,
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space_grotesk',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
