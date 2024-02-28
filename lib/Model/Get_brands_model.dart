/// error : false
/// data : [{"id":"1","name":"Mondal Enterprise","slug":"mondal-enterprise","image":"uploads/media/2023/download_(25).jpg","status":"1"},{"id":"2","name":"Darshit","slug":"darshit","image":"uploads/media/2023/download_(30).jpg","status":"1"},{"id":"3","name":"Rasmoni","slug":"rasmoni","image":"uploads/media/2023/images_(9).jpg","status":"1"},{"id":"4","name":"Sawan Shakya","slug":"sawan-shakya","image":"sawan1@mailinator.com","status":"1"},{"id":"5","name":"Sawan Shakya","slug":"sawan-shakya-1","image":"sawan1@mailinator.com","status":"1"},{"id":"6","name":"Surendra","slug":"surendra","image":"surendra@mailinator.com","status":"1"},{"id":"7","name":"vdgdehey","slug":"vdgdehey","image":"ttttt@gmail.com","status":"1"},{"id":"8","name":"Sawan sir","slug":"sawan-sir","image":"surendra@gmail.com","status":"1"},{"id":"9","name":"surendra","slug":"surendra-1","image":"test@gmail.com","status":"1"},{"id":"10","name":"surendra","slug":"surendra-2","image":"raj@gamil.com","status":"1"},{"id":"11","name":"rajat","slug":"rajat","image":"rajatpirramba28@gmail.com","status":"1"},{"id":"12","name":"surendra Rajpoot aira","slug":"surendra-rajpoot-aira","image":"rajpoot@gmail.com","status":"1"},{"id":"13","name":"piyush jain","slug":"piyush-jain","image":"piyush.alphawizz059@gmail.com","status":"1"},{"id":"14","name":"wasim","slug":"wasim","image":"wasim@gmail.com","status":"1"},{"id":"15","name":"shivani happy birthday to you","slug":"shivani-happy-birthday-to-you","image":"rajuraja@gmail.com","status":"1"},{"id":"18","name":"avdesh jain","slug":"avdesh-jain","image":"av@gmail.com","status":"1"},{"id":"19","name":"Premium Toys","slug":"premium-toys","image":"uploads/media/2023/download_(2).jpeg","status":"1"},{"id":"20","name":"Prestige","slug":"prestige","image":"uploads/media/2023/Prestige-Xclusive-Franchise-Logo.png","status":"1"},{"id":"21","name":"VKC","slug":"vkc","image":"uploads/media/2023/17-171212_vkc-footwear-hd-png-download.png","status":"1"}]

class GetBrandsModel {
  GetBrandsModel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  GetBrandsModel.fromJson(dynamic json) {
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
GetBrandsModel copyWith({  bool? error,
  List<Data>? data,
}) => GetBrandsModel(  error: error ?? _error,
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

/// id : "1"
/// name : "Mondal Enterprise"
/// slug : "mondal-enterprise"
/// image : "uploads/media/2023/download_(25).jpg"
/// status : "1"

class Data {
  Data({
      String? id, 
      String? name, 
      String? slug, 
      String? image, 
      String? status,}){
    _id = id;
    _name = name;
    _slug = slug;
    _image = image;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _image = json['image'];
    _status = json['status'];
  }
  String? _id;
  String? _name;
  String? _slug;
  String? _image;
  String? _status;
Data copyWith({  String? id,
  String? name,
  String? slug,
  String? image,
  String? status,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  image: image ?? _image,
  status: status ?? _status,
);
  String? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get image => _image;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image'] = _image;
    map['status'] = _status;
    return map;
  }

}