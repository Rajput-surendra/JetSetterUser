import 'package:eshop_multivendor/Model/User.dart';
import '../Helper/String.dart';

class SectionModel {
  String? id,
      title,
      deliveryCharge,
      varientId,
      qty,
      productId,
      perItemTotal,
      perItemPrice,
      singleItemNetAmount,
       productType,
       singleIteamSubTotal,
      singleItemTaxAmount,
      style,
      sellerId,
      shortDesc;
  double? perItemTaxPriceOnItemsTotal,
      perItemTaxPriceOnItemAmount,
      perItemTaxPercentage = 0.0;
  List<Product>? productList;
  List<Promo>? promoList;
  List<Filter>? filterList;
  List<String>? selectedId = [];
  int? offset, totalItem;

  SectionModel({
    this.id,
    this.title,
    this.shortDesc,
    this.productList,
    this.varientId,
    this.qty,
    this.productId,
    this.perItemTotal,
    this.perItemPrice,
    this.style,
    this.totalItem,
    this.sellerId,
    this.offset,
    this.selectedId,
    this.filterList,
    this.singleItemTaxAmount,
    this.singleItemNetAmount,
    this.singleIteamSubTotal,
    this.promoList,
    this.productType,
    this.deliveryCharge
  });

  factory SectionModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Product> productList = (parsedJson[PRODUCT_DETAIL] as List)
        .map((data) => Product.fromJson(data))
        .toList();

    var flist = (parsedJson[FILTERS] as List?);
    List<Filter> filterList = [];
    if (flist == null || flist.isEmpty) {
      filterList = [];
    } else {
      filterList = flist.map((data) => Filter.fromJson(data)).toList();
    }
    List<String> selected = [];
    return SectionModel(
        id: parsedJson[ID],
        sellerId: parsedJson[SELLER_ID],
        title: parsedJson[TITLE],
        shortDesc: parsedJson[SHORT_DESC],
        style: parsedJson[STYLE],
        productList: productList,
        offset: 0,
        totalItem: 0,
        filterList: filterList,
        selectedId: selected);
  }

  factory SectionModel.fromCart(Map<String, dynamic> parsedJson) {
    List<Product> productList = (parsedJson[PRODUCT_DETAIL] as List)
        .map((data) => Product.fromJson(data))
        .toList();
    return SectionModel(
        id: parsedJson[ID],
        varientId: parsedJson[PRODUCT_VARIENT_ID],
        qty: parsedJson[QTY],
        sellerId: parsedJson['product_details'][0]['seller_id'].toString(),
        perItemTotal: '0',
        perItemPrice: '0',
        productList: productList,
        singleItemNetAmount: parsedJson['net_amount'],
        productType: parsedJson["type"],
        singleIteamSubTotal: parsedJson['sub_total'].toString(),
        singleItemTaxAmount: parsedJson['tax_amount'].toString());

         deliveryCharge: parsedJson['delivery_charge'];
  }

  factory SectionModel.fromFav(Map<String, dynamic> parsedJson) {
    List<Product> productList = (parsedJson[PRODUCT_DETAIL] as List)
        .map((data) => Product.fromJson(data))
        .toList();

    return SectionModel(
        id: parsedJson[ID],
        productId: parsedJson[PRODUCT_ID],
        sellerId: parsedJson[SELLER_ID],
        productList: productList);
  }
}

class Product {
  String? id,
      name,
      desc,
      image,
      seller_Address,
      catName,
      type,
      rating,
      noOfRating,
      attrIds,
      tax,
      categoryId,
      shortDescription,
      codAllowed,
      brandName,
      sliderId,
      sku,
      brandImage,
      brandId,
      qtyStepSize;
  List<String>? itemsCounter;
  List<String>? otherImage;
  List<Product_Varient>? prVarientList;
  List<Attribute>? attributeList;
  List<String>? selectedId = [];
  List<String>? tagList = [];
  int? minOrderQuntity;
  String? isFav,
      isReturnable,
      isCancelable,
      isPurchased,
      availability,
      madein,
      indicator,
      stockType,
      cancleTill,
      total,
      banner,
      totalAllow,
      video,
      videType,
      warranty,
      gurantee,
      is_attch_req;
  String? minPrice, maxPrice;
  String? totalImg;
  List<ReviewImg>? reviewList;


  bool? isFavLoading = false, isFromProd = false;
  int? offset, totalItem, selVarient;

