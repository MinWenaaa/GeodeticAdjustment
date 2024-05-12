import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geodetic_adjustment/constant.dart';
import 'package:geodetic_adjustment/widgets.dart';
import 'package:geodetic_adjustment/geodetic_adjustment.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int detailed = 0;   //HomePage状态
  int tools=0;        //子组件——CalcPage状态


  @override
  Widget build(BuildContext context) {
    return detailed==0?state1():state2();
  }

  Widget state1(){
    return Row(
        children:[
          const Expanded(
              flex:4,
              child: Padding(
                padding: EdgeInsets.fromLTRB(80,64,48,64),
                child: AuthorCard(style: 0),
              )
          ),
          Expanded(
            flex:5,
            child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:[
                  const Expanded(
                    child: Row(
                      children:[
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(32, 64, 64, 32),
                              child: ToolCard(tool:0,style:0),
                            )),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 64, 88, 32),
                              child: ToolCard(tool:1,style:0),
                            )),
                      ]
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children:[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 40, 64, 64),
                            child: Card(
                                elevation:10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  child:const SizedBox(
                                      height:double.infinity,
                                      width:double.infinity,
                                      child: Center(
                                        child: Text(
                                                "Stay tuned for more...",
                                              style:TextStyle(color:AppColors1.primaryColor,fontSize: 32)

                                        ),
                                      )
                                  )
                              ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 40, 88, 64),
                            child: SizedBox(
                              height:double.infinity,
                              width:double.infinity,
                              child: TextButton(
                                    style:AppButton.button1,
                                    onPressed: (){setState(() {
                                      detailed=1;});},
                                    child:const Text("更多/反馈/关注mw",style:AppText.aStandard)
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
                  )
                ]
            ),
          ),
        ]
    );
  }

  Widget state2() {
    return Row(
        children: [
          Expanded(
              flex:5,
              child: tools == 0 ? smallHome() : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextButton(
                            style: AppButton.button2,
                            onPressed: () {setState(() {tools = 0;});},
                            child: const Icon(Icons.arrow_back)
                        ),
                        Text(tools==1?"白塞尔大地解算":"高斯投影计算",style:AppText.standard)
                      ],
                    ),
                    const SizedBox(height:20),
                    CalcPage(tool: tools),
                    const SizedBox(height:40),
                  ]
              )
          ),
          moreWidget(),
        ]
    );
  }


  Widget smallHome(){
    return Column(
        children:[
          const Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(72, 64, 72, 64),
                child: AuthorCard(style: 1),
              )
          ),
          Expanded(
            child: Row(
                children:[
                  Expanded(
                    flex:7,
                    child: Column(
                        children:[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(60, 0, 72, 64),
                              child: TextButton(
                                onPressed: (){setState(() {tools=1;});},
                                child:const ToolCard(style:1,tool:0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(60, 0, 72, 64),
                              child: TextButton(
                                onPressed: (){setState(() {tools=2;});},
                                child:const ToolCard(style:1,tool:1),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    flex:3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 72, 64),
                      child: Card(
                          elevation:10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child:const SizedBox(
                              height:double.infinity,
                              width:double.infinity,
                              child:Center(
                                child: Text(
                                    "Stay tuned for more...",
                                    style:TextStyle(color:AppColors1.primaryColor,fontSize: 32)
                                ),
                              )
                          )
                      ),
                    ),
                  )
                ]
            ),
          ),
        ]
    );
  }

  Widget moreWidget() {
    return const Expanded(
      flex:3,
      child: SizedBox(
        height:double.infinity,
        width:double.infinity,
        child: Image(
            image:AssetImage('asset/2.png'),
          fit: BoxFit.cover
        ),
      ),
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
  final List<String> ellips =["克拉索夫斯基","1975国际","WGS-84","2000中国大地坐标系"];
  int ellip=4;
  int modeCalc=3;
  int modeZone=2;
  List<TextEditingController> bessel=List.generate(7, (index) => TextEditingController());
  List<TextEditingController> guass=List.generate(4, (index) => TextEditingController());
  List<TextEditingController> zone=[TextEditingController(),TextEditingController()];


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:32,horizontal:72),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors1.accentColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ellipSelct(),
                        tool==1?Container():zoneSelct(),
                        modeCalcSelect()
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                          elevation:0,
                          color: AppColors1.secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(56, 32, 56, 0),
                            child: tool == 1
                                ? besselfieldInput()
                                : guassFieldInput(),
                          )),
                      Card(
                          elevation:0,
                          color: AppColors1.secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(56, 32, 56, 0),
                            child: tool == 1
                                ? besselFieldOutput()
                                : guassFieldOutput(),
                          ))
                    ]
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:32,horizontal:72),
                child: TextButton(
                    onPressed: calculate,
                    style: AppButton.button3,
                    child: const Text("确定")
                ),
              ),
            )
          ]
      ),
    );
  }


  Widget ellipSelct(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children:
          List.generate(4, (index) =>
            Row(
              children: [
                Checkbox(
                  value: (ellip==index),
                  onChanged:(value){
                    setState(() {
                      if(value!){ellip=index;}
                    });
                  }
                ),
                Text(ellips[index])
              ],
            )
          ),
    );
  }

  Widget zoneSelct(){
    return Column(
      children:[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Checkbox(
              value: modeZone==0,
              onChanged: (value){setState(() {if(value!){modeZone=0;}});}
            ),
            const Text("3度带"),
            const SizedBox(width:40),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            width:212,
            height:36,
            child: TextField(
              controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),)
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

