import 'package:flutter/material.dart';

class SizeScreen extends StatefulWidget {
  final List<dynamic> sizes;
  final Function(int) onSizeSelected;
  final int selectedSizedIndex;

  const SizeScreen({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
    required this.selectedSizedIndex,
  });

  @override
  State<SizeScreen> createState() => _SizeState();
}

class _SizeState extends State<SizeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width / 2.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.sizes
                      .asMap()
                      .entries
                      .map<Widget>((entry) {
                    final int index =entry.key;
                    final   size =entry.value;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.onSizeSelected(index);
                        });
                      },
                      child: Container(
                        width: 55,
                        height: 55,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:widget.selectedSizedIndex == index
                              ?Colors.black
                              : Colors.white,
                          border:Border.all(
                            color:widget.selectedSizedIndex == index
                                ?Colors.black
                                : Colors.black12,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            size,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:widget.selectedSizedIndex== index
                                  ?Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },).toList(),
                ),

              ),
              SizedBox(height: 70,),
            ],
          ),
        ),
      ],
    );
  }
}
