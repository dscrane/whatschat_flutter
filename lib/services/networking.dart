import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.username, this.password);
  final username;
  final password;

  Future getData() async {
    http.Response res = await http.post(
      Uri.parse(
        'http://localhost:5500/login-user',
      ),
      body: {username: username, password: password},
      headers: {
        'Access-Control-Allow-Origin': "http://localhost:5500/*",
        'Content-Security-Policy': "default-src *",
      },
    );
    print(res);
    if (res.statusCode == 200) {
      String data = res.body;
      // return jsonDecode(data);
    } else {
      print(res.statusCode);
    }
  }
}
