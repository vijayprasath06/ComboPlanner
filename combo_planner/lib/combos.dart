void main() {
  List<List<int>> generateCombinations(List<int> list, int maxLen) {
    List<List<int>> result = [];
    void combine(int start, List<int> current) {
      if (current.isNotEmpty) result.add(List.from(current));
      if (current.length == maxLen) return;
      for (int i = start; i < list.length; i++) {
        current.add(list[i]);
        combine(i + 1, current);
        current.removeLast();
      }
    }
    combine(0, []);
    return result;
  }
  print(generateCombinations([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15], 3).length);
}
