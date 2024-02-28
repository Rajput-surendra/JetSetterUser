import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:eshop_multivendor/widgets/appBar.dart';
import 'package:flutter/material.dart';

import 'model/PackageModel.dart';

class ActivityDetailScren extends StatefulWidget {
  const ActivityDetailScren({Key? key}) : super(key: key);

  @override
  State<ActivityDetailScren> createState() => _ActivityDetailScrenState();
}

class _ActivityDetailScrenState extends State<ActivityDetailScren> {
  List<String> image = [
    'https://www.holidify.com/images/cmsuploads/articles/358.jpg',
    'https://www.holidify.com/images/cmsuploads/articles/359.jpg',
  ];
  List<ActivityPackage> packages = [
    ActivityPackage(
      title: 'Super Saver Pack',
      image:
          'https://bookings.crescentwaterparks.com/images/products/suprepakcage.png',
      desc: 'Archery,Camping,Fishing,Golf,Hiking,Kayaking,Snorkeling',
      amount: 700,
      total: 0,
      persons: 0,
    ),
    ActivityPackage(
      title: 'Mega Saver Pack',
      image:
          'https://bookings.crescentwaterparks.com/images/products/Megasaver.jpg',
      desc: 'Archery,Camping,Fishing,Golf,Hiking,Kayaking,Snorkeling',
      amount: 800,
      total: 0,
      persons: 0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary1,
      appBar: getSimpleAppBar('Details', context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.whiteTemp,
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageSlider(height: 200, images: image),
                    const Divider(color: Colors.transparent),
                    Text(
                      'Crescent Water Park',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Located just a breezy drive from the heart of Indore and packed with top-notch facilities, we\'re not just a water park; we\'re your ultimate family destination!',
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 15),
                        Expanded(
                          child: Text(
                            ' Gram Jamniya, Near Narmada Kshipra Devguradia Khurd, Kampel Rd, Indore',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.transparent),
              Text('Avilable Packages',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const Divider(color: Colors.transparent),
              SizedBox(
                height: MediaQuery.of(context).size.height * .47,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const VerticalDivider(color: Colors.transparent),
                  itemCount: packages.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: MediaQuery.of(context).size.width * .68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.whiteTemp,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 125,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.primary1,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: packages[index].image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                        const Divider(color: Colors.transparent),
                        Text(
                          packages[index].title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          packages[index].desc,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: colors.black54,
                          ),
                        ),
                        const Divider(color: Colors.transparent),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹ ${packages[index].amount.toString()}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: colors.primary, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (packages[index].persons != 0) {
                                        setState(() {
                                          packages[index].persons -= 1;
                                          packages[index].total -=
                                              packages[index].amount;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: colors.primary,
                                      ),
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                            color: colors.whiteTemp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    packages[index].persons.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      packages[index].persons += 1;
                                      packages[index].total +=
                                          packages[index].amount;
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: colors.primary,
                                      ),
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            color: colors.whiteTemp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.transparent),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: colors.primary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '₹ ${packages[index].total.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: colors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(color: colors.whiteTemp),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key, required this.height, required this.images})
      : super(key: key);
  final double height;
  final List<String> images;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height, // Set your desired height here
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
                    imageUrl: widget.images[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                  );
                },
                onPageChanged: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 20, // Set your desired height for the page indicator
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.images.map((url) {
                      int index = widget.images.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? colors.primary1
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          )),
    );
    ;
  }
}
