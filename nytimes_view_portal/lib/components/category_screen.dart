


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:nytimes_view_portal/bloc/category_event.dart';
import 'package:nytimes_view_portal/bloc/category_state.dart';
import 'package:nytimes_view_portal/bloc/category_bloc.dart';

import 'package:nytimes_view_portal/components/favstore.dart';

class CategoriesScreen extends StatefulWidget {
    const CategoriesScreen({Key? key}) : super(key: key);

    @override
    State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

    final format = DateFormat('MMM dd, yyyy');
    String categoryName = 'General' ;

    List<String> categoriesList = [
        'arts',
        'home',
        'science',
        'us',
        'world',
    ];

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        context.read<NewsCatsBloc>().add(NewsCategories('arts'));
    }

    @override
    Widget build(BuildContext context) {
        final width  = MediaQuery.sizeOf(context).width * 1 ;
        final height  = MediaQuery.sizeOf(context).height * 1 ;
        return  Scaffold(
            appBar: AppBar(
                title: const Text('Favorites' , style: TextStyle(fontSize: 15),),
                centerTitle: true,
                actions: [
                    PersistentFavstore().showCartItemCountWidget(
                        cartItemCountWidgetBuilder: (itemCount) => IconButton(
                            onPressed: () {
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CartView()),
                                );*/
                            },
                            icon: Badge(
                                label:Text(itemCount.toString()) ,
                                child: const Icon(Icons.favorite_border),
                            ),
                        ),
                    ),
                    const SizedBox(width: 20.0)
                ],
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    children: [
                        SizedBox(
                            height: 50,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoriesList.length,
                                itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: (){
                                            categoryName = categoriesList[index] ;
                                            context.read<NewsCatsBloc>().add(NewsCategories(categoryName));
                                            setState(() {});
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: categoryName ==  categoriesList[index] ?  Colors.blue :Colors.grey ,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                                    child: Center(child: Text(categoriesList[index].toString(), style: GoogleFonts.poppins(
                                                    fontSize: 13 ,
                                                    color: Colors.white
                                                    ),)),
                                                ),
                                            ),
                                        ),
                                    );
                                }
                            ),
                        ),
                        const SizedBox(height: 20,),
                        BlocBuilder<NewsCatsBloc, NewsCatsState>(
                            builder: (BuildContext context, state) {
                                switch(state.categoriesStatus) {
                                case Status.initial:
                                    return const Center( child: const SpinKitCircle( size: 50, color: Colors.blue, ), );
                                case Status.failure:
                                    return Text(state.categoriesMessage.toString());
                                case Status.success:
                                    return Expanded(
                                        child: ListView.builder(
                                            itemCount: state.newsCategoriesList!.results!.length,
                                            itemBuilder: (context , index) {
                                                DateTime dateTime = DateTime.parse(state.newsCategoriesList!.results![index].published_date.toString());
                                                return  Padding(
                                                    padding: const EdgeInsets.only(bottom: 15),
                                                    child: Row(
                                                        children: [
                                                            ClipRRect(
                                                                borderRadius: BorderRadius.circular(15),
                                                                child: CachedNetworkImage(
                                                                    imageUrl: state.newsCategoriesList!.results![index].multimedia![0].toString(),
                                                                    fit: BoxFit.cover,
                                                                    height: height * .18,
                                                                    width: width * .3,
                                                                    placeholder:  (context , url) => Container(child: const Center( child: const SpinKitCircle( size: 50, color: Colors.blue, ), ), ),
                                                                    errorWidget: (context, url  ,error) => Icon(Icons.error_outline ,color: Colors.red,),
                                                                ),
                                                            ),
                                                            Expanded(
                                                                child: Container(
                                                                    height:  height * .18,
                                                                    padding: EdgeInsets.only(left: 15),
                                                                    child: Column(
                                                                        children: [
                                                                            Text(
                                                                                state.newsCategoriesList!.results![index].title.toString() ,
                                                                                maxLines: 3,
                                                                                style: GoogleFonts.poppins( fontSize: 15 , color: Colors.black54, fontWeight: FontWeight.w700 ),
                                                                            ),
                                                                            Text(
                                                                                state.newsCategoriesList!.results![index].abstract.toString(),
                                                                                maxLines: 3,
                                                                                style: GoogleFonts.poppins( fontSize: 11 , color: Colors.black54, fontWeight: FontWeight.w500 ),
                                                                            ),
                                                                            IconButton(
                                                                                onPressed: () async { PersistentFavstore().addToCart(state.newsCategoriesList!.results![index]); },
                                                                                icon: Container( child: SvgPicture.asset( '../assets/fav.svg', semanticsLabel: 'My SVG Image', ), ),
                                                                            ),
                                                                            //Spacer(),
                                                                            Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                    Expanded(
                                                                                        child: Text(state.newsCategoriesList!.results![index].byline.toString() ,
                                                                                            style: GoogleFonts.poppins(
                                                                                                fontSize: 14 ,
                                                                                                color: Colors.black54,
                                                                                                fontWeight: FontWeight.w600
                                                                                            ),
                                                                                        ),
                                                                                    ),
                                                                                    Text(format.format(dateTime) ,
                                                                                        style: GoogleFonts.poppins(
                                                                                            fontSize: 15 ,
                                                                                            fontWeight: FontWeight.w500
                                                                                        ),
                                                                                    ),
                                                                                ],
                                                                            )
                                                                        ],
                                                                    ),
                                                                ),
                                                            )
                                                        ],
                                                    ),
                                                );
                                            }
                                        ),
                                    ) ;
                                }
                            },
                        )
                    ],
                ),
            ),
        );
    }
}
