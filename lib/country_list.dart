import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> fallbackCountries = [
  'United States',
  'Canada',
  'United Kingdom',
  'India',
  'Australia',
  'Germany',
  'France',
  'Japan',
  'China',
  'Brazil',
  'South Korea',
  'Italy',
  'Spain',
  'Russia',
  'Mexico',
  'Indonesia',
  'Turkey',
  'Netherlands',
  'Switzerland',
  'Sweden',
];

Future<List<String>> fetchCountries() async {
  final response = await http.get(
    Uri.parse('https://restcountries.com/v3.1/all?fields=name'),
  );

  if (response.statusCode == 200) {
    List<dynamic> countriesJson = json.decode(response.body);
    List<String> countryList = countriesJson
        .map((country) => country['name']['common'] as String)
        .toList();
    return countryList;
  } else {
    // Return empty list so fallback is used if API fails with other errors
    throw Exception('Failed to load countries: ${response.statusCode}');
  }
}
