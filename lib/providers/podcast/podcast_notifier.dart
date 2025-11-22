import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_demo/providers/podcast/poscast_state.dart';
import 'package:podcast_demo/services/api_service.dart';

import '../../data/api_client.dart';

class PodcastNotifier extends Notifier<PodcastState> {
  @override
  PodcastState build() {
    _loadPodcasts();
    return PodcastState();
  }

  Future<void> _loadPodcasts() async {
    state = state.copyWith(loading: true, error: null);

    try {
      final response = await ref.read(apiServiceProvider).getRecentPodCast();

      state = state.copyWith(loading: false, response: response, error: null);
    } catch (e) {
      final message = getErrorMessage(e);

      state = state.copyWith(loading: false, error: message);
    }
  }

  Future<void> getPodcast() async {
    return _loadPodcasts();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void searchEpisodes(String query) {
    final allEpisodes = state.response?.data.data.episodes ?? [];

    final filtered = allEpisodes
        .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = state.copyWith(searchQuery: query, filteredEpisodes: filtered);
  }
}

final podcastProvider = NotifierProvider<PodcastNotifier, PodcastState>(
  PodcastNotifier.new,
);