  List<Product>? subList;
  List<Filter>? filterList;
  bool? history = false;
  String? store_description,
      seller_rating,
      noOfRatingsOnSeller,
      seller_profile,
      seller_name,
      seller_id,
      store_name,
      seller_address,
      totalProductsOfSeller;
  Product({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.catName,
    this.type,
    this.otherImage,
    this.prVarientList,
    this.attributeList,
    this.isFav,
    this.isCancelable,
    this.isReturnable,
    this.isPurchased,
    this.availability,
    this.noOfRating,
    this.attrIds,
    this.selectedId,
    this.rating,
    this.seller_Address,
    this.isFavLoading,
    this.indicator,
    this.madein,
    this.tax,
    this.shortDescription,
    this.total,
    this.brandName,
    this.sliderId,
    this.sku,
    this.brandImage,
    this.brandId,
    this.categoryId,
    this.subList,
    this.filterList,
    this.stockType,
    this.isFromProd,
    this.cancleTill,
    this.totalItem,
    this.offset,
    this.totalAllow,
    this.banner,
    this.selVarient,
    this.video,
    this.videType,
    this.tagList,
    this.warranty,
    this.qtyStepSize,
    this.minOrderQuntity,
    this.itemsCounter,
    this.reviewList,
    this.history,
    this.minPrice,
    this.maxPrice,
    this.totalProductsOfSeller,
    this.codAllowed,
    this.gurantee,
    this.store_description,
    this.seller_address,
    this.seller_rating,
    this.noOfRatingsOnSeller,
    this.seller_profile,
    this.seller_name,
    this.seller_id,
    this.store_name,
    this.is_attch_req,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<Product_Varient> varientList = (json[PRODUCT_VARIENT] as List)
        .map((data) => Product_Varient.fromJson(data))
        .toList();

    List<Attribute> attList = (json[ATTRIBUTES] as List)
        .map((data) => Attribute.fromJson(data))
        .toList();

    var flist = (json[FILTERS] as List?);
    List<Filter> filterList = [];
    if (flist == null || flist.isEmpty) {
      filterList = [];
    } else {
      filterList = flist.map((data) => Filter.fromJson(data)).toList();
    }

    List<String> otherImage = List<String>.from(json[OTHER_IMAGE]);
    List<String> selected = [];

    List<String> tags = List<String>.from(json[TAG]);
    List<String> items = List<String>.generate(

        json[TOTALALOOW] != null && json[TOTALALOOW] != ''
            ? double.parse(json[TOTALALOOW]) ~/ double.parse(json[QTYSTEP])
            : 10, (i) {
      return ((i + 1) * int.parse(json[QTYSTEP])).toString();
    });

    var reviewImg = (json[REV_IMG] as List?);
    List<ReviewImg> reviewList = [];
    if (reviewImg == null || reviewImg.isEmpty) {
      reviewList = [];
    } else {
      reviewList = reviewImg.map((data) => ReviewImg.fromJson(data)).toList();
    }

    return Product(
      id: json[ID],
      name: json[NAME],
      desc: json[DESC],
      image: json[IMAGE],
      catName: json[CAT_NAME],
      rating: json[RATING],
      seller_Address: json["store_url"],
      noOfRating: json[NO_OF_RATE],
      type: json[TYPE],
      isFav: json[FAV].toString(),
      isCancelable: json[ISCANCLEABLE],
      availability: json[AVAILABILITY].toString(),
      isPurchased: json[ISPURCHASED].toString(),
      isReturnable: json[ISRETURNABLE],
      otherImage: otherImage,
      prVarientList: varientList,
      attributeList: attList,
      filterList: filterList,
      isFavLoading: false,
      selVarient: 0,
      attrIds: json[ATTR_VALUE],
      madein: json[MADEIN],
      shortDescription: json[SHORT],
      indicator: json[INDICATOR].toString(),
      stockType: json[STOCKTYPE].toString(),
      tax: json[TAX_PER],
      total: json[TOTAL],
      categoryId: json[CATID],
      selectedId: selected,
      totalAllow: json[TOTALALOOW],
      cancleTill: json[CANCLE_TILL],
      video: json[VIDEO],
      videType: json[VIDEO_TYPE],
      tagList: tags,
      itemsCounter: items,
      warranty: json[WARRANTY],
      minOrderQuntity: int.parse(json[MINORDERQTY]),
      qtyStepSize: json[QTYSTEP],
      gurantee: json[GAURANTEE],
      reviewList: reviewList,
      history: false,
      minPrice: json[MINPRICE],
      maxPrice: json[MAXPRICE],
      seller_name: json[SELLER_NAME],
      seller_profile: json[SELLER_PROFILE],
      seller_rating: json[SELLER_RATING],
      store_description: json[STORE_DESC],
      totalProductsOfSeller: json['total_products'] ?? '',
      store_name: json[STORE_NAME],
      seller_id: json[SELLER_ID],
      is_attch_req: json[IS_ATTACH_REQ],
      codAllowed: json[COD_ALLOWED],
      brandName: json[ProductBrandName],
      sliderId: json['url'],
      sku : json[ProductSku],
      brandImage: json[ProductBrandImage],
      brandId: json[ProductBrandID],
    );
  }

  factory Product.all(String name, String img, cat) {
    return Product(name: name, catName: cat, image: img, history: false);
  }

  factory Product.history(String history) {
    return Product(name: history, history: true);
  }

  factory Product.fromSeller(Map<String, dynamic> json) {
    return Product(
      seller_name: json[SELLER_NAME],
      seller_profile: json[SELLER_PROFILE],
      seller_rating: json[SELLER_RATING],
      noOfRatingsOnSeller: json[NO_OF_RATE],
      seller_address: json['store_url'],
      store_description: json[STORE_DESC],
      store_name: json[STORE_NAME],
      totalProductsOfSeller: json['total_products'],
      seller_id: json[SELLER_ID],
      sliderId: json['url'],
    );
  }

  factory Product.fromCat(Map<String, dynamic> parsedJson) {
    return Product(
      id: parsedJson[ID],
      name: parsedJson[NAME],
      image: parsedJson[IMAGE],
      banner: parsedJson[BANNER],
      isFromProd: false,
      offset: 0,
      totalItem: 0,
      tax: parsedJson[TAX],
      subList: createSubList(
        parsedJson['children'],
      ),
    );
  }

  factory Product.popular(String name, String image) {
    return Product(name: name, image: image);
  }

  static List<Product>? createSubList(List? parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) return null;

    return parsedJson.map((data) => Product.fromCat(data)).toList();
  }
}

