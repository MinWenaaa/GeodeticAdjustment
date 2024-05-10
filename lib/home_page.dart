import 'package:flutter/material.dart';
import 'package:geodetic_adjustment/constant.dart';
import 'package:geodetic_adjustment/widgets.dart';
import 'package:geodetic_adjustment/geodetic_adjustment.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int detailed = 0;
  int tools=0;
  @override
  Widget build(BuildContext context) {
    return detailed==0?state1():state2();
  }

  Widget state1(){
    return Row(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children:[
          const SizedBox(
              width:400,
              height:500,
              child: AuthorCard(style: 0)
          ),
          SizedBox(
            width:400,
            height:500,
            child: GridView.count(
                crossAxisCount: 2,
                children:[
                  const ToolCard(tool:0,style:0),
                  const ToolCard(tool:1,style:0),
                  const Card(
                      child:Text("Stay tuned for more...")
                  ),
                  TextButton(
                      style:AppButton.button1,
                      onPressed: (){setState(() {
                        detailed=1;});},
                      child:const Text("更多/反馈/关注mw")
                  )
                ]
            ),
          )
        ]
    );
  }
  Widget state2(){
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      children:[
      tools==0?Column(
        children:[
          const SizedBox(
            width:400, height:240,
            child: AuthorCard(style: 1)
          ),
          Row(
            children:[
              Column(
                children:[
                  TextButton(
                    onPressed: (){setState(() {tools=1;});},
                    child:const ToolCard(style:1,tool:0),
                  ),
                  TextButton(
                    onPressed: (){setState(() {tools=2;});},
                    child:const ToolCard(style:1,tool:1),
                  ),
                ]
              ),
              const Card(
                child:Text("Stay tuned for more")
              )
            ]
          ),
        ]
      ):Row(
        children:[
          CalcPage(tool:tools),
          TextButton(
            style:AppButton.button1,
            onPressed: (){setState(() {tools=0;});},
            child:const Icon(Icons.arrow_back)
          )
        ]
      ),
      const MoreWidget(),
      ]
    );
  }
}
class CalcPage extends StatefulWidget {
  final int tool;
  const CalcPage({required this.tool,super.key});

  @override
  State<CalcPage> createState() => _CalcPageState();
}

