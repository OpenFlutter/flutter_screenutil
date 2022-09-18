extension ContextExtension on BuildContext {
  //you can get this size using "context"
  //for example
  //context.size ->  screen sizes 
  Size get size => MediaQuery.of(this).size;
  
  //context.sW  ->  screen width 
  double get sW => MediaQuery.of(this).size.width;
  
  //context.sW  ->  screen height  
  double get sH => MediaQuery.of(this).size.height;

  
  //get any part of screen size , you can use dynamic sizes
  
  //context.dynamicW(.5)  ->  half part of screen width 
  double dynamicW(double value) => MediaQuery.of(this).size.width * value;
  
  //context.dynamicH(.5)  ->  half part of screen height 
  double dynamicH(double value) => MediaQuery.of(this).size.height * value;
}