class Product_Varient {
  String? id,
      productId,
      attribute_value_ids,
      price,
      disPrice,
      type,
      attr_name,
      varient_value,
      availability,
      cartCount;
  List<String>? images;

  Product_Varient({
    this.id,
    this.productId,
    this.attr_name,
    this.varient_value,
    this.price,
    this.disPrice,
    this.attribute_value_ids,
    this.availability,
    this.cartCount,
    this.images,
  });

  factory Product_Varient.fromJson(Map<String, dynamic> json) {
   // List<String> images = List<String>.from(json[IMAGES]);

    return Product_Varient(
      id: json[ID],
      attribute_value_ids: json[ATTRIBUTE_VALUE_ID],
      productId: json[PRODUCT_ID],
      attr_name: json[ATTR_NAME],
      varient_value: json[VARIENT_VALUE],
      disPrice: json[DIS_PRICE],
      price: json[PRICE],
      availability: json[AVAILABILITY].toString(),
      cartCount: json[CART_COUNT],
      images: []
        //json['images'] !=[] ?  (json['images'] as List).map((item) => item as String).toList() :  null
    );
  }
}

class Attribute {
  String? id, value, name, sType, sValue;

  Attribute({this.id, this.value, this.name, this.sType, this.sValue});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json[IDS],
      name: json[NAME],
      value: json[VALUE],
      sType: json[STYPE],
      sValue: json[SVALUE],
    );
  }
}

class Filter {
  String? attributeValues, attributeValId, name, swatchType, swatchValue;

  Filter({
    this.attributeValues,
    this.attributeValId,
    this.name,
    this.swatchType,
    this.swatchValue,
  });

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      attributeValId: json[ATT_VAL_ID],
      name: json[NAME],
      attributeValues: json[ATT_VAL],
      swatchType: json[STYPE],
      swatchValue: json[SVALUE],
    );
  }
}

class ReviewImg {
  String? totalImg;
  List<User>? productRating;

  ReviewImg({this.totalImg, this.productRating});

  factory ReviewImg.fromJson(Map<String, dynamic> json) {
    var reviewImg = (json[PRODUCTRATING] as List?);
    List<User> reviewList = [];
    if (reviewImg == null || reviewImg.isEmpty) {
      reviewList = [];
    } else {
      reviewList = reviewImg.map((data) => User.forReview(data)).toList();
    }

    return ReviewImg(
      totalImg: json[TOTALIMG],
      productRating: reviewList,
    );
  }
}

class Promo {
  String? id,
      promoCode,
      message,
      image,
      remainingDays,
      status,
      noOfRepeatUsage,
      maxDiscountAmt,
      discountType,
      noOfUsers,
      minOrderAmt,
      repeatUsage,
      discount,
      endDate,
      isInstantCashback,
      startDate;
  bool isExpanded;

