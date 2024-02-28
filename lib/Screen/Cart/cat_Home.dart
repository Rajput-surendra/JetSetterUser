import 'dart:convert';

import 'package:eshop_multivendor/Helper/Constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../../Model/Seller_by_model.dart';
import '../../widgets/appBar.dart';
import '../Language/languageSettings.dart';
import '../SellerDetail/Seller_Details.dart';
import '../SellerDetail/seller_list.dart';


class CatHomeSrreen extends StatefulWidget {
   CatHomeSrreen({Key? key,this.sID,this.rating,this.sImage,this.sName,this.sDis,this.sellerAddress}) : super(key: key);
  String? sID,sName,sImage,rating,sDis,sellerAddress;
  @override
  State<CatHomeSrreen> createState() => _CatHomeSrreenState();
}

class _CatHomeSrreenState extends State<CatHomeSrreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getSimpleAppBar(
          getTranslated(context, 'Categories')!, context),
      body: sellerByCatModel == null ? Center(child: CircularProgressIndicator()): sellerByCatModel?.data?.isEmpty ?? false ? Center(child: Text("No category found!!")) :Container(

          child: ListView.builder(
              shrinkWrap: true,
              itemCount: sellerByCatModel?.data?.length ?? 0 ,
              itemBuilder: (context,index){
                return


                  InkWell(
                    onTap: (){
                       print('____Som___sDis___${widget.sDis}_________');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerProfile(
                        sId:widget.sID,catId:sellerByCatModel?.data?[index].id,isCatBy: true,
                        sellerName:widget.sName,
                        sellerImage: widget.sImage,
                        sellerRating: widget.rating,
                        storeDesc: widget.sDis,
                        sellerAddress: widget.sellerAddress,
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                      child: Card(
                      child: ListTile(
                        title:   Text("${sellerByCatModel?.data?[index].name}",

                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black54,),
                      ),
                ),
                    ),
                  );

          })
          // GridView.builder(
          //   itemCount:sellerByCatModel?.data?.length ?? 0 ,
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //       childAspectRatio: 3/3.2
          //     ),
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(5.0),
          //         child: InkWell(
          //           onTap: (){
          //             Navigator.push(context, MaterialPageRoute(builder: (context)=>SellerProfile(sId:widget.sID,catId:sellerByCatModel?.data?[index].id,isCatBy: true,)));
          //           },
          //           child: Card(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10)
          //             ),
          //             child:
          //             Column(
          //               children: [
          //                 Container(
          //                   height: 150,
          //                     child: Image.network("${sellerByCatModel?.data?[index].image}")),
          //                    Text("${sellerByCatModel?.data?[index].name}"),
          //                 SizedBox(height: 2,)
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     })

      ),
    );
  }
  SellerByModel? sellerByCatModel;
  getCat() async {
    var headers = {
      'Cookie': 'ci_session=adda4cc4e31e984d54e57f7d1b1877ef303bed12'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/get_categories'));
    request.fields.addAll({
      'seller_id':widget.sID.toString()
    });
    print('______request.fields____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult  =  SellerByModel.fromJson(jsonDecode(result));
      setState(() {
        sellerByCatModel = finalResult;
      });

    }
    else {
      print(response.reasonPhrase);
    }

  }

}

