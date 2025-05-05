import 'package:flutter/material.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';

class BottomCheckout extends StatelessWidget {
  const BottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10 ,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const[
                    FittedBox(
                      child: TitlesTextWidget(
                        label: "Total (5 products/5 Items)"),
                    ),
                      SubtitleTextWidget(
                        lable: "2500\$", 
                        color: Colors.blue,)
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){}, 
                child: const Text("checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}