  Promo({
    this.id,
    this.promoCode,
    this.message,
    this.startDate,
    this.endDate,
    this.discount,
    this.repeatUsage,
    this.minOrderAmt,
    this.noOfUsers,
    this.discountType,
    this.maxDiscountAmt,
    this.image,
    this.noOfRepeatUsage,
    this.status,
    this.remainingDays,
    this.isInstantCashback,
    this.isExpanded = false,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json[ID],
      promoCode: json[PROMO_CODE],
      message: json[MESSAGE],
      image: json[IMAGE],
      remainingDays: json[REMAIN_DAY],
      discount: json[DISCOUNT],
      discountType: json[DISCOUNT_TYPE],
      endDate: json[END_DATE],
      maxDiscountAmt: json[MAX_DISCOUNT_AMOUNT],
      minOrderAmt: json[MIN_ORDER_AMOUNT],
      noOfRepeatUsage: json[NO_OF_REPEAT_USAGE],
      noOfUsers: json[NO_OF_USERS],
      repeatUsage: json[REPEAT_USAGE],
      startDate: json[START_DATE],
      isInstantCashback: json[INSTANT_CASHBACK],
      status: json[STATUS],
    );
  }
}



// class Product_Varient {
//   String? id;
//   String? productId;
//   String? attributeValueIds;
//   String? attributeSet;
//   String? price;
//   String? specialPrice;
//   String? sku;
//   String? stock;
//   String? weight;
//   String? height;
//   String? breadth;
//   String? length;
//   List<String>? images;
//   int? availability;
//   String? status;
//   String? dateAdded;
//   String? variantIds;
//   String? attrName;
//   String? variantValues;
//   String? swatcheType;
//   String? swatcheValue;
//   List<String>? variantRelativePath;
//   List<String>? imagesMd;
//   List<String>? imagesSm;
//   String? cartCount;
//   int? isPurchased;
//
//   Product_Varient(
//       {this.id,
//         this.productId,
//         this.attributeValueIds,
//         this.attributeSet,
//         this.price,
//         this.specialPrice,
//         this.sku,
//         this.stock,
//         this.weight,
//         this.height,
//         this.breadth,
//         this.length,
//         this.images,
//         this.availability,
//         this.status,
//         this.dateAdded,
//         this.variantIds,
//         this.attrName,
//         this.variantValues,
//         this.swatcheType,
//         this.swatcheValue,
//         this.variantRelativePath,
//         this.imagesMd,
//         this.imagesSm,
//         this.cartCount,
//         this.isPurchased});
//
//   Product_Varient.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     attributeValueIds = json['attribute_value_ids'];
//     attributeSet = json['attribute_set'];
//     price = json['price'];
//     specialPrice = json['special_price'];
//     sku = json['sku'];
//     stock = json['stock'];
//     weight = json['weight'];
//     height = json['height'];
//     breadth = json['breadth'];
//     length = json['length'];
//     images = json['images'].cast<String>();
//     availability = json['availability'];
//     status = json['status'];
//     dateAdded = json['date_added'];
//     variantIds = json['variant_ids'];
//     attrName = json['attr_name'];
//     variantValues = json['variant_values'];
//     swatcheType = json['swatche_type'];
//     swatcheValue = json['swatche_value'];
//     variantRelativePath = json['variant_relative_path'].cast<String>();
//     imagesMd = json['images_md'].cast<String>();
//     imagesSm = json['images_sm'].cast<String>();
//     cartCount = json['cart_count'];
//     isPurchased = json['is_purchased'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['attribute_value_ids'] = this.attributeValueIds;
//     data['attribute_set'] = this.attributeSet;
//     data['price'] = this.price;
//     data['special_price'] = this.specialPrice;
//     data['sku'] = this.sku;
//     data['stock'] = this.stock;
//     data['weight'] = this.weight;
//     data['height'] = this.height;
//     data['breadth'] = this.breadth;
//     data['length'] = this.length;
//     data['images'] = this.images;
//     data['availability'] = this.availability;
//     data['status'] = this.status;
//     data['date_added'] = this.dateAdded;
//     data['variant_ids'] = this.variantIds;
//     data['attr_name'] = this.attrName;
//     data['variant_values'] = this.variantValues;
//     data['swatche_type'] = this.swatcheType;
//     data['swatche_value'] = this.swatcheValue;
//     data['variant_relative_path'] = this.variantRelativePath;
//     data['images_md'] = this.imagesMd;
//     data['images_sm'] = this.imagesSm;
//     data['cart_count'] = this.cartCount;
//     data['is_purchased'] = this.isPurchased;
//     return data;
//   }
// }
