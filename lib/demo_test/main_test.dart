



import 'dart:async';

void main(){


  final inMicroseconds2 = const Duration(days: 90).inMilliseconds;
  print('lao_gao-->_MyPubspecPageState_initState_$inMicroseconds2');

//  check((checkResultData) {
//    print('lao_gao-->_main_${checkResultData}');
//  });

 final map = {"1":"ffq","2":"ffqq","3":"ffvv","4":"fbbf"};
 print('lao_gao-->_main_${map}');
 Timer(Duration(seconds: 2) , (){

   print('lao_gao-->_main_timer ${map}');
 });
 map.remove("2");
 print('lao_gao-->_main_${map}');


}



check(TestCallback callback){

  Future.delayed(Duration(seconds: 2),(){
    callback('sadasda222222');
  });
}

typedef TestCallback = void Function(String date);
