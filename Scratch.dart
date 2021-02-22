import 'dart:io';

void main(){
  work();
}

void work() {
  int number = 72;

  int first = (number/60).floor();
  int second = number%60;

    print('$first   :  $second');

    if(second.toString().length == 1) {
      print(second * 10);
    }
      else{
        print(second);
    }

  (second.toString().length == 1)?print(second * 10): print(second);



    }

