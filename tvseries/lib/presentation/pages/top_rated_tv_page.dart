import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TopRatedTvSeriesBloc>(context, listen: false)
            .add(OnTopRatedTV()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesBloc, TVState>(
          builder: (context, state) {
            if (state is TVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TVHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is TVError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
