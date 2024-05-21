class Cart {
  static final Cart _instance = Cart._internal();
  final List<int> _cartItemIds = [];

  factory Cart() {
    return _instance;
  }

  Cart._internal();

  void addItem(int perfumeId) {
    _cartItemIds.add(perfumeId);
  }

  void removeItem(int perfumeId) {
    _cartItemIds.remove(perfumeId);
  }

  List<int> get items => _cartItemIds;
}