import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/widgets/bg_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/my_provider.dart';

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
  String? url;

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
        _position = newPosition;
      });
    });

    _loadAudioUrl();
  }

  Future<void> _loadAudioUrl() async {
    try {
      var pro = Provider.of<MyProvider>(context, listen: false);
      url = await pro.suraAudio(id: widget.id, chapter: widget.chapterId);

      // التأكد أن الودجت لا يزال موجودًا قبل تحديث حالته
      if (!mounted) return;

      setState(() {
        audioUrl = url!.isNotEmpty ? url : null;
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

  double progres = 0.0;
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
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
                              icon: Icon(Icons.stop,
                                  size: 30.sp, color: Colors.red),
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
                                  if (audioUrl != null &&
                                      audioUrl!.isNotEmpty) {
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
            SizedBox(
              height: 10.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200.w, 60.h),
                  backgroundColor: pro.mode == ThemeMode.dark
                      ? Color(0xff141A2E)
                      : Color(0xffB7935F),
                ),
                onPressed: () async {
                  downloadAudio(
                      url: url!, fileName: "سوره ${widget.suraName}ه");
                },
                child: Text(
                  'download'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Slider(
              min: 0.0,
              max: 100.0,
              value: progres,
              onChanged: null,
              activeColor: Colors.green,
              inactiveColor: Colors.grey.shade300,
            ),
          ],
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

  Future<String> getDocumentsPath() async {
    Directory? directory = await getExternalStorageDirectory();
    String newPath =
        "${directory?.path}/Documents"; // حفظ الملفات داخل Documents
    return newPath;
  }

  downloadAudio({required String url, required String fileName}) async {
    // Use .download to start a download and wait for it to complete

// define the download task (subset of parameters shown)
    String downloadPath = await getDocumentsPath();
    debugPrint(downloadPath);
    final task = DownloadTask(
        url: url,
        urlQueryParameters: {'q': 'pizza'},
        filename: fileName,
        headers: {'myHeader': 'value'},
        directory: downloadPath,
        updates: Updates.statusAndProgress,
        // request status and progress updates
        requiresWiFi: true,
        retries: 5,
        allowPause: true,
        metaData: 'data for me');

// Start download, and wait for result. Show progress and status changes
// while downloading
    final result = await FileDownloader().download(task,
        onProgress: (progress) {
          print('Progress: ${progress * 100}%');
          progres = progress;
        },
        onStatus: (status) => print('Status: $status'));
    FileDownloader().configureNotification(
        running:
            TaskNotification('Downloading', 'file: سوره ${widget.suraName}'),
        complete: TaskNotification(
            'Download finished', 'file: سوره ${widget.suraName}'),
        progressBar: true);

// Act on the result
    switch (result.status) {
      case TaskStatus.complete:
        print('Success!');

      case TaskStatus.canceled:
        print('Download was canceled');

      case TaskStatus.paused:
        print('Download was paused');

      default:
        print('Download not successful');
    }
  }
}
