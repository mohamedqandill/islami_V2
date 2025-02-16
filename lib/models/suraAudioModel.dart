class SuraAudioModel {
  SuraAudioModel({
      this.audioFile,});

  SuraAudioModel.fromJson(dynamic json) {
    audioFile = json['audio_file'] != null ? AudioFile.fromJson(json['audio_file']) : null;
  }
  AudioFile? audioFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (audioFile != null) {
      map['audio_file'] = audioFile?.toJson();
    }
    return map;
  }

}

class AudioFile {
  AudioFile({
      this.id, 
      this.chapterId, 
      this.fileSize, 
      this.format, 
      this.audioUrl,});

  AudioFile.fromJson(dynamic json) {
    id = json['id'];
    chapterId = json['chapter_id'];
    fileSize = json['file_size'];
    format = json['format'];
    audioUrl = json['audio_url'];
  }
  int? id;
  int? chapterId;
  double? fileSize;
  String? format;
  String? audioUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['chapter_id'] = chapterId;
    map['file_size'] = fileSize;
    map['format'] = format;
    map['audio_url'] = audioUrl;
    return map;
  }

}