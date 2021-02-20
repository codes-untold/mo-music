import 'package:flutter/material.dart';
import 'package:momusic/constants.dart';

class MusicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 0.0,right: 0,top:75.0,bottom: 0),
     decoration: gradient_color,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
         children: [
           CircleAvatar(
             radius: 75.0,
             backgroundImage: AssetImage('images/moimage.png'),

           ),
           SizedBox(
             height: 20.0,
           ),
           Text('High School Buzz',
           style: TextStyle(
             color: Colors.white,
             fontSize: 20.0,
             fontWeight: FontWeight.w500
           ),),
           SizedBox(
             height: 8.0,
           ),
           Text('J Nikky Feat Sensei',
             style: TextStyle(
                 color: Colors.white54,
                 fontSize: 12.0,
                 fontWeight: FontWeight.w500
             ),),
           SizedBox(
             height: 80.0,
           ),
           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
             IconButton(
               icon: Icon(Icons.fast_rewind,
               color: Colors.white,),
               onPressed: (){},
             ),
             Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(30.0)),
                 color: Colors.pinkAccent,
                 boxShadow: [BoxShadow(
                   color: Colors.grey.withOpacity(0.7),
                   blurRadius: 10.0,
                   spreadRadius: 0.0,

                 )]
                 ),
                  child: IconButton(icon: Icon(Icons.play_arrow),
                  color: Colors.white,
                  onPressed: (){},),
               ),
             IconButton(
               icon: Icon(Icons.fast_forward,
               color: Colors.white,),
               onPressed: (){},
             ),
           ],),
           SizedBox(
             height: 20.0,
           ),
           Slider(
             value: 150.0,
             activeColor: Colors.pinkAccent,
             inactiveColor:Colors.grey ,
             onChanged: null,
             min: 100,
             max: 200,
           )
         ],

        ),
),
    );
  }
}
