import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/app_cubit.dart';
import 'package:shop_app/models/favourites_model.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  bool isPassword = false,
  IconData suffix,
  Function suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );

void showToast({
  @required String msg,
  // @required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

// enum ToastStates { Success, Error, Warning }

// Color chooseToastColor(ToastStates state) {
//   Color color;
//
//   switch (state) {
//     case ToastStates.Success:
//       color = Colors.green;
//       break;
//     case ToastStates.Error:
//       color = Colors.red;
//       break;
//     case ToastStates.Warning:
//       color = Colors.yellowAccent;
//       break;
//   }
// }

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultButton({
  Function function,
  String title,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () => function,
        child: Container(
          height: 40.0,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0),
            ),
          ),
        ),
      ),
    );

Widget buildListProduct(model, context, {bool oldPrice = true}) {
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
                if (model.discount != 0 && oldPrice)
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
                    if (model.discount != 0 && oldPrice)
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
                        AppCubit.get(context).changeFavourites(model.id);
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
