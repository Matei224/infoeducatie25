int partition(List<int> list, low, high) {
  return -1;
}

List<int> quickSort(List<int> list, int low, int high) {
  if (low < high) {
    int pi = partition(list, low, high);
    quickSort(list, low, pi - 1);
    quickSort(list, pi + 1, high);
  }
  return list;
}
