import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/providers/favorite_provider.dart';

class CuratedItems extends ConsumerWidget {
  final DocumentSnapshot<Object?>  eCommerceItems;
  final Size size;
  const CuratedItems({super.key, required this.eCommerceItems, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favoriteProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: eCommerceItems.id,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    eCommerceItems['image'],
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: size.height*0.25,
            width: size.width*0.5,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: provider.isExist(eCommerceItems)
                      ?Colors.white
                      :Colors.black26,
                  child: GestureDetector(
                    onTap: () {
                      ref.read(favoriteProvider).toggleFavorite(eCommerceItems);
                    },
                    child: Icon(
                      provider.isExist(eCommerceItems)
                      ?Icons.favorite
                      :Icons.favorite_border,
                      color: provider.isExist(eCommerceItems)
                          ?Colors.red
                          :Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 7,),
        Row(
          children: [
            Text(
              eCommerceItems['category'],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black26,
              ),
            ),
            SizedBox(width: 5,),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 17,
            ),
            Text("${Random().nextInt(2)+3}.${Random().nextInt(5)+4}"),
            SizedBox(width: 3,),
            Text(
              "${Random().nextInt(300)+100}",
              style: TextStyle(
                color: Colors.black26,

              ),
            ),

          ],
        ),
        SizedBox(
          width: size.width*0.5,
          child: Text(
            eCommerceItems['name'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "\$${(eCommerceItems['price']*(1-eCommerceItems['discountPercentage']/100)).toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.5,
                color: Colors.pink,
              ),
            ),
            SizedBox(width: 5,),
            if(eCommerceItems['isDiscounted'] == true)
              Text(
                "\$${eCommerceItems['price']}.00",
                style: TextStyle(
                  color: Colors.black26,
                  decorationColor: Colors.black26,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
          ],
        ),

      ],
    );
  }
}
