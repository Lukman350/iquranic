import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iquranic/components/surah_card.dart';

import '../../bloc/surah_bloc.dart';
import '../../models/surah.dart';

class SurahListView extends StatelessWidget {
  const SurahListView({super.key});

  @override
  Widget build(BuildContext context) {
    final SurahBloc surahBloc = context.read<SurahBloc>();

    return FutureBuilder<List<Surah>>(
      future: surahBloc.getSurahList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        return SizedBox(
          height: 350,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemExtent: 100,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final surah = snapshot.data!;

              if (surah.isEmpty) {
                return const Center(
                  child: Text('No Surah'),
                );
              }

              return SurahCard(surah: surah[index]);
            },
          ),
        );
      },
    );
  }
}
