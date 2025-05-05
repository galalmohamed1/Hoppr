import 'package:flutter/material.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';

class QuantityBtmSheetwidget extends StatelessWidget {
  const QuantityBtmSheetwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(// دي علشان يعمل خط فوق الارقام 
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index){
              return InkWell(//InkWell= دي علشان تخلي الارقام زي الزراير
                onTap: () {
                
              },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: SubtitleTextWidget(
                      lable: "${index +1 }",),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}