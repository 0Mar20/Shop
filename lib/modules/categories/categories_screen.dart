import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategoriesScreenItem(AppCubit.get(context).categoriesModel.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: AppCubit.get(context).categoriesModel.data.data.length,
          ),
        );
      },
    );
  }

  Widget buildCategoriesScreenItem(DataModel model) {
    return Row(
      children: [
        Image(
          image: NetworkImage(
            model.image,
          ),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          model.name,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {},
        ),
      ],
    );
  }
}
