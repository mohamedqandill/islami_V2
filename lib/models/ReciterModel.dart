class ReciterModel {
  ReciterModel({
      this.recitations,});

  ReciterModel.fromJson(dynamic json) {
    if (json['recitations'] != null) {
      recitations = [];
      json['recitations'].forEach((v) {
        recitations?.add(Recitations.fromJson(v));
      });
    }
  }
  List<Recitations>? recitations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (recitations != null) {
      map['recitations'] = recitations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Recitations {
  Recitations({
      this.id, 
      this.reciterName, 
      this.style, 
      this.translatedName,});

  Recitations.fromJson(dynamic json) {
    id = json['id'];
    reciterName = json['reciter_name'];
    style = json['style'];
    translatedName = json['translated_name'] != null ? TranslatedName.fromJson(json['translated_name']) : null;
  }
  int? id;
  String? reciterName;
  String? style;
  TranslatedName? translatedName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['reciter_name'] = reciterName;
    map['style'] = style;
    if (translatedName != null) {
      map['translated_name'] = translatedName?.toJson();
    }
    return map;
  }

}

class TranslatedName {
  TranslatedName({
      this.name, 
      this.languageName,});

  TranslatedName.fromJson(dynamic json) {
    name = json['name'];
    languageName = json['language_name'];
  }
  String? name;
  String? languageName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['language_name'] = languageName;
    return map;
  }

}