import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:podcast_demo/providers/podcast/podcast_notifier.dart';
import 'package:podcast_demo/utils/color_utils.dart';
import 'package:podcast_demo/views/podcast/podcast_player_screen.dart';
import 'package:podcast_demo/views/shared/custome_search_field.dart';
import 'package:podcast_demo/views/shared/loading_overlay.dart';
import 'package:podcast_demo/views/shared/podcast_thumbnail.dart';

class PodcastPage extends ConsumerStatefulWidget {
  const PodcastPage({super.key});

  @override
  ConsumerState<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends ConsumerState<PodcastPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(podcastProvider.notifier).getPodcast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(podcastProvider);
    final episodes = provider.response?.data.data.episodes ?? [];
    final displayedEpisodes = provider.searchQuery.isEmpty
        ? episodes
        : provider.filteredEpisodes;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  Text(
                    "Recent Podcasts",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20.sp,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  CustomSearchField(
                    hintText: "Search keyword or name",
                    suffix: const Icon(Icons.search, color: Colors.white),
                    onChanged: (value) {
                      ref.read(podcastProvider.notifier).searchEpisodes(value);
                    },
                  ),

                  SizedBox(height: 23.h),

                  if (provider.error == null &&
                      provider.response != null &&
                      provider.response!.data.data.episodes.isEmpty)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.library_music_outlined,
                              size: 64.sp,
                              color: Colors.grey[500],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No episodes available.",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (provider.error != null)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              provider.error!,
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(podcastProvider.notifier).getPodcast();
                              },
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (provider.error == null && displayedEpisodes.isNotEmpty)
                    Expanded(
                      child: GridView.builder(
                        itemCount: episodes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 20.h,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final episode = displayedEpisodes[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PodcastPlayerScreen(
                                    episode: episode,
                                    episodes: displayedEpisodes,
                                  ),
                                ),
                              );
                            },
                            child: PodCastThumbnail(
                              image: episode.pictureUrl,
                              title: episode.title,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        /// LOADING OVERLAY
        if (provider.loading) const LoadingOverlay(isLoading: true),
      ],
    );
  }
}
