class QuestionsListLogic {
  static List<int> _fibonacciNumbers = List<int>();

  static int _nextFibonacci(int n) => n <= 2 ? 1 : _nextFibonacci(n - 2) + _nextFibonacci (n - 1);

  static int _uniqueFibonacci(int index) {
    var nextNumber = _nextFibonacci(index);
    var alreadyExists = _fibonacciNumbers.indexOf(nextNumber) > -1;

    if(alreadyExists) {
      return _uniqueFibonacci(index +1);
    }
    return nextNumber;
  }

  int fibonacci(int index)
  {
    if(_fibonacciNumbers.length <= index) {
      _fibonacciNumbers.add(_uniqueFibonacci(index));
    }
    return _fibonacciNumbers[index];
  }

  final List<String> emojis = '😀,😁,😂,🤣,😃,😄,😅,😆,😉,😊,😋,😎,😍,😘,🥰,😗,😙,😚,☺️,🙂,🤗,🤩,🤔,🤨,😐,😑,😶,🙄,😏,😣,😥,😮,🤐,😯,😪,😫,😴,😌,😛,😜,😝,🤤,😒,😓,😔,😕,🙃,🤑,😲,☹️,🙁,😖,😞,😟,😤,😢,😭,😦,😧,😨,😩,🤯,😬,😰,😱,🥵,🥶,😳,🤪,😵,😡,😠,🤬,😷,🤒,🤕,🤢,🤮,🤧,😇,🤠,🤡,🥳,🥴,🥺,🤥,🤫,🤭,🧐,🤓,😈,👿,👹,👺,💀,👻,👽,🤖,💩,😺,😸,😹,😻,😼,😽,🙀,😿,😾'.split(',').toList(growable: false);
}