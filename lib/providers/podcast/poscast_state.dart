import '../../models/podcast_response.dart';

class PodcastState {
  final bool loading;
  final String? error;
  final LatestEpisodesResponse? response;
  final String searchQuery;
  final List<Episode> filteredEpisodes;

  PodcastState({
    this.loading = false,
    this.error,
    this.response,
    this.searchQuery = '',
    this.filteredEpisodes = const [],
  });

  PodcastState copyWith({
    bool? loading,
    String? error,
    LatestEpisodesResponse? response,
    String? searchQuery,
    List<Episode>? filteredEpisodes,
  }) {
    return PodcastState(
      loading: loading ?? this.loading,
      error: error,
      response: response ?? this.response,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredEpisodes: filteredEpisodes ?? this.filteredEpisodes,
    );
  }
}
