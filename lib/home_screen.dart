import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>with TickerProviderStateMixin {
  late AnimationController _moveController;
  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }
  bool isOut = false;

  void animate() async{
    await _moveController.forward();
    setState(() {
      isOut = true;
    });
    await _moveController.reverse();
    setState(() {
      isOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numberOfCards = 5;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 99999,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              stops: [
                0.3,
                0.4,
              ],
              colors: [
                Colors.grey.shade200,
                Colors.white,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_back, color: Colors.black,),
                    ),
                    SizedBox(width: 110,),
                    Text("networth",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),),
                  ],
                ),
                SizedBox(height: 15,),

                networthdata(),
                SizedBox(height: 35,),

                transaciondata(),
                SizedBox(height: 35,),

                blacklistview(),
                SizedBox(height: 35,),

                invertmentdata(),
                SizedBox(height: 70,),

          GestureDetector(
            onTap: (){
              animate();
            },
            child: Center(
              child: AnimatedBuilder(
                animation: _moveController,
                builder: (context, snapshot) {
                  return Stack(
                    children: List.generate(
                      numberOfCards + 1,
                          (index) {
                        double reverseIndex = (numberOfCards + 1) - index.toDouble();
                        var yRotate = getAnimValue(
                            start: 0.0, end: 0.6, animation: _moveController);
                        var xRotate = getAnimValue(
                            start: -0.0, end: -0.2, animation: _moveController);
                        var yTranslate = -400 * _moveController.value;
                        if (index == numberOfCards) {
                          return Opacity(
                            opacity: isOut ? 0 : 1,
                            child: ATMCard(
                              rotateY: yRotate,
                              rotateX: xRotate,
                              translateY: yTranslate,
                              reverseIndex: reverseIndex,
                              index: index.toDouble(),
                            ),
                          );
                        }

                        double moveEnd = (numberOfCards + 1) - numberOfCards.toDouble();
                        double moveStart = reverseIndex;
                        if (index == 0) {
                          return Opacity(
                            opacity: isOut ? 1 : 0,
                            child: ATMCard(
                                rotateY: yRotate,
                                rotateX: xRotate,
                                translateY: yTranslate,
                                reverseIndex: getAnimValue(start: moveStart, end: moveEnd, animation: _moveController),
                                index: numberOfCards * _moveController.value
                            ),
                          );
                        }
                        return ATMCard(
                          reverseIndex: reverseIndex,
                          index: index.toDouble(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),

                SizedBox(height: 30,),
                bluelistview(),
                SizedBox(height: 35,),

                debtdetail(),
                SizedBox(height: 35,),
                Padding(
                  padding:  EdgeInsets.only(left: 12),
                  child: Text('latest at mojek money',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                ),
                SizedBox(height: 30,),
                mojekmonneylistview(),
                SizedBox(height: 35,),
                Center(child: Image.asset("assets/images/Save Invest Grow!.png")),
                SizedBox(height: 35,),
                Container(
                  height: 60,
                  width: 370,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff11C770)),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text("think we can improve? Send us your feedback",
                    style: TextStyle(color: Color(0xff11C770), fontSize: 15, fontWeight: FontWeight.w600),),
                  ),
                ),
                SizedBox(height: 35,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double getAnimValue(
      {required double start, required double end, required Animation animation}) {
    return ((end - start) * animation.value) + start;
  }

  blacklistview(){
    return SizedBox(
      height: 200,
      width: 600,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:  EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 100,
                width: 320,
                padding:  EdgeInsets.only(left: 20, right: 10),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   color: Color(0xff141B14)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18,),
                        Text('5% cashback',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),),
                        SizedBox(height: 18,),
                        SizedBox(
                          width: 170,
                          child: Text('on Grip Invest every time you invest through Mojek',
                            maxLines: 2,
                            style: TextStyle(fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                                fontSize: 14, color: Colors.white, fontFamily: 'Gilroy'),),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Center(
                            child: Text('discover Now',
                            style: TextStyle(color: Colors.black, fontSize: 15),),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18,),
                        Padding(
                          padding:  EdgeInsets.only(left: 80),
                          child: Image.asset("assets/images/AD.png", scale: 0.6,),
                        ),
                        SizedBox(height: 18,),
                        Image.asset("assets/images/image 81.png", ),
                        SizedBox(height: 18,),
                        Padding(
                          padding:  EdgeInsets.only(left: 65),
                          child: Image.asset("assets/images/image 2.png", scale: 0.6,),
                        )
                        
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  bluelistview(){
    return SizedBox(
      height: 200,
      width: 600,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:  EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 100,
                width: 320,
                padding:  EdgeInsets.only(left: 20, right: 10),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff07014F)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18,),
                        Text('5% cashback',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white),),
                        SizedBox(height: 18,),
                        SizedBox(
                          width: 170,
                          child: Text('on Grip Invest every time you invest through Mojek',
                            maxLines: 2,
                            style: TextStyle(fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                                fontSize: 14, color: Colors.white, fontFamily: 'Gilroy'),),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Center(
                            child: Text('discover Now',
                              style: TextStyle(color: Colors.black, fontSize: 15),),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18,),
                        Padding(
                          padding:  EdgeInsets.only(left: 80),
                          child: Image.asset("assets/images/AD.png", scale: 0.6,),
                        ),
                        SizedBox(height: 18,),
                        Image.asset("assets/images/image 81.png", ),
                        SizedBox(height: 18,),
                        Padding(
                          padding:  EdgeInsets.only(left: 65),
                          child: Image.asset("assets/images/image 2.png", scale: 0.6,),
                        )

                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  mojekmonneylistview(){
    return SizedBox(
      height: 400,
      width: 600,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:  EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                height: 100,
                width: 320,
                padding:  EdgeInsets.only(left: 20, right: 10, top: 15),
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, //New
                      blurRadius: 3.0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/image 67.png",
                        scale: 0.6,),
                        SizedBox(width: 5,),
                        Text("icici pru commodities fund",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding:  EdgeInsets.only(left: 15, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color(0xffE7E7F0),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text('mutual funds')),
                          ),
                          Container(
                            height: 30,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Color(0xffE7E7F0),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: Text('med. risk')),
                          ),
                          SizedBox(height: 10,),
                          Image.asset("assets/images/image 65.png",
                          scale: 0.7,)
                        ],
                      ),
                    ),
                    SizedBox(height: 38,),
                    Padding(
                      padding:  EdgeInsets.only(left: 15, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('fitch a',
                              style: TextStyle(color: Color(0xff11C770), fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('rating',
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                            ],
                          ),
                          Column(
                            children: [
                             Image.asset("assets/images/image 3.png",
                             scale: 0.7,),
                              SizedBox(height: 10,),
                              Text('sebi \n compliant',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                            ],
                          ),
                          Column(
                            children: [
                              Text('9.95%',
                                style: TextStyle(color: Color(0xff11C770), fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('yield on \n maturity',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 38,),
                    Padding(
                      padding:  EdgeInsets.only(left: 15, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('9.20%',
                                style: TextStyle(color:  Colors.black, fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('coupon rate',
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                            ],
                          ),
                          Column(
                            children: [
                              Text('₹ 30,000',
                                style: TextStyle(color:  Colors.black, fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('minimum \n investment',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                            ],
                          ),
                          Column(
                            children: [
                              Text('13 months',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
                              SizedBox(height: 10,),
                              Text('time for \n maturity',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 38,),
                    Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Color(0xff11C770),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text('invest now',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
                      ),
                    ),
                  ],
                )
              ),
            );
          }
      ),
    );
  }

  debtdetail(){
    return Padding(
      padding:  EdgeInsets.only(left: 10),
      child: Container(
        height: 330,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //New
              blurRadius: 3.0,
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 20, right: 20,top: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('debt',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500 , fontSize: 18)),
                  Text("₹ 12,45,578",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900 , fontSize: 16),)
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            debtdata("assets/images/image 2 (1).png",
            "kotak bank",
            "personal loan",
            "₹ 32,45,578"),
            SizedBox(height: 20,),
            debtdata("assets/images/Ellipse 7.png",
                "hdfc bank",
                "education loan",
                "₹ 32,45,578"),
            SizedBox(height: 20,),
            debtdata("assets/images/Ellipse 7.png",
                "hdfc bank",
                "car loan",
                "₹ 32,45,578"),
            SizedBox(height: 20,),
            Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('view details',
                style: TextStyle(color: Color(0xff11C770), fontSize: 16, fontWeight: FontWeight.w600),),
                Icon(Icons.arrow_forward,
                    color: Color(0xff11C770))
              ],
            )
          ],
        ),
      ),
    );
  }
  debtdata(String image, String bank, String bankname, String amt){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(image),
              SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bank,
                    style: TextStyle(fontSize: 15, color: Colors.grey),),
                  SizedBox(height: 7,),
                  Text(bankname,
                      style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(amt,
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),),
              Icon(Icons.arrow_forward_ios,
                size: 19,)
            ],
          )
        ],
      ),
    );
  }


  networthdata(){
    num total = 30.4;
    num obtained = 5.4;
    num diff = 0;
    diff = total - obtained;
    print(diff);
    var finalpercent;

    if (total >= 1) {
      finalpercent = obtained / ((total * 100) / 100);
    } else {
      finalpercent = 0.0;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        height: 240,
        width: 350,
        padding: EdgeInsets.only(
          left: 19, top: 18, right: 22
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //New
              blurRadius: 3.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("₹ ${diff.toString()}",
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900 , fontSize: 22),),
            SizedBox(height: 7,),
            Text("networth",
              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500 , fontSize: 16),),


            SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("what you have?",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900 , fontSize: 16),),
                Text("₹ ${total.toString()} L",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900 , fontSize: 19),),
              ],
            ),
            SizedBox(height: 7,),
            LinearPercentIndicator(
              padding : const EdgeInsets.symmetric(horizontal: 0.0),
              barRadius: const Radius.circular(10),
              width: 300,
              animation: true,
              lineHeight: 6.0,
              animationDuration: 3000,
              percent: finalpercent,
              progressColor: const Color(0xff11C770),
            ),
            SizedBox(height: 28,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("what you owe?",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900 , fontSize: 16),),
                Text("₹ ${obtained.toString()} L",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900 , fontSize: 19),),
              ],
            ),
            SizedBox(height: 7,),
            LinearPercentIndicator(
              padding : const EdgeInsets.symmetric(horizontal: 0.0),
              barRadius: const Radius.circular(10),
              width: 300,
              animation: true,
              lineHeight: 6.0,
              animationDuration: 3000,
              percent: finalpercent,
              progressColor: const Color(0xffFA2D43),
            ),
          ],
        ),
      ),
    );
  }

  transaciondata(){
    final List colors = [
      //Colors.yellow.shade150,
      Color(0xffD91829),
      Color(0xff003399),
    ];
    return Padding(
      padding:  EdgeInsets.only(left: 11),
      child: SizedBox(
        height: 200,
        width: 400,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('total cash',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17, color: Colors.black),),
                    Text('₹ 32,45,578',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black),),
                    SizedBox(height: 60,),
                    Row(
                      children: [
                        Text('view recent \ntransactions',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff11C770)),),
                        Icon(Icons.arrow_forward,
                            color: Color(0xff11C770))
                      ],
                    )
                  ],
                ),
                SizedBox(width: 10,),
                trans(Color(0xffD91829),"assets/images/image 2 (1).png"),
                trans(Color(0xff003399),"assets/images/Ellipse 7 (1).png"),
              ],
            ),
          ]
        ),
      ),
    );
  }
  trans(Color color, String image){
    return Padding(
      padding:  EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 190,
        width: 200,
        padding:  EdgeInsets.only(left: 20, right: 10),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18,),
           Image.asset(image),
            SizedBox(height: 7,),
            Text('₹ 32,45,578',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 19),),
            SizedBox(height: 7,),
            Text('kotak savings (6524)',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),),
            SizedBox(height: 18,),
            Container(
              height: 38,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Center(
                child: Text('view transactions',
                  style: TextStyle(color: Colors.black, fontSize: 15),),
              ),
            )
          ],
        ),
      ),
    );
  }

  invertmentdata(){

    return Padding(
      padding:  EdgeInsets.only(left: 11),
      child: SizedBox(
        height: 270,
        width: 400,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('your\ninvestment \nbreakdown',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: Colors.black),),
                      SizedBox(height: 120,),
                      Row(
                        children: [
                          Text('view all \ninvestment',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff11C770)),),
                          Icon(Icons.arrow_forward,
                              color: Color(0xff11C770))
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 10,),
                  inves("assets/images/Vector (2).png","stock", Color(0xffD0FBE6), Color(0xff11C770), "12% profit"),
                  inves("assets/images/Vector (1).png","mutual funds",Color.fromRGBO(250, 45, 67, 0.18), Color(0xffFA2D43),"2% loss"),
                ],
              ),
            ]
        ),
      ),
    );
  }
  inves(String image, String title, Color color, Color colors, String profit){
    Map<String, double> dataMap = {
      "Flutter": 5,
      "data": 5
    };
    final colorList = <Color>[
      const Color(0xff11C770),
      const Color(0xffE5FFF4),
    ];
    return Padding(
      padding:  EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 250,
        width: 190,
        //padding:  EdgeInsets.only(left: 20, right: 10),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //New
              blurRadius: 3.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18,),
            PieChart(
              dataMap: dataMap,
              centerText: "₹ 60.2 K",
              emptyColor: Colors.transparent,
              centerTextStyle: TextStyle(color: Color(0xff11C770),fontWeight: FontWeight.w900),
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 15,
              chartRadius: MediaQuery.of(context).size.width / 5,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 8,
              // centerText: "HYBRID",
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.left,
                showLegends: false,
                // legendShape: _BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: true,
                decimalPlaces: 1,
              ),
              // gradientList: ---To add gradient colors---
              // emptyColorGradient: ---Empty Color gradient---
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image),
                SizedBox(width: 4,),
                Text(title)
              ],
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(profit,
              style: TextStyle(fontWeight: FontWeight.w900, color: colors),),
            ),
            SizedBox(height: 18,),
            Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('view',
                style: TextStyle(color: Color(0xff11C770),fontSize: 17, fontWeight: FontWeight.w900)),
                Icon(Icons.arrow_forward)
              ],
            )
          ],
        ),
      ),
    );
  }
}


