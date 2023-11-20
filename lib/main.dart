import 'package:flutter/material.dart';
import 'package:iquranic/screens/main_screen.dart';
import 'package:iquranic/screens/search_screen.dart';
import 'package:iquranic/screens/surah_screen.dart';
import 'package:iquranic/storage/favorite_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iQuranic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(149, 67, 255, 1)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        QuranScreen.routeName: (context) => const QuranScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        '/favorite': (context) => Scaffold(
              body: FutureBuilder(
                future: FavoriteStorage.readFavorite(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text('Total Favorite: ${snapshot.data!.length}'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].namaLatin),
                                subtitle:
                                    Text(snapshot.data![index].tempatTurun),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
      },
    );
  }
}
