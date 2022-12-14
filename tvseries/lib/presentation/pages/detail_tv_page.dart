// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

class TVDetailPage extends StatefulWidget {
  final int id;
  const TVDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<TvSeriesDetailBloc>(context, listen: false)
              .add(OnTvDetail(widget.id)),
          BlocProvider.of<TvRecomenBloc>(context, listen: false)
              .add(OnTVRecomen(widget.id)),
          BlocProvider.of<WatchlistBloc>(context, listen: false)
              .add(OnWatchlistTvStatus(widget.id)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TVState>(
        builder: (context, state) {
          if (state is TVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TVDetailHasData) {
            final tvDetail = state.result;
            final tvRecommendations =
                context.select<TvRecomenBloc, List<Tv>>((result) {
              final state = result.state;
              return state is TVHasData ? state.result : [];
            });
            final isAddedToWatchlist =
                context.select<WatchlistBloc, bool>((result) {
              final state = result.state;
              return state is TVWatchlistStatus ? state.status : false;
            });
            return SafeArea(
              child: DetailContent(
                  tvDetail, tvRecommendations, isAddedToWatchlist),
            );
          } else if (state is TVError) {
            return Center(child: Text(state.message));
          } else {
            return const Text(
              key: Key('error_message'),
              'Failed',
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final List<Tv> recommendations;
  final bool isAddedWatchlist;
  const DetailContent(
      this.tvDetail, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final poster = tvDetail.posterPath;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500$poster',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name!,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistBloc>()
                                      .add(OnSaveWatchlistTv(tvDetail));
                                } else {
                                  context
                                      .read<WatchlistBloc>()
                                      .add(OnRemoveWatchlistTv(tvDetail));
                                }
                                String message = '';

                                message = !isAddedWatchlist
                                    ? WatchlistBloc.watchlistAddSuccessMessage
                                    : WatchlistBloc
                                        .watchlistRemoveSuccessMessage;

                                final state =
                                    BlocProvider.of<WatchlistBloc>(context)
                                        .state;

                                if (state is TVError) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          content: Text(message)));
                                  BlocProvider.of<WatchlistBloc>(context)
                                      .add(OnWatchlistTvStatus(tvDetail.id));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview ?? '-',
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecomenBloc, TVState>(
                              builder: (context, state) {
                                if (state is TVLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TVHasData) {
                                  final recommendations = state.result;
                                  return SafeArea(
                                    child: RecomendationsTVList(
                                        recommendations: recommendations),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
