import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:studee_app/data/university_data.dart';
import 'dart:async';

import 'package:studee_app/services/api_services.dart';

// API key for OpenRouter
final apiKey = 'not';


  Future<String> getOpenRouterResponse(String userInput) async {
  const endpoint ='https://openrouter.ai/api/v1/chat/completions';

  final headers = {
'Authorization':'Bearer $apiKey',
'Content-type':'application/json',
  };

  final body = jsonEncode({
    'model':'deepseek/deepseek-chat-v3-0324:free',
    'prompt':userInput,
    'max_tokens':2000,
    'temperature':0.7,
  });

  final response = await http.post(
    Uri.parse(endpoint),
    headers:headers,
    body:body,
  );

  if(response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['text'];
  } else {
    throw Exception('Failed to get repsonse : ${response.body}');
  }
}
// Questionnaire template
const String questionnaire = '''
**Academics category**
-Graduation rate:
-Employabillity rate:
-Retention Rate:
-Rank:
-Extracurricular Clubs enumerate:
-Undergraduate programmes available number and list:
-Description of Academics (make it longer):
-Home page university website:
-maps location link:

**Costs category**
-Average cost per Year:
-Students Receiving Financial Aid percentage:
-Opened Financial Aid Application date:

**Life category**
-Housing Found Rate by students:
-Housing price per year:
-Taxes cost per year:
-Supplies cost per year:
-Description of life in the city of university (make it longer):
-Costs page university website:
-maps location link:
-Link to numbeo website for that city of university with prices for property:
-Link to numbeo website for that city of university with prices for good and services:
-Link to numbeo website for that city of university with prices for and food prices:

**Admissions category**
-Acceptance Rate:
-English Requirements: Yes/No, exam type minimum
-Other languages: Yes – which – exam type minimum/No
-Exam based: Yes – at which subjects/No
-Portfolio based: Yes/No
-Which BAC is needed:
-Average GPA entry:
-Average applicants number:
-Admission dates for next year: Know – which / Unknown
-Description of admissions (make it longer):
-Admissions page university:
-maps location link:

**Campus category**
-Safety Rate:
-Average students in campus number:
-Cost per year of campus:
-Description (make it longer):
-Campus page university link:
-maps location link:
-Link to numbeo website for that city of university with crime:
-Link to numbeo website for that city of university with safety:
''';

// Fetch response from OpenRouter API

// Main function to update the database
void main() async {
 
  
  var i=0;
  // Process each university
 

   
      // Construct the prompt
      final prompt = "Search on https://www.epfl.ch/en/ and École polytechnique other websites relevant to  and complete this questionnaire in English only with the actual data required after ':' ; $questionnaire";

      // Get and parse the API response
      final response = await getOpenRouterResponse(prompt);
      final data = parseData1(response);
      // Create structured objects
      final academics = createAcademics(data["Academics category"] ?? {});
      final costs = createCosts(data["Costs category"] ?? {});
      final life = createLife(data["Life category"]?? {});
      final admissions = createAdmissions(data["Admissions category"] ?? {});
      final campus = createCampus(data["Campus category"] ?? {});

      // Prepare update values
      print(life.numbeoFoodPricesUrl);
    
    // Delay to respect API rate limits
 

  // Close the database
  print('Database update completed.');
}