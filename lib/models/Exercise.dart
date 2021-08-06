// generic class for an exercise 
// meant to be extended for specific exercises
class Exercise {
  final String name;

  Exercise({this.name});

  // method that is overriden by subclasses based on type of exercise
  Map<String, dynamic> toJson() => {'name': name};
}
