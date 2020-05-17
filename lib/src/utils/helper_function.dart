import 'dart:collection';

extension Unique<T> on List<T>{
  List<T> unique<S>(S Function(T) uniqueArg){
    HashSet<S> hashSet = HashSet<S>();
    List<T> outputList = <T>[];
    this.forEach((item) {
      S uniqueTrait = uniqueArg(item);
      if(!hashSet.contains(uniqueTrait)){
        hashSet.add(uniqueTrait);
        outputList.add(item);
      }
    });
    print(hashSet);
    return outputList;
  }
}