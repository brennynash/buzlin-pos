import '../data/transaction_data.dart';

class TransactionsResponse {
  TransactionsResponse({
    String? timestamp,
    bool? status,
    String? message,
    List<TransactionData>? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  TransactionsResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
   if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TransactionData.fromJson(v));
      });
    }
  }

  String? _timestamp;
  bool? _status;
  String? _message;
   List<TransactionData>? _data;

  TransactionsResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
     List <TransactionData>? data,
  }) =>
      TransactionsResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

   List<TransactionData>?  get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
     if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}


