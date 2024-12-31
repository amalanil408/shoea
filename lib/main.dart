import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoea/bloc/Cart/cart_bloc.dart';
import 'package:shoea/bloc/Search/search_bloc.dart';
import 'package:shoea/bloc/Sort/sort_bloc.dart';
import 'package:shoea/bloc/account/account_bloc.dart';
import 'package:shoea/bloc/auth/user_auth_bloc.dart';
import 'package:shoea/bloc/Wishlist/wishlist_bloc.dart';
import 'package:shoea/bloc/home/home_bloc.dart';
import 'package:shoea/firebase_options.dart';
import 'package:shoea/util/constant.dart';
import 'package:shoea/view/splash/splash_screen.dart';

const userAuthKey = "User_Auth";

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Auth Bloc
        BlocProvider<UserAuthBloc>(create: (context) => UserAuthBloc()),
        
        // Home Bloc
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),

        // Account Bloc
        BlocProvider<AccountBloc>(create: (context) => AccountBloc()),

        //cart bloc
        BlocProvider<CartBloc>(create: (context) => CartBloc()),

        //search bloc
        BlocProvider(create: (context) => SearchBloc()),

        //sort bloc
        BlocProvider(create: (context) => SortBloc()),

        //wishlist bloc
        BlocProvider(create: (context) => WishlistBloc())
      ], 
      child:  MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackGroundColor,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white)
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
