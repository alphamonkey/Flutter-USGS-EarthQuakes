class FeatureCollection {
  final String type;
  final FeatureMetaData metadata;
  final List<Feature> features;
  const FeatureCollection({
    required this.type,
    required this.metadata,
    required this.features,
  });



  factory FeatureCollection.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'type': String type,
      } =>
        FeatureCollection(
          type: type,
          metadata: FeatureMetaData.fromJson(json['metadata']),
          features: List<Feature>.from(json['features'].map((model)=> Feature.fromJson(model))),
        ),
      _ => throw const FormatException('Failed to load features.'),
    };
  }

}


class FeatureMetaData {
  final int generated;
  final String url;
  final String title;
  final int status;
  final String api;
  final int count;

  const FeatureMetaData({
    required this.generated,
    required this.url,
    required this.title,
    required this.status,
    required this.api,
    required this.count
  });

  factory FeatureMetaData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'generated': int generated,
        'url':String url,
        'title':String title,
        'status':int status,
        'api':String api,
        'count':int count,
      } =>
        FeatureMetaData(
          generated: generated,
          url: url,
          title: title,
          status: status,
          api: api,
          count: count
        ),
      _ => throw const FormatException('Unable to load features.'),
    };
  }

}
  class FeatureProperties {
    final String place;
    final double? mag;
    final int time;
    final int updated;
    final int? tz;
    final String url;
    final int? felt;
    final double? cdi;
    final double? mmi;
    final String? alert;
    final String status;
    final int? tsunami;
    final int sig;
    final String code;
    final String sources;
    final String types;
    final int? nst;
    final double? dmin;
    final double? rms;
    final double? gap;
    final String? magtype;

    const FeatureProperties({
      required this.place,
      required this.mag,
      required this.time,
      required this.updated,
      required this.tz,
      required this.url,
      required this.felt,
      required this.cdi,
      required this.mmi,
      required this.alert,
      required this.status,
      required this.tsunami,
      required this.sig,
      required this.code,
      required this.sources,
      required this.types,
      required this.nst,
      required this.dmin,
      required this.rms,
      required this.gap,
      required this.magtype,

    });

    factory FeatureProperties.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'place': String place,
        'mag':num? mag,
        'time':int time,
        'updated': int updated,
        'tz':int? tz,
        'url':String url,
        'felt':int? felt,
        'cdi':num? cdi,
        'mmi':num? mmi,
        'alert':String? alert,
       'status':String status,
        'tsunami':int? tsunami,
        'sig':int sig,
        'code':String code,
        'sources':String sources,
        'types':String types,
        'nst':int? nst,
        'dmin':num? dmin,
        'rms':num? rms,
        'gap':num? gap,
        'magType':String? magtype,

      } =>
        FeatureProperties(
          place: place,
          mag: mag?.toDouble(),
          time: time,
          updated: updated,
          tz: tz,
          url: url,
          felt: felt,
          cdi: cdi?.toDouble(),
          mmi: mmi?.toDouble(),
          alert: alert,
          status: status,
          tsunami: tsunami,
          sig: sig,
          code: code,
          sources: sources,
          types: types,
          nst: nst,
          dmin: dmin?.toDouble(),
          rms: rms?.toDouble(),
          gap: gap?.toDouble(),
          magtype: magtype,
          
        ),
      _ => throw const FormatException('Unable to load features.'),
    };
  }
  }
  class FeatureGeometry {
    final String type;
    final List<num> coordinates;

    const FeatureGeometry({
      required this.type,
      required this.coordinates,
    });

    factory FeatureGeometry.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'type': String type,
      } =>
        FeatureGeometry(
          type: type,
          coordinates: List<num>.from(json['coordinates']),
        ),
      _ => throw const FormatException('Unable to load features.'),
    };
  }
  }
  class Feature {
    final String type;
    final String id;
    final FeatureProperties properties;
    final FeatureGeometry geometry;
    
    const Feature({
      required this.type,
      required this.id,
      required this.properties,
      required this.geometry,
    });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'type': String type,
        'id':String id,

      } =>
        Feature(
          type: type,
          id: id,
          properties: FeatureProperties.fromJson(json['properties']),
          geometry: FeatureGeometry.fromJson(json['geometry']),
        ),
      _ => throw const FormatException('Unable to load features.'),
    };
  }

  }