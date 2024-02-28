
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/Color.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../Model/Get_seller_model.dart';
import '../../Model/Section_Model.dart';
import '../../Provider/homePageProvider.dart';
import '../../widgets/appBar.dart';
import '../Dashboard/Dashboard.dart';
import '../Language/languageSettings.dart';
import '../homePage/homepageNew.dart';
import 'Seller_Details.dart';
import 'package:http/http.dart'as http;

class SellerList extends StatefulWidget {
  String? catId,sellerId,catIdBySeller;
   SellerList({Key? key,this.catId}) : super(key: key);

  @override
  State<SellerList> createState() => _SellerListState();
}

class _SellerListState extends State<SellerList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSeller("");
   // getSellerApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getSimpleAppBar(
          getTranslated(context, 'Restaurants List')!, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // filter(),
            getSellerList()

          ],
        ),
      ),
    );
  }

  int _currentIndex = 3 ;
  filter(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 1;
                  getSeller('veg');

                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 1 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                height: 30,
                width: 70,
                child: Center(
                  child: Text("Pure Veg",style: TextStyle(color: _currentIndex == 1 ?colors.whiteTemp:colors.blackTemp,fontSize: 15)),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 2;
                  getSeller('non-veg');
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 2 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                // width: 120,
                height: 30,
                child: Center(
                  child: Text("Non Veg",style: TextStyle(color: _currentIndex == 2 ?colors.whiteTemp:colors.blackTemp,fontSize: 15),),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: InkWell(
              onTap: (){
                setState(() {
                  _currentIndex = 3;
                  getSeller('both');
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 3 ?
                    colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                // width: 120,
                height: 30,
                child: Center(
                  child: Text("Veg & Non Veg",style: TextStyle(color: _currentIndex == 3 ?colors.whiteTemp:colors.blackTemp,fontSize: 15),),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  // late Future<GetSellerModel?> getSellerModel;
  //  getSellerApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=65cfe6e888e78404943314ad2b5ef9bc49a2ee33'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('https://jetsetterindia.com/app/v1/api/get_sellers'));
  //   request.fields.addAll({
  //     'lat': '22.746927',
  //     'lang': '75.8980634',
  //     'cat_id':widget.catId.toString()
  //   });
  //   print('____Som___lat___${request.fields}_________');
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print('____Som______${response.statusCode}_________');
  //     var result = await response.stream.bytesToString();
  //     var finalResult = GetSellerModel.fromJson(jsonDecode(result));
  //     print('____Som___finalResult___${finalResult}_________');
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }
  void getSeller(String status) {
    Map parameter = {
      LATITUDE: homelat.toString(),
      LONGITUDE: homeLong.toString(),
      CAT_ID:widget.catId.toString()

    };
    print('_____parameter__ssssssssssss___${parameter}_____${getSellerApi}____');
    // if (_controller.text != '') {
    //   parameter = {
    //     SEARCH: _controller.text.trim(),
    //   };
    // }

    sellerList.clear();
    apiBaseHelper.postAPICall(getSellerListApi, parameter).then(

          (getdata) {
        bool error = getdata['error'];
        String? msg = getdata['message'];
        List<Product> tempSellerList = [];
        //tempSellerList.clear();
        if (!error) {
          totalSelletCount = int.parse(getdata['total']);
          var data = getdata['data'];
          log('${getdata['data']}');
          setState(() {});
          tempSellerList = (data as List).map((data) => Product.fromSeller(data)).toList();
          sellerListOffset += perPage;

        } else {
          //setSnackbar1("No Restaurant Found!!!",);
        }
        sellerList.addAll(tempSellerList);
        context.read<HomePageProvider>().setSellerLoading(false);
        // for(var i=0;i<sellerList.length;i++){
        //
        // }

        setState(() {});
      },
      onError: (error) {
        //setSnackbar1(error.toString());
        context.read<HomePageProvider>().setSellerLoading(false);
      },
    );

    setState(() {});
  }
  String? s_id;
  int sellerListOffset = 0;
  int totalSelletCount = 0;
  String? seller_id;
  String? sellerImage;
  String? sellerStoreName,sellerRating,storeDesc;
  List<Product> sellerList = [];
  getSellerList(){
    return    Container(

      child:sellerList == "" ? Center(child: CircularProgressIndicator()): sellerList.length == 0 ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("Restaurant Not Found!! ")),
      ): ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:sellerList.length,
          itemBuilder: (c,i){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(onTap: (){

                setState(() {
                  s_id = sellerList[i].seller_id;
                });

                seller_id = sellerList[i].seller_id;
                sellerImage =sellerList[i].seller_profile;
                sellerStoreName =sellerList[i].store_name;
                sellerRating = sellerList[i].seller_rating;
                storeDesc = sellerList[i].store_description;
                //
                Navigator.push(

                  context,
                  CupertinoPageRoute(
                    builder: (context) => SellerProfile(totalProductsOfSeller: '',
                      s_id:s_id,sellerImage: sellerImage,sellerStoreName:sellerStoreName,
                      sellerRating: sellerRating,storeDesc: storeDesc,sellerName: sellerList[i].store_name,isSellerDis: sellerList[i].store_description,
                      isSellerRatting: sellerList[i].seller_rating,isSeller: true,



                    ),
                  ),
                );

              },
                child: Container(
                    decoration: BoxDecoration(
                        color:colors.whiteTemp,
                        border: Border.all(color: colors.black12),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: 165,
                    height: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: colors.blackTemp)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network("${sellerList[i].seller_profile}",fit: BoxFit.fill,)),
                        ),
                        const SizedBox(height:15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Center(child: Text("${sellerList[i].store_name}",overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)),
                                    ],
                                  ),
                                  SizedBox(height: 5,),


                                ],),

                              Text("${sellerList[i].store_description}",

                                // overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Icon(Icons.star,color: Colors.green,size: 16,),
                                  SizedBox(width: 3,),
                                  Text("${sellerList[i].seller_rating}",overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              )
                            ],
                          ),
                        )




                      ],
                    )
                ),
              ),
            );
          }),
    );


  }
}
