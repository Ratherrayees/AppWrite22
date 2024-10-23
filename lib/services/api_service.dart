// this is lib/services/api_service.dart
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/initializer.dart';
import 'package:myapp/models/feedback_model.dart';
import 'package:myapp/models/order_model.dart';
import 'package:myapp/models/pre_order_model.dart';
import 'package:myapp/models/product_model.dart';


class ApiService {
  final Client _client;
  final Databases _databases;

  ApiService(this._client) : _databases = Databases(_client);

  Future<List<ProductModel>> getProducts() async {
    final response = await _databases.listDocuments(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'products',
    );
    return response.documents.map((doc) => ProductModel(
      id: doc.$id,
      name: doc.data['name'],
      price: doc.data['price'],
      description: doc.data['description'],
    )).toList();
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final allProducts = await getProducts(); // Fetch all products
    return allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList(); // Filter based on query
  }

  Future<OrderModel> placeOrder(List<ProductModel> items) async {
    final response = await _databases.createDocument(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'orders',
      data: {
        'items': items.map((item) => item.id).toList(),
        'status': 'pending',
      },
      documentId: 'unique_document_id', // Add a unique document ID here
    );
    return OrderModel(
      id: response.$id,
      items: items,
      status: 'pending',
    );
  }

  Future<OrderModel> scheduleOrder(List<ProductModel> items, DateTime scheduledTime) async {
    final response = await _databases.createDocument(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'orders',
      data: {
        'items': items.map((item) => item.id).toList(),
        'status': 'scheduled',
        'scheduledTime': scheduledTime.toIso8601String(),
      },
      documentId: 'unique_document_id', // Add a unique document ID here
    );
    return OrderModel(
      id: response.$id,
      items: items,
      status: 'scheduled',
      scheduledTime: scheduledTime,
    );
  }

  Future<OrderModel> getOrder(String orderId) async {
    final response = await _databases.getDocument(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'orders',
      documentId: orderId,
    );
    return OrderModel(
      id: response.$id,
      items: response.data['items'].map((id) => ProductModel(id: id, name: '', price: 0)).toList(),
      status: response.data['status'],
      scheduledTime: DateTime.parse(response.data['scheduledTime']),
    );
  }

  Future<FeedbackModel> submitFeedback(String orderId, int rating, String review) async {
    final response = await _databases.createDocument(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'feedback',
      data: {
        'orderId': orderId,
        'rating': rating,
        'review': review,
      },
      documentId: 'unique_document_id', // Add a unique document ID here
    );
    return FeedbackModel(
      id: response.$id,
      orderId: orderId,
      rating: rating,
      review: review,
    );
  }

  Future<List<FeedbackModel>> getFeedback(String orderId) async {
    final response = await _databases.listDocuments(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'feedback',
      queries: [Query.equal('orderId', orderId)],
    );
    return response.documents.map((doc) => FeedbackModel(
      id: doc.$id,
      orderId: doc.data['orderId'],
      rating: doc.data['rating'],
      review: doc.data['review'],
    )).toList();
  }

  Future<PreOrderModel> schedulePreOrder(List<ProductModel> items, DateTime scheduledTime) async {
    final response = await _databases.createDocument(
      databaseId: 'gulposhdatabase', // Add your database ID here
      collectionId: 'preorders',
      data: {
        'items': items.map((item) => item.id).toList(),
        'scheduledTime': scheduledTime.toIso8601String(),
      },
      documentId: 'unique_document_id', // Add a unique document ID here
    );
    return PreOrderModel(
      id: response.$id,
      items: items,
      scheduledTime: scheduledTime,
    );
  }

  Future<void> syncOfflineData(List<OrderModel> offlineOrders) async {
    for (var order in offlineOrders) {
      await _databases.createDocument(
        databaseId: 'gulposhdatabase', // Add your database ID here
        collectionId: 'orders',
        data: {
          'items': order.items.map((item) => item.id).toList(),
          'status': order.status,
          'scheduledTime': order.scheduledTime?.toIso8601String(),
        },
        documentId: 'unique_document_id_${order.id}', // Generate a unique document ID
      );
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  final client = ref.watch(clientProvider); // Ensure clientProvider is defined
  return ApiService(client);
});