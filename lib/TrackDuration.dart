
class TrackDuration{

  int minute;
  int second;
  Duration duration = Duration();


  void changeDuration (int time){
    Duration duration = Duration(milliseconds: time);

    minute = duration.inMinutes;
    second = duration.inSeconds - (duration.inMinutes * 60);

  }
}