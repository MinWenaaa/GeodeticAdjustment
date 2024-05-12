import 'package:flutter/material.dart';
import 'package:geodetic_adjustment/constant.dart';



class AuthorCard extends StatelessWidget {
  final int style;
  const AuthorCard({required this.style,super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation:10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          clipBehavior:Clip.hardEdge,
          child:const SizedBox(
            height:double.infinity,
            width:double.infinity,
            child:
            Image(
                image: AssetImage('asset/card.png'),
                fit:BoxFit.cover
            ),
          ),
        ),
        Center(
          child:
            style==0?authorCard1():authorCard2(),
        ),
      ],
    );
  }

  Widget authorCard1(){
    return Column(
        mainAxisAlignment:MainAxisAlignment.center,
      children: [
        SizedBox(
          width:300, height:300,
            child: user()
        ),
        const Text("MinWenaaa",style:AppText.aBig),
        const Row(
            mainAxisAlignment:MainAxisAlignment.center,
          children:[
            Icon(Icons.villa,color:AppColors1.textColor),
            Text("中国地质大学（武汉）",style:AppText.standard)
          ]
        )
      ],
    );
  }

  Widget authorCard2(){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        SizedBox(
            width:220, height:220,
            child: user()
        ),
        const SizedBox(width:40),
        const Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("MinWenaaa",style:AppText.aBig),
            Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Icon(Icons.villa,color:AppColors1.textColor),
                  Text("中国地质大学（武汉）",style:AppText.standard)
                ]
            )
          ],
        ),
        const SizedBox(width:60)
      ],
    );
  }

  Widget user(){
    return const ClipOval(
      child:Image(image: AssetImage('asset/user.jpg'),)
    );
  }
}


class ToolCard extends StatelessWidget {
  final int tool;
  final int style;
  const ToolCard({required this.style,required this.tool,super.key});

  @override
  Widget build(BuildContext context) {
    switch (tool){
      case 0:
        return style==0 ? tools1(["Bessel"]) : tools2(["Bessel"]);
      case 1:
        return style==0 ? tools1(["Guass"]) : tools2(["Guass"]);
      default:
        return Container();
    }
  }

  Widget tools1(List<String> contents){
    return Card(
        elevation:10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color:AppColors1.primaryColor,
        child:Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children:[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    tool==0?"Geodetic":"Projection",
                    style:const TextStyle(color:AppColors1.accentColor,fontSize: 36)
                ),
                Text(
                  tool==0?"Problem":"Calculation",
                  style:const TextStyle(color:AppColors1.accentColor,fontSize: 36)
                ),
                const SizedBox(height:20)
              ],
            ),
            Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children:[
                  Card(
                    elevation:0,
                    child:Padding(
                      padding: const EdgeInsets.symmetric(vertical:4,horizontal:8),
                      child: Text(contents[0],style:TextStyle(color:AppColors1.primaryColor)),
                    ),
                  ),
                  const Card(
                    child:Padding(
                      padding: EdgeInsets.symmetric(vertical:4,horizontal:22),
                      child: Text("···",style:TextStyle(color:AppColors1.primaryColor)),
                    )
                  )
                ]

            )
          ]
        )

    );
  }

  Widget tools2(List<String> contents){
    return Card(
        elevation:10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color:AppColors1.primaryColor,
        child:Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children:[
              Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                      children:[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                tool==0?"Geodetic":"Projection",
                                style:const TextStyle(color:AppColors1.accentColor,fontSize: 32)
                            ),
                            Text(
                                tool==0?"Problem":"Calculation",
                                style:const TextStyle(color:AppColors1.accentColor,fontSize: 32)
                            ),
                            SizedBox(height:10)
                          ],
                        ),
                        SizedBox(width:30),
                        Card(
                          elevation:0,
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical:4,horizontal:8),
                            child: Text(contents[0],style:const TextStyle(color:AppColors1.primaryColor)),
                          ),
                        ),
                        const Card(
                            child:Padding(
                              padding: EdgeInsets.symmetric(vertical:4,horizontal:22),
                              child: Text("···",style:TextStyle(color:AppColors1.primaryColor)),
                            )
                        )
                      ]
                  )
            ]
        )
    );
  }
}

