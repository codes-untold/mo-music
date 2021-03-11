import 'dart:io';

void main(){
  work();
}

void work() {



  int count = 181824;
  int second;
  Duration duration = Duration(milliseconds: count);



  print(duration.inMinutes);
  print((duration.inSeconds) - (duration.inMinutes * 60));


    }

