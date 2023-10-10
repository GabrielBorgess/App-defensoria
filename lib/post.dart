class Post {
  final String msg;
  final String token;

  Post({
    required this.msg,
    required this.token,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      msg: json['msg'] ?? '', // Se 'msg' for nulo, use uma string vazia
      token: json['token'] ?? '', // Se 'token' for nulo, use uma string vazia
    );
  }
}
