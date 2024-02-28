/// error : false
/// message : "Seller retrieved successfully"
/// total : "1"
/// data : [{"seller_id":"75","seller_name":"Suhas Uttam Mali","email":"suhasmali8@gmail.com","mobile":"9977257959","slug":"aaisaheb-khanaval-1","seller_rating":"0.00","no_of_ratings":"0","store_name":"Aaisaheb Khanaval","store_url":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","store_description":"Khanawal","seller_profile":"https://jetsetterindia.com/uploads/seller/2023-03-302.jpg","balance":"0"}]

class GetSellerModel {
  GetSellerModel({
      bool? error, 
      String? message, 
      String? total, 
      List<SellerListData>? data,}){
    _error = error;
    _message = message;
    _total = total;
    _data = data;
}

  GetSellerModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SellerListData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  dynamic _total;
  List<SellerListData>? _data;
GetSellerModel copyWith({  bool? error,
  String? message,
  dynamic total,
  List<SellerListData>? data,
}) => GetSellerModel(  error: error ?? _error,
  message: message ?? _message,
  total: total ?? _total,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  dynamic get total => _total;
  List<SellerListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// seller_id : "75"
/// seller_name : "Suhas Uttam Mali"
/// email : "suhasmali8@gmail.com"
/// mobile : "9977257959"
/// slug : "aaisaheb-khanaval-1"
/// seller_rating : "0.00"
/// no_of_ratings : "0"
/// store_name : "Aaisaheb Khanaval"
/// store_url : "Vijay Nagar, Indore, Madhya Pradesh 452010, India"
/// store_description : "Khanawal"
/// seller_profile : "https://jetsetterindia.com/uploads/seller/2023-03-302.jpg"
/// balance : "0"

class SellerListData {
  SellerListData({
      String? sellerId, 
      String? sellerName, 
      String? email, 
      String? mobile, 
      String? slug, 
      String? sellerRating, 
      String? noOfRatings, 
      String? storeName, 
      String? storeUrl, 
      String? storeDescription, 
      String? sellerProfile, 
      String? balance,}){
    _sellerId = sellerId;
    _sellerName = sellerName;
    _email = email;
    _mobile = mobile;
    _slug = slug;
    _sellerRating = sellerRating;
    _noOfRatings = noOfRatings;
    _storeName = storeName;
    _storeUrl = storeUrl;
    _storeDescription = storeDescription;
    _sellerProfile = sellerProfile;
    _balance = balance;
}

  SellerListData.fromJson(dynamic json) {
    _sellerId = json['seller_id'];
    _sellerName = json['seller_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _slug = json['slug'];
    _sellerRating = json['seller_rating'];
    _noOfRatings = json['no_of_ratings'];
    _storeName = json['store_name'];
    _storeUrl = json['store_url'];
    _storeDescription = json['store_description'];
    _sellerProfile = json['seller_profile'];
    _balance = json['balance'];
  }
  String? _sellerId;
  String? _sellerName;
  String? _email;
  String? _mobile;
  String? _slug;
  String? _sellerRating;
  String? _noOfRatings;
  String? _storeName;
  String? _storeUrl;
  String? _storeDescription;
  String? _sellerProfile;
  String? _balance;
SellerListData copyWith({  String? sellerId,
  String? sellerName,
  String? email,
  String? mobile,
  String? slug,
  String? sellerRating,
  String? noOfRatings,
  String? storeName,
  String? storeUrl,
  String? storeDescription,
  String? sellerProfile,
  String? balance,
}) => SellerListData(  sellerId: sellerId ?? _sellerId,
  sellerName: sellerName ?? _sellerName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  slug: slug ?? _slug,
  sellerRating: sellerRating ?? _sellerRating,
  noOfRatings: noOfRatings ?? _noOfRatings,
  storeName: storeName ?? _storeName,
  storeUrl: storeUrl ?? _storeUrl,
  storeDescription: storeDescription ?? _storeDescription,
  sellerProfile: sellerProfile ?? _sellerProfile,
  balance: balance ?? _balance,
);
  String? get sellerId => _sellerId;
  String? get sellerName => _sellerName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get slug => _slug;
  String? get sellerRating => _sellerRating;
  String? get noOfRatings => _noOfRatings;
  String? get storeName => _storeName;
  String? get storeUrl => _storeUrl;
  String? get storeDescription => _storeDescription;
  String? get sellerProfile => _sellerProfile;
  String? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seller_id'] = _sellerId;
    map['seller_name'] = _sellerName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['slug'] = _slug;
    map['seller_rating'] = _sellerRating;
    map['no_of_ratings'] = _noOfRatings;
    map['store_name'] = _storeName;
    map['store_url'] = _storeUrl;
    map['store_description'] = _storeDescription;
    map['seller_profile'] = _sellerProfile;
    map['balance'] = _balance;
    return map;
  }

}