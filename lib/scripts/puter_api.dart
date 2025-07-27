import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> callPuterApi(String query, String contextUrl) async {
  final url = Uri.parse('https://api.puter.com/ai/chat'); 
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'query': query,
      'context': contextUrl,
    }),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['response']; 
  } else {
    return 'Unknown';
  }
}
void main() async{
  final money = await callPuterApi("From this webpage, what is the tuition cost?", 'https://www.epfl.ch/en/');
  final duration = await callPuterApi("What is the duration of programs at this university?", 'https://www.epfl.ch/en/');
  final language = await callPuterApi("What are the language requirements", 'https://www.epfl.ch/en/');

  print(money.toString());
  print({duration});print({language});
}