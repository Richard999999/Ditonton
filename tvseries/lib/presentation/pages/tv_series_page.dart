import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/domain/entities/tv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => [
        BlocProvider.of<GetNowplaylist>(context, listen: false)
            .add(OnAiringTodayTV()),
        BlocProvider.of<PopularTvSeriesBloc>(context, listen: false)
            .add(OnPopularTV()),
        BlocProvider.of<TopRatedTvSeriesBloc>(context, listen: false)
            .add(OnTopRatedTV()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Tv Page',
                  style: GoogleFonts.lato(
                      color: kMikadoYellow,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () => Navigator.pushNamed(context, NOW_PLAYING_TV_ROUTE),
              ),
              BlocBuilder<GetNowplaylist, TVState>(builder: (context, state) {
                if (state is TVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVHasData) {
                  return TVList(state.result);
                } else if (state is TVError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.amber),
                    ),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              BlocBuilder<PopularTvSeriesBloc, TVState>(
                  builder: (context, state) {
                if (state is TVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVHasData) {
                  return TVList(state.result);
                } else if (state is TVError) {
                  return Center(
                    child: Text(state.message,
                        style: TextStyle(color: Colors.amber)),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              BlocBuilder<TopRatedTvSeriesBloc, TVState>(
                  builder: (context, state) {
                if (state is TVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TVHasData) {
                  return TVList(state.result);
                } else if (state is TVError) {
                  return Center(
                    child: Text(state.message,
                        style: TextStyle(color: Colors.amber)),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<Tv> tv;

  const TVList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tvList = tv[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DETAIL_TV_ROUTE,
                    arguments: tvList.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${tvList.posterPath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: tv.length,
        ),
      ),
    );
  }
}
