import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapp2/bloc/fav_restaurant/fav_bloc.dart';
import 'package:restapp2/demo/restaurant_details_scrn.dart';

class FavView extends StatefulWidget {
  const FavView({super.key});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  void initState() {
    context.read<FavBloc>().add(const FetchTodos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favourite Restaurant'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.black87,
      //   ),
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (c) => const AddFavRestauratPage()));
      //   },
      // ),
      body: BlocBuilder<FavBloc, FavState>(
        builder: (context, state) {
          if (state is DisplayRestaurantsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DisplayRestaurants) {
            return state.restaurant.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    itemCount: state.restaurant.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => RestaurantDetailsScrn(
                                    detailRestaurant: state.restaurant[i],
                                  )),
                            ),
                          );
                        },
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 14),
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: Image.network(
                                        state.restaurant[i].pictureId,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                                    child: Text("Image Error")),
                                      )),
                                  title: Text(
                                    state.restaurant[i].name.toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 14,
                                      ),
                                      Text(state.restaurant[i].city),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          key: Key('removeRestaurant_$i'),
                                          onPressed: () {
                                            context.read<FavBloc>().add(
                                                DeleteTodo(
                                                    id: state
                                                        .restaurant[i].id));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              content: Text("deleted todo"),
                                            ));
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('Data favorite kosong'));
          }
          return Container(
            color: Colors.white,
            child: const Center(child: Text("Error")),
          );
        },
      ),
    );
  }
}
