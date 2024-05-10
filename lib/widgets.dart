import 'package:flutter/material.dart';
import 'package:geodetic_adjustment/constant.dart';



class AuthorCard extends StatelessWidget {
  final int style;
  const AuthorCard({required this.style,super.key});

  @override
  Widget build(BuildContext context) {
    if(style==0) {
      return authorCard1();
    }
    return authorCard2();
  }

  Widget authorCard1(){
    return const Card(
      color:AppColors1.primaryColor,
      child:Column(
        children:[
          Text("Author:"),
          Text("MinWenaaa")
        ]
      )
    );
  }

  Widget authorCard2(){
    return const Card(
        color:AppColors1.primaryColor,
        child:Column(
            children:[
              Text("Author:"),
              Text("MinWenaaa")
            ]
        )
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
        return style==0 ? tools1("Geodetic Datum",["Bessel"]) : tools2("Geodetic Datum",["Bessel"]);
      case 1:
        return style==0 ? tools1("Projection",["Guass"]) : tools2("Projection",["Guass"]);
      default:
        return Container();
    }
  }

  Widget tools1(String content,List<String> contents){
    return Card(
      color:AppColors1.primaryColor,
      child:Row(
        children:[
          Flexible(
            flex:1,
            child:Text(content),
          ),
          Flexible(
            flex:1,
            child:Column(
              children:[
                Card(
                  child:Text(content[0]),
                ),
                const Card(
                  child:Text("···")
                )
              ]
            )
          )
        ]
      )
    );
  }

  Widget tools2(String content,List<String> contents){
    return Card(
        color:AppColors1.primaryColor,
        child:Column(
            children:[
              Text(content),
              Row(
                      children:[
                        Card(
                          child:Text(content[0]),
                        ),
                        const Card(
                            child:Text("···")
                        )
                      ]
                  )
            ]
        )
    );
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children:[
        Icon(Icons.ac_unit,color:AppColors1.primaryColor,size:150),
        Icon(Icons.access_alarm,color:AppColors1.primaryColor,size:150)
      ]
    );
  }
}
