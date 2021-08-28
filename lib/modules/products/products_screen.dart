import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ChangeFavouritesSuccessState) {
          if (!state.changeFavouritesModel.status) {
            showToast(
              msg: state.changeFavouritesModel.message,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => productsBuilder(
              cubit.homeModel,
              cubit.categoriesModel,
              context,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
    HomeModel homeModel,
    CategoriesModel categoriesModel,
    context,
  ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  height: 250.0,
                  autoPlayInterval: Duration(seconds: 2),
                  reverse: false,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              width: double.infinity,
              height: 100.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCatItem(categoriesModel.data.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.0,
                ),
                itemCount: categoriesModel.data.data.length,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'New Products',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.73,
                children: List.generate(
                  homeModel.data.products.length,
                  (index) => buildProductElement(
                    homeModel.data.products[index],
                    context,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductElement(ProductModel productModel, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                height: 200.0,
                width: double.infinity,
                // fit: BoxFit.cover,
              ),
              if (productModel.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.w600, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel.price.round()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (productModel.discount != 0)
                      Text(
                        '${productModel.oldPrice.round()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3.0,
                            decorationColor: Colors.red),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeFavourites(productModel.id);
                      },
                      icon: AppCubit.get(context).favourites[productModel.id]
                          ? Icon(Icons.favorite_outlined)
                          : Icon(Icons.favorite_outline_rounded),
                      color: AppCubit.get(context).favourites[productModel.id]
                          ? Colors.red
                          : Colors.blueGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCatItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
            model.image,
          ),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1.0),
          width: 100.0,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
