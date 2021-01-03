import 'package:flutter/material.dart';
import 'package:markets/src/elements/CaregoriesCarouselWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';

import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  TextStyle _titleStyle = TextStyle(
      color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: <Color>[
                  Color(0xFF3943BC),
                  Color(0xFFFF5800),
                ]),
          ),
        ),

        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Colors.white),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/img/logo.png',
          width: MediaQuery.of(context).size.width * .1,
        ),
        // title: ValueListenableBuilder(
        //   valueListenable: settingsRepo.setting,
        //   builder: (context, value, child) {
        //     return Text(
        //       value.appName ?? S.of(context).home,
        //       style: Theme.of(context)
        //           .textTheme
        //           .headline6
        //           .merge(TextStyle(letterSpacing: 1.3)),
        //     );
        //   },
        // ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Colors.white,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Center(
              //       child: currentUser.value.apiToken != null
              //           ? Text(
              //               'Hola: ${currentUser.value.name}',
              //               style: _titleStyle,
              //             )
              //           : Text('Hola: Invitado', style: _titleStyle)),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: Container(
              //     margin: EdgeInsets.symmetric(vertical: 20),
              //     padding: EdgeInsets.symmetric(vertical: 30),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white,
              //         boxShadow: [
              //           BoxShadow(
              //             offset: Offset(3, 7),
              //             color: Colors.black26,
              //           )
              //         ]),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           'Saldo: 20.000 COP',
              //           style: _titleStyle,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(
                  onClickFilter: (event) {
                    widget.parentScaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: <Color>[
                          Color(0xFFFF5800),
                          Color(0xFFEE1F22),
                        ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Qué Deseas Hacer',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.w300)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              CategoriesCarouselWidget(
                categories: _con.categories,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              //   child: ListTile(
              //     dense: true,
              //     contentPadding: EdgeInsets.symmetric(vertical: 0),
              //     leading: Icon(
              //       Icons.stars,
              //       color: Theme.of(context).hintColor,
              //     ),
              //     trailing: IconButton(
              //       onPressed: () {
              //         if (currentUser.value.apiToken == null) {
              //           _con.requestForCurrentLocation(context);
              //         } else {
              //           var bottomSheetController = widget
              //               .parentScaffoldKey.currentState
              //               .showBottomSheet(
              //             (context) => DeliveryAddressBottomSheetWidget(
              //                 scaffoldKey: widget.parentScaffoldKey),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: new BorderRadius.only(
              //                   topLeft: Radius.circular(10),
              //                   topRight: Radius.circular(10)),
              //             ),
              //           );
              //           bottomSheetController.closed.then((value) {
              //             _con.refreshHome();
              //           });
              //         }
              //       },
              //       icon: Icon(
              //         Icons.my_location,
              //         color: Theme.of(context).hintColor,
              //       ),
              //     ),
              //     title: Text(
              //       S.of(context).top_markets,
              //       style: Theme.of(context).textTheme.headline4,
              //     ),
              //     subtitle: Text(
              //       S.of(context).near_to +
              //           " " +
              //           (settingsRepo.deliveryAddress.value?.address ??
              //               S.of(context).unknown),
              //       style: Theme.of(context).textTheme.caption,
              //     ),
              //   ),
              // ),
              // CardsCarouselWidget(
              //     marketsList: _con.topMarkets, heroTag: 'home_top_markets'),
              // ListTile(
              //   dense: true,
              //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
              //   leading: Icon(
              //     Icons.trending_up,
              //     color: Theme.of(context).hintColor,
              //   ),
              //   title: Text(
              //     S.of(context).trending_this_week,
              //     style: Theme.of(context).textTheme.headline4,
              //   ),
              //   subtitle: Text(
              //     S.of(context).double_click_on_the_product_to_add_it_to_the,
              //     style: Theme.of(context)
              //         .textTheme
              //         .caption
              //         .merge(TextStyle(fontSize: 11)),
              //   ),
              // ),
              // ProductsCarouselWidget(
              //     productsList: _con.trendingProducts,
              //     heroTag: 'home_product_carousel'),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: ListTile(
              //     dense: true,
              //     contentPadding: EdgeInsets.symmetric(vertical: 0),
              //     leading: Icon(
              //       Icons.category,
              //       color: Theme.of(context).hintColor,
              //     ),
              //     title: Text(
              //       S.of(context).product_categories,
              //       style: Theme.of(context).textTheme.headline4,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              //   child: ListTile(
              //     dense: true,
              //     contentPadding: EdgeInsets.symmetric(vertical: 0),
              //     leading: Icon(
              //       Icons.trending_up,
              //       color: Theme.of(context).hintColor,
              //     ),
              //     title: Text(
              //       S.of(context).most_popular,
              //       style: Theme.of(context).textTheme.headline4,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: <Color>[
                          Color(0xFF3943BC),
                          Color(0xFFFF5800),
                        ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Lugares Cashback',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontWeight: FontWeight.w300)
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridWidget(
                  marketsList: _con.popularMarkets,
                  heroTag: 'home_markets',
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: ListTile(
              //     dense: true,
              //     contentPadding: EdgeInsets.symmetric(vertical: 20),
              //     leading: Icon(
              //       Icons.recent_actors,
              //       color: Theme.of(context).hintColor,
              //     ),
              //     title: Text(
              //       S.of(context).recent_reviews,
              //       style: Theme.of(context).textTheme.headline4,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ReviewsListWidget(reviewsList: _con.recentReviews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
