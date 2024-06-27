import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:nytimes_view_portal/models/score.dart';

class NewsRepository {

    Future<CategoriesNewsModel> fetchNewsCategoires(String category) async {
        String newsUrl =
            'https://api.nytimes.com/svc/topstories/v2/$category.json?api-key=es3nZxn1CrQEVlfGPBTGkgJvAP0Gt6xI';
        final response = await http.get(Uri.parse(newsUrl));
        if (response.statusCode == 200) {
            final body = jsonDecode(response.body);
            return CategoriesNewsModel.fromJson(body);
        } else {
            throw Exception('Error');
        }
    }

}
