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
    final List<Map<String, dynamic>> result = _sessions.map((session) {
      final label = session['label'];
      final score = _controllers[label]?.text ?? '';
      return {
        'label': label,
        'duration': session['duration'],
        'score': score,
      };
    }).toList();

    print('TestKey: $_testKey');
    print('Result: $result');

    // You can navigate or use Riverpod to store this
    Navigator.pop(context, result); // Or return result
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
    print('$_sessions, $_testKey');

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
              Text(_sessions.toString()),
              Text(_testKey),
            ],
          ),
        ));
  }
}
