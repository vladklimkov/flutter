import 'package:hive/hive.dart';
part 'score.g.dart';

class CategoriesNewsModel {
    String? status;
    int? num_results;
    List<Articles>? results;

    CategoriesNewsModel({this.status, this.num_results, this.results});

    CategoriesNewsModel.fromJson(Map<String, dynamic> json) {
        status = json['status'];
        num_results = json['num_results'];
        if (json['results'] != null) {
        results = <Articles>[];
        int i = 0;
        json['results'].forEach((v) {
            results!.add(new Articles.fromJson(v, i));
            i++;
        });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['status'] = this.status;
        data['num_results'] = this.num_results;
        if (this.results != null) {
        data['results'] = this.results!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

// https://docs.hivedb.dev/#/custom-objects/generate_adapter
@HiveType(typeId: 0)
class Articles {
    @HiveField(0)
    int? id;

    @HiveField(1)
    String? section;

    @HiveField(2)
    String? subsection;

    @HiveField(3)
    String? title;

    @HiveField(4)
    String? abstract;

    @HiveField(5)
    String? url;

    @HiveField(6)
    String? uri;

    @HiveField(7)
    String? byline;

    @HiveField(8)
    String? item_type;

    @HiveField(9)
    String? updated_date;

    @HiveField(10)
    String? created_date;

    @HiveField(11)
    String? published_date;

    @HiveField(12)
    String? material_type_facet;

    @HiveField(13)
    String? kicker;

    @HiveField(14)
    List<String>? multimedia;

    Articles(
        {this.id,
        this.section,
        this.subsection,
        this.title,
        this.abstract,
        this.url,
        this.uri,
        this.byline,
        this.item_type,
        this.updated_date,
        this.created_date,
        this.published_date,
        this.material_type_facet,
        this.kicker,
        this.multimedia});

    Articles.clone(Articles other) 
        : this.id = other.id
        , this.section = other.section
        , this.subsection = other.subsection
        , this.title = other.title
        , this.abstract = other.abstract
        , this.url = other.url
        , this.uri = other.uri
        , this.byline = other.byline
        , this.item_type = other.item_type
        , this.updated_date = other.updated_date
        , this.created_date = other.created_date
        , this.published_date = other.published_date
        , this.material_type_facet = other.material_type_facet
        , this.kicker = other.kicker
        , this.multimedia = other.multimedia;

    Articles.fromJson(Map<String, dynamic> json, int id_in) {
        id = id_in;
        section = json['section'];
        subsection = json['subsection'];
        title = json['title'];
        abstract = json['abstract'];
        url = json['url'];
        uri = json['uri'];
        byline = json['byline'];
        item_type = json['item_type'];
        updated_date = json['updated_date'];
        created_date = json['created_date'];
        published_date = json['published_date'];
        material_type_facet = json['material_type_facet'];
        kicker = json['kicker'];
        var mtm = json["multimedia"];
        multimedia = [];
        if (mtm != null) {
            for (var i = 0; i < mtm.length; ++i) {
                multimedia!.add(mtm[i]["url"]);
            }
        } else {
            multimedia!.add("#");
        }
        print(id);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['section'] = this.section;
        data['subsection'] = this.subsection;
        data['title'] = this.title;
        data['abstract'] = this.abstract;
        data['url'] = this.url;
        data['uri'] = this.uri;
        data['byline'] = this.byline;
        data['item_type'] = this.item_type;
        data['updated_date'] = this.updated_date;
        data['created_date'] = this.created_date;
        data['published_date'] = this.published_date;
        data['material_type_facet'] = this.material_type_facet;
        data['kicker'] = this.kicker;
        return data;
    }
}
