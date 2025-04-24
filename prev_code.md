Stack(
alignment: Alignment.center,
children: [
isTimerPlaying
? IconButton(
onPressed: startTimer,
icon: Icon(
Icons.pause_circle,
size: 100.w,
color: AppColors.timerbrown,
),
)
: IconButton(
onPressed: stopTimer,
icon: Icon(
Icons.play_circle,
size: 100.w,
color: AppColors.timerbrown,
),
),
Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Padding(
padding: EdgeInsets.only(top: 80.h),
child: Column(
children: [
Text(
'STEP-Session1',
style: TextStyle(
fontFamily: 'howdy_duck',
fontSize: 20.sp,
color: AppColors.timerbrown,
),
),
Text(
curTime,
style: TextStyle(
fontFamily: 'howdy_duck',
fontSize: 64.sp,
color: AppColors.timerbrown,
),
),
isTimerPlaying
? Image.asset(
'assets/gifs/heartrate.gif',
width: 100.w,
)
: SvgPicture.asset(
'assets/svg/heartbeat.svg',
width: 100.w,
),
],
),
),
Container(
height: 152.h,
decoration: BoxDecoration(
color: AppColors.timerbrown,
borderRadius: BorderRadius.circular(20.r),
),
child: Padding(
padding: EdgeInsets.symmetric(vertical: 18.h),
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
SvgPicture.asset(
'assets/svg/music.svg',
width: 20.w,
height: 20.h,
),
SizedBox(width: 10.w),
TextButton(
onPressed: () {
isMusicPlaying
? pauseAudio(ref, _audioPlayer)
: playAudio(ref, _audioPlayer);
},
style: TextButton.styleFrom(
padding: EdgeInsets.zero,
minimumSize: const Size(0, 0),
tapTargetSize:
MaterialTapTargetSize.shrinkWrap,
),
child: Text(
noise,
style: TextStyle(
fontFamily: 'howdy_duck',
fontSize: 14.sp,
color: AppColors.bgTimer,
),
textAlign: TextAlign.center,
),
),
SizedBox(width: 10.w),
isMusicPlaying
? Image.asset(
'assets/gifs/playing.gif',
width: 20.w,
height: 20.h,
fit: BoxFit.cover,
)
: SizedBox(width: 20.w, height: 20.h),
],
),
ClipRRect(
borderRadius: BorderRadius.circular(2),
child: Container(
width: ScreenUtil().screenWidth \* 0.9,
height: 2.w,
color: Colors.white,
),
),
Text(
"Next step",
style: TextStyle(
fontFamily: 'howdy_duck',
fontSize: 14.sp,
color: AppColors.bgTimer,
),
textAlign: TextAlign.center,
),
],
),
),
),
),
],
),
),
],
),
