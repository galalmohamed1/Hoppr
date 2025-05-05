import 'package:flutter/material.dart';
import 'package:Hoppr/consts/services/assert_manager.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';

import 'subtitle_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({super.key, required this.imagePath, required this.subtitle, required this.buttontext, required this.title});
  final String imagePath,title,subtitle,buttontext;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Padding(padding:  const EdgeInsets.only(top: 50),// علشان يعمل فراغ من فوق الصوره
      child: SingleChildScrollView(
        
          child: Column(
            children: [
              Image.asset(
                imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const TitlesTextWidget(
              label: "Whoops!",
              fontSize: 50,
              color: Colors.red,
              ),
              const SizedBox(
                height: 20,
              ),
             SubtitleTextWidget(
                lable: title,
                fontWeight: FontWeight.w600,
                ),
              const SizedBox(
                height: 20,
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child:  SubtitleTextWidget(
                  lable: subtitle,
                  fontWeight: FontWeight.w600,
                  ),
              ), 
              const SizedBox(
                height: 20,
              ), 
               ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20),elevation: 10),
                onPressed: (){}, 
                child: Text(
                  buttontext,
                  style: TextStyle(fontSize: 18),),),
            ],
                ),
        ),
        );
  }

  
}