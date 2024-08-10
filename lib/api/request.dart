class ApiRequest<T> {
  final T params;

  ApiRequest({required this.params});

  Map<String, dynamic> toJson() {
    return {
      'params': params
    };
  }
}