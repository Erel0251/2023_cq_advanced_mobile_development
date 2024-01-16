class Tokens {
  final DetailToken access;
  final DetailToken refresh;

  const Tokens({
    required this.access,
    required this.refresh,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      access: DetailToken.fromJson(json['access']),
      refresh: DetailToken.fromJson(json['refresh']),
    );
  }
}

class DetailToken {
  final String token;
  final String expires;

  const DetailToken({
    required this.token,
    required this.expires,
  });

  factory DetailToken.fromJson(Map<String, dynamic> json) {
    return DetailToken(
      token: json['token'],
      expires: json['expires'],
    );
  }
}