class _CalcPageState extends State<CalcPage> {
  late final int tool =widget.tool;
  int ellip=4;
  int modeCalc=3;
  int modeZone=2;
  List<TextEditingController> bessel=List.generate(7, (index) => TextEditingController());
  List<TextEditingController> guass=List.generate(4, (index) => TextEditingController());
  List<TextEditingController> zone=[TextEditingController(),TextEditingController()];
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
          children: [
            ellipSelct(),
            zoneSelct(),
            modeCalcSelect()
          ],
        ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children:[
              Card(
                color:AppColors1.primaryColor,
                  child: tool==1?besselfieldInput():guassFieldInput()),
              Card(
                color:AppColors1.primaryColor,
                  child: tool==1?besselFieldOutput():guassFieldOutput())
            ]
          ),
          TextButton(
            onPressed: calculate,
            style:AppButton.button1,
            child:const Text("确定")
          )
    ]
    );
  }

  Widget ellipSelct(){
    return Row(
      children:[
        Column(children:
          List.generate(4, (index) =>
            Checkbox(
              value: (ellip==index),
              onChanged:(value){
                setState(() {
                  if(value!){ellip=index;}
                });
              }
            )
          )
        ),
        const Column(
          children:[
            Text("椭球1"),
            Text("椭球2"),
            Text("椭球3"),
            Text("椭球4")
          ]
        )
      ]
    );
  }

  Widget zoneSelct(){
    return Column(
      children:[
        Row(
          children:[
            Checkbox(
              value: modeZone==0,
              onChanged: (value){setState(() {if(value!){modeZone=0;}});}
            ),
            const Text("3度带"),
            Checkbox(
              value: modeZone==1,
              onChanged: (value){setState(() {if(value!){modeZone=1;}});}
            ),
            const Text("6度带"),
          ]
        ),
        Column(
          children:[
            myTextField("带号：",zone[0]),
            modeCalc==2?myTextField("带号：",zone[1]):Container()
          ]
        )
      ]
    );
  }

  Widget modeCalcSelect(){
    return Column(
      children:[
        Row(
          children:[
            Checkbox(
                value: modeCalc==0,
                onChanged: (value){
                  setState(() {if(value!){modeCalc=0;}});
                }),
            Text(tool==1?"正算":"椭球面到平面")
          ]
        ),
        Row(
            children:[
              Checkbox(
                  value: modeCalc==1,
                  onChanged: (value){
                    setState(() {if(value!){modeCalc=1;}});
                  }),
              Text(tool==1?"反算":"平面到椭球面")
            ]
        ),
        tool==2?Row(
            children:[
              Checkbox(
                  value: modeCalc==2,
                  onChanged: (value){
                    setState(() {if(value!){modeCalc=2;}});
                  }),
              const Text("邻带换算")
            ]
        ):Container()
      ]
    );
  }

  Widget besselfieldInput(){
    return Column(
      children:[
        const Text("input"),
        myTextField("L1:",bessel[0]),
        myTextField("B1:",bessel[1]),
        myTextField(modeCalc==0?"A1:":"L2:",bessel[2]),
        myTextField(modeCalc==0?"S:":"B2:",bessel[3]),
      ]
    );
  }
  Widget besselFieldOutput(){
    return Column(
      children:[
        const Text("output"),
        myTextField(modeCalc==0?"L2:":"A1",bessel[4]),
        myTextField(modeCalc==0?"B2:":"A2",bessel[5]),
        myTextField(modeCalc==0?"A2:":"S",bessel[6]),
      ]
    );
  }
  Widget guassFieldInput(){
    return Column(
      children:[
        const Text("input"),
        myTextField(modeCalc==0?"B:":"x:",guass[0]),
        myTextField(modeCalc==0?"L:":"y:",guass[1]),
      ]
    );
  }
  Widget guassFieldOutput(){
    return Column(
        children:[
          const Text("output"),
          myTextField(modeCalc==1?"B:":"x:",guass[2]),
          myTextField(modeCalc==1?"L:":"y:",guass[3]),
        ]
    );
  }

  Widget myTextField(String name,TextEditingController controller){
    return Row(
        children:[
          Text(name),
          SizedBox(
            width:180,
            height:36,
            child: TextField(
              controller: controller,
              //keyboardType: TextInputType.number,
              decoration:const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0,0),
              ),
            ),
          )
        ]
    );
  }

  void calculate(){
    if(tool==1){
      if(modeCalc==0) {
          //besselDirect
          bessel[4].text = BDL2(
                  double.parse(bessel[0].text),
                  double.parse(bessel[1].text),
                  double.parse(bessel[2].text),
                  double.parse(bessel[3].text),
                  ellip)
              .toString();
          bessel[5].text = BDB2(
                  double.parse(bessel[0].text),
                  double.parse(bessel[1].text),
                  double.parse(bessel[2].text),
                  double.parse(bessel[3].text),
                  ellip)
              .toString();
          bessel[6].text = BDA2(
                  double.parse(bessel[0].text),
                  double.parse(bessel[1].text),
                  double.parse(bessel[2].text),
                  double.parse(bessel[3].text),
                  ellip)
              .toString();

      } else{
        bessel[4].text = BIA1(
                double.parse(bessel[0].text),
                double.parse(bessel[1].text),
                double.parse(bessel[2].text),
                double.parse(bessel[3].text),
                ellip)
            .toString();
        bessel[5].text = BIA2(
                double.parse(bessel[0].text),
                double.parse(bessel[1].text),
                double.parse(bessel[2].text),
                double.parse(bessel[3].text),
                ellip)
            .toString();
        bessel[6].text = BIS(
                double.parse(bessel[0].text),
                double.parse(bessel[1].text),
                double.parse(bessel[2].text),
                double.parse(bessel[3].text),
                ellip)
            .toString();
      }
    }
    else{
      if(modeCalc==0){
        int L_num=int.parse(zone[0].text);
        guass[2].text=GFx(double.parse(guass[0].text),double.parse(guass[1].text),L_num,modeZone,ellip).toString();
        guass[3].text=GFy(double.parse(guass[0].text),double.parse(guass[1].text),L_num,modeZone,ellip).toString();
      }
      if(modeCalc==1){
        int L_num=int.parse(zone[0].text);
        guass[2].text=GBL(double.parse(guass[0].text),double.parse(guass[1].text),L_num,modeZone,ellip).toString();
        guass[3].text=GBB(double.parse(guass[0].text),double.parse(guass[1].text),L_num,modeZone,ellip).toString();
      }
      if(modeCalc==2){
        int L_num1=int.parse(zone[0].text);
        int L_num2=int.parse(zone[1].text);
        guass[2].text=GCx(double.parse(guass[0].text),double.parse(guass[1].text),L_num1,L_num2,modeZone,ellip).toString();
        guass[3].text=GCy(double.parse(guass[0].text),double.parse(guass[1].text),L_num1,L_num2,modeZone,ellip).toString();
      }
    }
  }
}

