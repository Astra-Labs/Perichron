// A 'interfacing' class that allows you to read, write, and remove items 
// from the lower level storage implementation. Currently this is FlutterSecureStorage, 
// and in the future will be replaced with an internal P2P implementation to cross 
// connect resources within Astra. 

class PerichronStorageLayer {
  /// Create storage variables
  final storage = const FlutterSecureStorage();

  /// Add item to storage layer
  Future<void> addItem(String key, String content) async {
    await storage.write(key: key, value: content);
  }

  /// Remove item from storage layer
  Future<void> removeItem(String key) async {
    await storage.delete(key: key);
  }

  /// Read item from storage layer
  Future<String?> readItem(String key) async {
    var item = await storage.read(key: key);
    return item;
  }
}