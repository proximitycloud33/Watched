import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String type;
  final String? title;
  final String? posterPath;
  final String? overview;

  const WatchlistTable({
    required this.id,
    required this.type,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory WatchlistTable.fromEntity(Watchlist watchlist) => WatchlistTable(
        id: watchlist.id,
        type: watchlist.type,
        title: watchlist.title,
        posterPath: watchlist.posterPath,
        overview: watchlist.overview,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        type: map['type'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Watchlist toEntity() => Watchlist(
        id: id,
        type: type,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, type, title, posterPath, overview];
}
