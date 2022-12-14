import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tv_bloc.dart';
import 'package:tvseries/tvseries.dart';

class WatchlistTvPage extends StatelessWidget {
  const WatchlistTvPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistBloc, TVState>(
        builder: (context, state) {
          if (state is TVEmpty) {
            return const Center(
              child: Text('Watchlist is empty'),
            );
          } else if (state is TVLoading) {
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
            return Text(state.message);
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('Failed'),
            );
          }
        },
      ),
    ));
  }
}
