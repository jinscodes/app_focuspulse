import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focuspulse/colors.dart';
import 'package:focuspulse/models/load_sound_list.dart';
import 'package:focuspulse/widgets/sound_details.dart';

class SoundList extends ConsumerStatefulWidget {
  const SoundList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SoundListState();
}

class _SoundListState extends ConsumerState<SoundList> {
  String _searchQuery = '';

  void onClickItem(String soundKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SoundDetails(
          soundKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.w),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sounds',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: "space_grotesk",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.bgGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              FutureBuilder(
                future: loadSoundList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final soundSettings = snapshot.data!;
                  final filteredList = _searchQuery.isEmpty
                      ? soundSettings
                      : soundSettings
                          .where((item) => item['key']
                              .toString()
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                          .toList();
                  if (filteredList.isEmpty) {
                    return const Center(child: Text('No results found.'));
                  }
                  return SizedBox(
                    height: 600.h,
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final key = filteredList[index]['key']!;
                        return Theme(
                          data: Theme.of(context).copyWith(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            minTileHeight: 56.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            leading: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.bgGray,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/svg/speaker.svg',
                                    width: 16.w,
                                    height: 16.h,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              key.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 24.w,
                              color: Colors.grey,
                            ),
                            onTap: () => onClickItem(key),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
