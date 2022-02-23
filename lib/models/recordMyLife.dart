// ignore_for_file: file_names

class RecordMyLife {
  
  int? id;  
  // sqllite datatype에서 datetime이 없으므로, string으로 변환하여 저장할것!!
  String? date;
  double? lng;
  double? lat;
  String? memo;

  RecordMyLife({this.id, this.date, this.lng, this.lat, this.memo});

  factory  RecordMyLife.fromJson(Map<String, dynamic> json) {
    return RecordMyLife(
    id: json['id'],
    date: json['date'],
    lng: json['lng'],
    lat: json['lat'],
    memo: json['memo']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['lng'] = lng;
    data['lat'] = lat;
    data['memo'] = memo;
    return data;
  }

  @override
  String toString() {
      return "$id,$date,$lng,$lat,$memo";
  }

  // dog를 Map으로 변환합니다. key는 데이터베이스 컬럼 명과 동일해야 합니다.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'lng': lng,
      'lat': lat,
      'memo': memo,
    };
  }
}