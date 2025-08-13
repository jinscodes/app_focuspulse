import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/components/title_appbar.dart';
import 'package:focuspulse/models/adManager.dart';
import 'package:focuspulse/models/remove_result.dart';
import 'package:focuspulse/models/retrieve_result.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  List<Map<String, Map<String, dynamic>>> _historyList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });

    AdManager.instance.loadInterstitialAdWithCooldown(
      onAdShown: () {
        _loadPrefs();
      },
      onAdSkipped: () {
        _loadPrefs();
      },
      onError: (error) {
        print('Ad error: $error');
        _loadPrefs();
      },
    );
  }

  Future<void> _loadPrefs() async {
    final data = await retrieveResult();
    setState(() {
      _historyList = data;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: titleAppbar(context, null, "History"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _historyList.isEmpty
                ? const Center(child: Text('No history available.'))
                : ListView.builder(
                    itemCount: _historyList.length,
                    itemBuilder: (context, index) {
                      final recordMap = _historyList[index];
                      final recordKey = recordMap.keys.first;
                      final recordValue = recordMap[recordKey]!;

                      final String test = recordValue['test'];
                      final String date = recordValue['date'];
                      final List<dynamic> results = recordValue['result'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                test,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'space_grotesk',
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          'Delete Record',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "space_grotesk",
                                          ),
                                        ),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this record?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "space_grotesk",
                                        ),
                                      ),
                                      actions: [
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                minimumSize:
                                                    Size(0.32.sw, 40.h),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                minimumSize:
                                                    Size(0.32.sw, 40.h),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                              ),
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true) {
                                    setState(() {
                                      _historyList.removeAt(index);
                                    });
                                    removeData(recordKey);
                                  }
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  size: 24.w,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            date.substring(0, 10),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'space_grotesk',
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ...results.map((item) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['label'],
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'space_grotesk',
                                      ),
                                    ),
                                    Text(
                                      item['score'].toString(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'space_grotesk',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24.h),
                              ],
                            );
                          }),
                          const Divider(
                            color: AppColors.borderGray,
                            thickness: 1,
                          ),
                          SizedBox(height: 24.h),
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
