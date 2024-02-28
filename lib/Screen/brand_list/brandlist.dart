import 'dart:convert';

import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/Screen/Dashboard/Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/Constant.dart';
import '../../Model/Get_brands_model.dart';
import '../ProductList&SectionView/ProductList.dart';
import '../homePage/homepageNew.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  String? brandId,brandName, brandImage;
  GetBrandsModel? getBrandsModel;
  getBrandApi() async {
    var headers = {
      'Cookie': 'ci_session=b458202437d40c57fd9d5ea22c70e00ddc4d2723'
    };
    var request = http.MultipartRequest('GET', Uri.parse('$baseUrl/get_brand'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult =  GetBrandsModel.fromJson(jsonDecode(result));
      setState(() {
        getBrandsModel = finalResult;

        for(var i=0;i<getBrandsModel!.data!.length;i++){
          brandId = getBrandsModel!.data![i].id;


        }
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBrandApi();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary1,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:colors.whiteTemp,
        title: Text('All Brand List',style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
        leading: InkWell(
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
            },
            child: Icon(Icons.arrow_back,color: colors.blackTemp,)),
      ),
      body: GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio:1,
            crossAxisSpacing:0,
          mainAxisSpacing:5,
        ),
        itemCount: getBrandsModel?.data?.length,
        itemBuilder: (context, index) {
            return    Padding(
              padding: const EdgeInsets.only(left: 10.0,right:10,top:20),
              child: InkWell(
                onTap: () async {

                  setState(() {
                    brandId =   getBrandsModel!.data![index].id;
                    brandName = getBrandsModel?.data?[index].name;
                    brandImage = getBrandsModel?.data?[index].image;
                  });
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString('brand_name', brandName!);
                  print('brandName------kkkk------------${getBrandsModel!.data![index].name}__________');

                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ProductList(getBrand: true, brandId: brandId,brandName: brandName,),
                    ),
                  );

                },
                child: Container(
                    decoration: BoxDecoration(
                        color:Color(0xffEFEFEF),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: 140,
                    height: 155,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 110,
                            width: double.infinity,
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                child:getBrandsModel?.data?[index].image==null||getBrandsModel?.data?[index].image==""?Image.asset('assets/images/png/placeholder.png'): Image.network("$imageUrl${getBrandsModel?.data?[index].image}",fit: BoxFit.fill,))),
                        const SizedBox(height:10,),
                        Container(
                            width: 90,
                            child: Center(child: Text("${getBrandsModel?.data?[index].name}",overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold),))),

                      ],
                    )
                ),
              ),
            );
          },),
    );
  }
}
