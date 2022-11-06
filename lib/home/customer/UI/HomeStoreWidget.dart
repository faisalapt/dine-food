import 'package:dine_food/home/customer/bloc/store_bloc.dart';
import 'package:dine_food/home/customer/models/Stores.dart';
import 'package:dine_food/home/store/show/UI/StoreScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeStoreWidget extends StatefulWidget {
  const HomeStoreWidget({super.key});

  @override
  State<HomeStoreWidget> createState() => _HomeStoreWidgetState();
}

class _HomeStoreWidgetState extends State<HomeStoreWidget> {
  TextEditingController teSearch = TextEditingController();
  StoreBloc storeBloc = StoreBloc();
  bool? onSearch;

  @override
  void dispose() {
    // TODO: implement dispose
    storeBloc.close();
    teSearch.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    onSearch = false;
    storeBloc.add(LoadStore(stores: [], search: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => storeBloc,
      child: Column(
        children: [
          BlocListener<StoreBloc, StoreState>(
            bloc: storeBloc,
            listener: (_, StoreState state) => {},
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: ((value) async {
                    if (value.length > 2) {
                      storeBloc.add(LoadStore(stores: [], search: value));
                    }
                  }),
                  onEditingComplete: () {
                    storeBloc.add(LoadStore(stores: [], search: teSearch.text));
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                  ),
                  controller: teSearch,
                  textInputAction: TextInputAction.done,
                ),
                BlocBuilder<StoreBloc, StoreState>(
                  builder: (_, StoreState state) {
                    if (state is StoreLoading) {
                      return Text("Loading");
                    }
                    if (state is StoreLoaded) {
                      return HomeStoreLoaded(
                        state.stores,
                      );
                    }
                    return Text("Error");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget HomeStoreLoaded(List<Stores> stores) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 7 / 9,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: stores.length,
            itemBuilder: (BuildContext cxt, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StoreScreen(
                        name: stores[index].name!,
                        id: stores[index].id!,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffB9D7B8),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            width: MediaQuery.of(cxt).size.width * 0.4,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              stores[index].logo!,
                              scale: 0.1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(cxt).size.width,
                          child: Text(
                            stores[index].name!,
                            style: TextStyle(
                              fontFamily: "Cocogoose-Regular",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
