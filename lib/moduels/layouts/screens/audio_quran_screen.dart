import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_provider.dart';

class QuranPlayer extends StatefulWidget {
  final int id;
  final int chapterId;
  final String suraName;

  const QuranPlayer(
      {required this.suraName,
      required this.id,
      required this.chapterId,
      super.key});

  @override
  _QuranPlayerState createState() => _QuranPlayerState();
}

class _QuranPlayerState extends State<QuranPlayer> {
  late AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  String? audioUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _player.onDurationChanged.listen((newDuration) {
      if (!mounted) return;
      setState(() {
        _duration = newDuration;
      });
    });

    _player.onPositionChanged.listen((newPosition) {
      if (!mounted) return;
      setState(() {
        _duration = newPosition;
      });
    });

    _loadAudioUrl();
  }

  Future<void> _loadAudioUrl() async {
    try {
      var pro = Provider.of<MyProvider>(context, listen: false);
      String url =
          await pro.suraAudio(id: widget.id, chapter: widget.chapterId);

      // التأكد أن الودجت لا يزال موجودًا قبل تحديث حالته
      if (!mounted) return;

      setState(() {
        audioUrl = url.isNotEmpty ? url : null;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return; // تأكيد أن الودجت لا يزال موجودًا

      setState(() {
        audioUrl = null;
        isLoading = false;
      });
      debugPrint("خطأ أثناء تحميل رابط الصوت: $e");
    }
  }

  @override
  void dispose() {
    if (_player.state != PlayerState.stopped) {
      _player.stop();
    }
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return bg_widget(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: pro.mode == ThemeMode.dark ? Colors.white : Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(15.0.sp),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16.0.sp),
              decoration: BoxDecoration(
                color: pro.mode == ThemeMode.dark
                    ? Colors.red.withOpacity(0.5.sp)
                    : Color(0xffB7935F),
                borderRadius: BorderRadius.circular(16.0.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // اسم السورة
                  Text(" سوره ${widget.suraName} ",
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 10.h),

                  // تحميل الصوت
                  if (isLoading)
                    const CircularProgressIndicator()
                  else if (audioUrl == null || audioUrl!.isEmpty)
                    const Text("فشل تحميل الملف الصوتي",
                        style: TextStyle(color: Colors.red))
                  else ...[
                    // شريط التقدم
                    Slider(
                      min: 0.0,
                      max: _duration.inSeconds > 0
                          ? _duration.inSeconds.toDouble()
                          : 1.0,
                      value: _position.inSeconds
                          .toDouble()
                          .clamp(0.0, _duration.inSeconds.toDouble()),
                      onChanged: (value) {
                        _player.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: Colors.green,
                      inactiveColor: Colors.grey.shade300,
                    ),

                    // الوقت المنقضي والإجمالي
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(_position),
                            style: const TextStyle(color: Colors.black)),
                        Text(_formatDuration(_duration),
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // أزرار التحكم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon:
                              Icon(Icons.stop, size: 30.sp, color: Colors.red),
                          onPressed: () async {
                            await _player.stop();
                          },
                        ),
                        SizedBox(width: 20.w),
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Colors.green,
                          child: IconButton(
                            icon: Icon(Icons.play_arrow,
                                size: 35.sp, color: Colors.white),
                            onPressed: () async {
                              if (audioUrl != null && audioUrl!.isNotEmpty) {
                                try {
                                  await _player
                                      .setReleaseMode(ReleaseMode.stop);
                                  await _player.setSourceUrl(audioUrl!);
                                  await _player.resume();
                                } catch (e) {
                                  debugPrint("خطأ أثناء تشغيل الصوت: $e");
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        IconButton(
                          icon: Icon(Icons.pause,
                              size: 30.sp, color: Colors.orange),
                          onPressed: () async {
                            await _player.pause();
                          },
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
