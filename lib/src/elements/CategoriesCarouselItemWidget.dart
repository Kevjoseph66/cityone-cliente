import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/category.dart';
import '../models/route_argument.dart';

// ignore: must_be_immutable
class CategoriesCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Category category;
  CategoriesCarouselItemWidget({Key key, this.marginLeft, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context)
            .pushNamed('/Category', arguments: RouteArgument(id: category.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: category.id,
            child: Container(
              margin:
                  // EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
                  EdgeInsets.all(4),
              width: 80,
              height: 80,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.centerRight,
              //         end: Alignment.centerLeft,
              //         colors: <Color>[
              //           Color(0xFFFF5800),
              //           Color(0xFFEE1F22),
              //         ]),
              //     borderRadius: BorderRadius.all(Radius.circular(20)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black26,
              //         offset: Offset(3.0, 5.0),
              //         blurRadius: 3.0,
              //         spreadRadius: 1.0,
              //       )
              //     ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: category.image.url.toLowerCase().endsWith('.svg')
                    ? SvgPicture.network(
                        category.image.url,
                        color: Theme.of(context).accentColor,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: category.image.icon,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
          ),
          // SizedBox(height: 5),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              category.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
