class RecordsCity {
  String? text;
  String? value;
  String? fullText;

  RecordsCity({this.text, this.value, this.fullText});

  RecordsCity.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
    fullText = json['full_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    data['full_text'] = this.fullText;
    return data;
  }

  List<RecordsCity>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => RecordsCity.fromJson(item)).toList();
  }

  String cityAsString() {
    return '${this.text}';
  }

  String getValue() => this.value!;
}
