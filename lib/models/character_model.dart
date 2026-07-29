import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String locationName;
  final List<String> episode;
  final String created;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
    required this.episode,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? 'Unknown',
      species: json['species'] as String? ?? '',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      image: json['image'] as String? ?? '',
      originName: (json['origin'] as Map<String, dynamic>?)?['name'] as String? ??
          'Unknown',
      locationName:
          (json['location'] as Map<String, dynamic>?)?['name'] as String? ??
              'Unknown',
      episode: (json['episode'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      created: json['created'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'origin': {'name': originName},
      'location': {'name': locationName},
      'episode': episode,
      'created': created,
    };
  }

  int get episodeCount => episode.length;

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        originName,
        locationName,
        episode,
        created,
      ];
}
