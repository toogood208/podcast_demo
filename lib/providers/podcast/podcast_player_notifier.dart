import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

import '../../models/podcast_response.dart';

class PodcastPlayerNotifier extends Notifier<PodcastPlayerState> {
  late AudioPlayer _player;

  @override
  PodcastPlayerState build() {
    _player = AudioPlayer();
    _setupListeners();
    return PodcastPlayerState.initial();
  }

  void _setupListeners() {
    _player.durationStream.listen((d) {
      if (d != null) {
        state = state.copyWith(total: d);
      }
    });

    _player.positionStream.listen((p) {
      state = state.copyWith(position: p);
    });
  }

  Future<void> load(List<Episode> episodes, int index) async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    state = state.copyWith(
      episodes: episodes,
      currentIndex: index,
      currentEpisode: episodes[index],
    );

    await _player.setUrl(episodes[index].contentUrl);
    play();
  }

  void play() => _player.play();
  void pause() => _player.pause();

  void skipForward() => _player.seek(_player.position + Duration(seconds: 10));

  void skipBackward() => _player.seek(_player.position - Duration(seconds: 10));

  Future<void> next() async {
    if (state.currentIndex < state.episodes.length - 1) {
      load(state.episodes, state.currentIndex + 1);
    }
  }

  Future<void> previous() async {
    if (state.currentIndex > 0) {
      load(state.episodes, state.currentIndex - 1);
    }
  }
}

class PodcastPlayerState {
  final Duration position;
  final Duration total;
  final Episode? currentEpisode;
  final List<Episode> episodes;
  final int currentIndex;

  PodcastPlayerState({
    required this.position,
    required this.total,
    required this.currentEpisode,
    required this.episodes,
    required this.currentIndex,
  });

  factory PodcastPlayerState.initial() => PodcastPlayerState(
    position: Duration.zero,
    total: Duration.zero,
    currentEpisode: null,
    episodes: [],
    currentIndex: 0,
  );

  PodcastPlayerState copyWith({
    Duration? position,
    Duration? total,
    Episode? currentEpisode,
    List<Episode>? episodes,
    int? currentIndex,
  }) {
    return PodcastPlayerState(
      position: position ?? this.position,
      total: total ?? this.total,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      episodes: episodes ?? this.episodes,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

final podcastPlayerProvider =
    NotifierProvider<PodcastPlayerNotifier, PodcastPlayerState>(
      PodcastPlayerNotifier.new,
    );
