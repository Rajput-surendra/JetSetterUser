import 'package:cached_network_image/cached_network_image.dart';
import 'package:eshop_multivendor/Screen/Activities/detailScreen.dart';
import 'package:eshop_multivendor/Screen/Search/Search.dart';
import 'package:eshop_multivendor/widgets/appBar.dart';
import 'package:flutter/material.dart';

import '../../Helper/Color.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary1,
      appBar: getSimpleAppBar('Activities', context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration()
                        .applyDefaults(Theme.of(context).inputDecorationTheme)
                        .copyWith(
                          hintText: 'Search Location',
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: colors.red,
                          ),
                        ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.primary,
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Divider(color: Colors.transparent),
            Text(
              'Top Activities',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(color: Colors.transparent),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ActivityDetailScren(),
                )),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.whiteTemp,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              'https://files.yappe.in/place/full/crescent-water-park-2047306.webp',
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(color: Colors.transparent),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crescent Water Park',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Located just a breezy drive from the heart of Indore and packed with top-notch facilities, we\'re not just a water park; we\'re your ultimate family destination!',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.red, size: 15),
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
                      )
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
