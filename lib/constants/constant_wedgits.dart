
import 'package:ahadith/data/models/book.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
class ConstantsWedgits  {

    SnakBar(context, message){
     SnackBar snackBar =
     SnackBar(content: Text(message));
     ScaffoldMessenger.of(context)
         .showSnackBar(snackBar);
   }
  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myNebety,
      ),
    );
  }

}
