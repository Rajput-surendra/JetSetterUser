/// error : false
/// data : [{"id":"10","type":"default","type_id":"0","slider_show_type":"1","link":"","image":"https://alphawizzserver.com/jozzby_bazar_new/uploads/media/2023/Electronics.png","date_added":"2023-08-26 19:31:21","data":[]}]

class GetImagesModel {
  GetImagesModel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  GetImagesModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
GetImagesModel copyWith({  bool? error,
  List<Data>? data,
}) => GetImagesModel(  error: error ?? _error,
  data: data ?? _data,
);
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "10"
/// type : "default"
/// type_id : "0"
/// slider_show_type : "1"
/// link : ""
/// image : "https://alphawizzserver.com/jozzby_bazar_new/uploads/media/2023/Electronics.png"
/// date_added : "2023-08-26 19:31:21"
/// data : []

class Data {
  Data({
      String? id, 
      String? type, 
      String? typeId, 
      String? sliderShowType, 
      String? link, 
      String? image, 
      String? dateAdded, 
      List<dynamic>? data,}){
    _id = id;
    _type = type;
    _typeId = typeId;
    _sliderShowType = sliderShowType;
    _link = link;
    _image = image;
    _dateAdded = dateAdded;
    _data = data;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeId = json['type_id'];
    _sliderShowType = json['slider_show_type'];
    _link = json['link'];
    _image = json['image'];
    _dateAdded = json['date_added'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v.fromJson(v));
      });
    }
  }
  String? _id;
  String? _type;
  String? _typeId;
  String? _sliderShowType;
  String? _link;
  String? _image;
  String? _dateAdded;
  List<dynamic>? _data;
Data copyWith({  String? id,
  String? type,
  String? typeId,
  String? sliderShowType,
  String? link,
  String? image,
  String? dateAdded,
  List<dynamic>? data,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  typeId: typeId ?? _typeId,
  sliderShowType: sliderShowType ?? _sliderShowType,
  link: link ?? _link,
  image: image ?? _image,
  dateAdded: dateAdded ?? _dateAdded,
  data: data ?? _data,
);
  String? get id => _id;
  String? get type => _type;
  String? get typeId => _typeId;
  String? get sliderShowType => _sliderShowType;
  String? get link => _link;
  String? get image => _image;
  String? get dateAdded => _dateAdded;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['slider_show_type'] = _sliderShowType;
    map['link'] = _link;
    map['image'] = _image;
    map['date_added'] = _dateAdded;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}