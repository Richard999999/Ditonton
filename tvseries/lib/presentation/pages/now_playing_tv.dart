import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

class NowPlay extends StatefulWidget {
  const NowPlay({super.key});

  @override
  State<NowPlay> createState() => _NowPlayState();
}

class _NowPlayState extends State<NowPlay> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<GetNowplaylist>().add(OnAiringTodayTV()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetNowplaylist, TVState>(
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
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                key: Key('empty'),
                child: Text('Empty Data'),
              );
            }
          },
        ),
      ),
    );
  }
}
