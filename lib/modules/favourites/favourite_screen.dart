import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favourites_model.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).favouritesModel.data.data == null,
          builder: (context) => Center(child: Text('Sorry'),),
          fallback: (context) => ConditionalBuilder(
            condition: state is! GrtFavouritesLoadingState,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListProduct(
                  AppCubit.get(context).favouritesModel.data.data[index].product,
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: AppCubit.get(context).favouritesModel.data.data.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget buildFavItem(model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image,
                    ),
                    height: 120.0,
                    width: 120.0,
                    // fit: BoxFit.cover,
                  ),
                  if (model.discount != 0)
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
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
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
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
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
                          AppCubit.get(context)
                              .changeFavourites(model.id);
                        },
                        icon: AppCubit.get(context).favourites[model.id]
                            ? Icon(Icons.favorite_outlined)
                            : Icon(Icons.favorite_outline_rounded),
                        color: true ? Colors.red : Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