class ATMCardUI extends StatelessWidget {

  String get getCardPan {
    return ("123456789018123455").replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}       ");
  }

  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 230,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("₹ 45,578",
              style: TextStyle(color: Colors.white , fontWeight: FontWeight.w700, fontSize: 21),),
              Image.asset("assets/images/image 2 (1).png")
            ],
          ),
          Spacer(),
          Text("one card (6524)",
            style: TextStyle(color: Colors.white , fontWeight: FontWeight.w700, fontSize: 17),),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Center(
                  child: Text('view transactions',
                    style: TextStyle(color: Colors.black, fontSize: 15),),
                ),
              ),
              Row(
                children: [
                  Text('View offers',
                  style: TextStyle(color: Color(0xff41D28D)),),
                  Icon(Icons.arrow_forward,
                      color: Color(0xff41D28D))
                ],
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff02559A),
        border: Border.all(color: Colors.black),
        // gradient: LinearGradient(
        //   colors: [Colors.pink, Colors.purple],
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }
}

class ATMCard extends StatelessWidget {
  final double? index;
  final double? reverseIndex;
  final double? rotateX, rotateY, translateY;

  const ATMCard({
    Key? key,
    this.index,
    this.reverseIndex,
    this.rotateX,
    this.rotateY,
    this.translateY,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        (index! * -10.0),
        reverseIndex! * -10.0,
      ),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0008)
          ..rotateY(rotateY ?? 0.2)
          ..rotateX(rotateX ?? 0.1)
          ..rotateZ(0.0)
          ..translate(20.0, translateY ?? 0.0),
        child: ATMCardUI(),
      ),
    );
  }
}