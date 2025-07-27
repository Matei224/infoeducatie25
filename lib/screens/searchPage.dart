import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:google_sign_in/google_sign_in.dart" show GoogleSignIn;
import "package:shared_preferences/shared_preferences.dart";
import "package:studee_app/data/database.dart";
import "package:studee_app/data/university.dart";
import "package:studee_app/data/university/univeristy_full.dart";
import "package:studee_app/widgets/model/universityWidget.dart";
import "package:studee_app/widgets/filteringrow.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  List<ActualUniveristy>? univs;
  bool isLoading = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<Filter, String> filters = {
    Filter.programme: '',
    Filter.location: '',
    Filter.degree: '',
  };

  @override
  void initState() {
    super.initState();
    fetchUniversitiesFromDatabase(
      '',
      filters,
    ); 
  }


 Future<void> _saveSearchQuery(String query) async {
    if (query.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList('searchHistory') ?? [];
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
      if (searchHistory.length > 5) {
        searchHistory.removeAt(0);
      } 
      await prefs.setStringList('searchHistory', searchHistory);
    }
  }

  void onSelectDegree(String? x) {
    setState(() {
      if (x == null) {
        filters[Filter.degree] = '';
      } else {
        filters[Filter.degree] = x;
      }
    });
    fetchUniversitiesFromDatabase('', filters);
  }
  

  void onSelectLocation(String? x) {
    setState(() {
      if (x == null) {
        filters[Filter.location] = '';
      } else {
        filters[Filter.location] = x;
      }
    });
    fetchUniversitiesFromDatabase('', filters);
  }

  void onSelectProgramme(String? x) {
    setState(() {
      if (x == null) {
        filters[Filter.programme] = '';
      } else {
        filters[Filter.programme] = x;
      }
    });
    fetchUniversitiesFromDatabase('', filters);
  }

  Future<void> fetchUniversitiesFromDatabase(
    String query,
    Map<Filter, String> filters,
  ) async {
    setState(() {
      isLoading = true; 
    });
    try {
        await _saveSearchQuery(query);

      final fetchedUniversities = await DatabaseHelper.instance
          .searchUniversities(query, filters);
      setState(() {
        univs = fetchedUniversities;
        isLoading = false; 
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(univs);
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.2),
                borderRadius: BorderRadius.circular(8.0), 
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 6),
                child: TextField(
                  textAlignVertical: TextAlignVertical(y: 0.2),
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 166, 159, 139),
                      fontSize: 16,
                    ),
                  ),
                  controller: _controller,
                  onTapOutside:
                      (event) => FocusManager.instance.primaryFocus!.unfocus(),
                  decoration: InputDecoration(
                    suffixIcon: Icon(CupertinoIcons.search),
                    hintText: "Search for a university",
                    hintStyle: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 166, 159, 139),
                        fontSize: 16,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (e) {
                    fetchUniversitiesFromDatabase(e, filters);
                  }, 
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Filter by",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 166, 159, 139),
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          
 Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: FilterRow(
              filter: filters,
              onSelectDegree: onSelectDegree,
              onSelectProgramme: onSelectProgramme,
              onSelectLocation: onSelectLocation,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 330,
            height: 0.5,
            color: Color.fromARGB(255, 166, 159, 139),
          ),
          const SizedBox(height: 15),
          if (!isLoading && univs != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${univs!.length} found",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),

          Expanded(
            child:
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(),
                    ) 
                    : univs == null
                    ? const Center(
                      child: Text("No data available"),
                    ) 
                    : ListView.builder(
                      itemCount: univs!.length,
                      itemBuilder: (context, index) {
                        return UniversityWidget(data: univs![index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
