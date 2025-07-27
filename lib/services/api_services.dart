import "dart:convert";

import "package:http/http.dart" as http;
import "package:studee_app/data/university.dart";

class ApiServices
{
  Future<List<University>?> getUniversities() async {
    var client = http.Client();

    var uri = Uri.parse('http://universities.hipolabs.com/search?name?');
    var response = await client.get(uri);
    if(response.statusCode == 200)
    {
      var json = response.body;
      return universityFromJson(json);
    } else {
      print('Failed to load universities: ${response.statusCode}');
      return null;
    }
  
  }




  Future<Map<String, dynamic>?> getUniversityImage(String universityName) async {
    try {
    var searchUrl = '''https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=
    ${Uri.encodeComponent(universityName)}&format=json''';
    var searchResponse = await http.get(Uri.parse(searchUrl));
    var searchData = json.decode(searchResponse.body);
    if (searchData['query']['search'].isEmpty) {
      print('No Wikipedia page found for $universityName');
      return null;
    }
    var pageTitle = searchData['query']['search'][0]['title'];
    print('Found page title: $pageTitle');

    var wikidataUrl = '''https://en.wikipedia.org/w/api.php?action=query&prop=pageprops&tit
    les=${Uri.encodeComponent(universityName)}&format=json''';
    var wikidataResponse = await http.get(Uri.parse(wikidataUrl));
    var wikidataData = json.decode(wikidataResponse.body);
    var pages = wikidataData['query']['pages'];
    var pageId = pages.keys.first;
    var wikidataId = pages[pageId]['pageprops']?['wikibase_item'];
    if (wikidataId == null) {
      print('No Wikidata ID found for $pageTitle');
      return null;
    }
    print('Wikidata ID: $wikidataId');


    var entityUrl = '''https://www.wikidata.org/w/api.php?action=wbgetentities&ids=$wikidataId
    &props=claims&format=json''';
    var entityResponse = await http.get(Uri.parse(entityUrl));
    var entityData = json.decode(entityResponse.body);
    var claims = entityData['entities'][wikidataId]['claims'];

    String? logoName;
    String? imageName;
    if (claims.containsKey('P154')) {
      logoName = claims['P154'][0]['mainsnak']['datavalue']['value'];
      print('Found logo image: $logoName');
    } else if (claims.containsKey('P18')) { 
      imageName = claims['P18'][0]['mainsnak']['datavalue']['value'];
      print('Found general image: $imageName');
    }
var imageUrl;
var logoUrl;
    var url = [];
    if (logoName != null) {
      logoUrl = '''https://commons.wikimedia.org/wiki/Special:FilePath/${Uri.encodeComponent(logoName)}
      ?width=300''';
      print('Logo URL: $logoUrl');
      url.add(logoUrl);
     
    } 
    print('No image found in Wikidata for $universityName');
  
     if (imageName != null) {
      imageUrl = 'https://commons.wikimedia.org/wiki/Special:FilePath/${Uri.encodeComponent(imageName)}?width=300';
      print('Image URL: $imageUrl');
      url.add(imageUrl);
    } 
    print('No image found in Wikidata for $universityName');

    return {'logoUrl': logoUrl, 'imageUrl': imageUrl};

  } catch (e) {
    print('Error fetching image for $universityName: $e');
          return {'logoUrl': '', 'imageUrl': ''};

  }




  }


}