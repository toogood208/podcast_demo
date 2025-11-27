import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcast_demo/models/podcast_response.dart';

class PodcastPlayerScreen extends ConsumerStatefulWidget {
  const PodcastPlayerScreen({
    super.key,
    required this.episode,
    required this.episodes,
  });

  final Episode episode;
  final List<Episode> episodes;

  @override
  ConsumerState<PodcastPlayerScreen> createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends ConsumerState<PodcastPlayerScreen> {
  late AudioPlayer _player;

  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  late Episode currentEpisode;

  int currentIndex = 0;

  void _playNext() {
    if (currentIndex < widget.episodes.length - 1) {
      currentIndex++;
      _loadEpisode(widget.episodes[currentIndex]);
    }
  }

  void _playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      _loadEpisode(widget.episodes[currentIndex]);
    }
  }

  Future<void> _loadEpisode(Episode ep) async {
    setState(() => currentEpisode = ep);
    await _player.setUrl(ep.contentUrl);
    _player.play();
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    currentEpisode = widget.episode;

    _initAudio();
  }

  Future<void> _initAudio() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    await _player.setUrl(widget.episode.contentUrl);

    _player.durationStream.listen((d) {
      if (d != null) {
        setState(() => _totalDuration = d);
      }
    });

    _player.positionStream.listen((p) {
      setState(() => _currentPosition = p);
    });
  }

  void _play() => _player.play();
  void _pause() => _player.pause();
  void _skipForward() => _player.seek(_player.position + Duration(seconds: 10));
  void _skipBackward() =>
      _player.seek(_player.position - Duration(seconds: 10));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B9B6F), Color(0xFF2DB87C), Color(0xFF4BC98B)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: SubtleOverlayPainter()),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.0.w),
                child: ListView(
                  children: [
                    SizedBox(height: 40.h),

                    // Episode artwork
                    Container(
                      width: double.infinity,
                      height: 321.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(currentEpisode.pictureUrl),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Title
                    Text(
                      currentEpisode.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Description
                    Text(
                      currentEpisode.description,
                      style: GoogleFonts.nunito(
                        color: Colors.grey.shade100,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Progress bar
                    Container(
                      padding: EdgeInsets.all(3),
                      width: double.infinity,
                      height: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: const Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: ((_currentPosition.inSeconds) /
                                (_totalDuration.inSeconds == 0
                                    ? 1
                                    : _totalDuration.inSeconds)) *
                                MediaQuery.of(context).size.width,
                            height: 5.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xffb9f89c), Color(0xffe7e7e7)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5.h),

                    // Time row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_currentPosition),
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            _formatDuration(_totalDuration),
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 31.h),

                    // Playback controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _playPrevious,
                          child: Image.asset("assets/images/back_button.png"),
                        ),
                        SizedBox(width: 31.w),
                        GestureDetector(
                          onTap: _skipBackward,
                          child: Image.asset("assets/images/back_ten.png"),
                        ),
                        SizedBox(width: 31.w),
                        GestureDetector(
                          onTap: () {
                            if (_player.playing) {
                              _pause();
                            } else {
                              _play();
                            }
                          },
                          child: Icon(
                            _player.playing
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            color: Colors.white,
                            size: 50.r,
                          ),
                        ),
                        SizedBox(width: 31.w),
                        GestureDetector(
                          onTap: _skipForward,
                          child: Image.asset("assets/images/right_ten.png"),
                        ),
                        SizedBox(width: 31.w),
                        GestureDetector(
                          onTap: _playNext,
                          child: Image.asset("assets/images/right_button.png"),
                        ),
                      ],
                    ),

                    SizedBox(height: 62.h),

                    // Action buttons
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _ActionButton(
                                icon: Icons.add_to_queue_outlined,
                                label: 'Add to queue',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _ActionButton(
                                icon: Icons.favorite_border,
                                label: 'Save',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _ActionButton(
                          iconRight: true,
                          icon: Icons.arrow_forward,
                          label: 'Go to episode',
                          fullWidth: true,
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _ActionButton(
                                icon: Icons.add,
                                label: 'Add to playlist',
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _ActionButton(
                                icon: Icons.share,
                                label: 'Share Playlist',
                                iconRight: true,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    int minutes = d.inMinutes;
    int seconds = d.inSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool fullWidth;
  final bool iconRight;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.fullWidth = false,
    this.iconRight = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 11.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!iconRight) ...[
              Icon(icon, color: Colors.white, size: 22.r),
              SizedBox(width: 8.w),
            ],
            Text(
              label,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (iconRight) ...[
              SizedBox(width: 3.w),
              Icon(icon, color: Colors.white, size: 22.r),
            ],
          ],
        ),
      ),
    );
  }
}

class SubtleOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);

    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.2), 150, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.6), 200, paint);

    final paint2 = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);

    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 180, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
