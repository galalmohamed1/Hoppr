import 'dart:developer';
import 'package:Hoppr/admin/layout_admin/admin_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/admin/layout_admin/add_items.dart';
import 'package:Hoppr/admin/layout_admin/admin_home_screen.dart';
import 'package:Hoppr/admin/layout_admin/viewed_all_items.dart';
import 'package:Hoppr/payment/add_payment.dart';
import 'package:Hoppr/payment/payment_screen.dart';
import 'package:Hoppr/presentation/cart/cart_screen.dart';
import 'package:Hoppr/presentation/cart/my_order_screen.dart';
import 'package:Hoppr/presentation/cart/order_detail.dart';
import 'package:Hoppr/presentation/layout_user/model/app_model.dart';
import 'package:Hoppr/presentation/layout_user/screen/root_screen.dart';
import 'package:Hoppr/presentation/sign/loginpage.dart';
import 'package:Hoppr/presentation/sign/signup.dart';
import 'package:Hoppr/presentation/sign/splash_screen.dart';
import 'package:Hoppr/presentation/widgets/products/product_screen.dart';

import 'app_routes_name.dart';

abstract class AppRoutes {
  static Route onGeneratedRoute(RouteSettings settings) {
    log('Route: ${settings.name}');
    switch (settings.name) {
      case PagesRouteName.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );

      case PagesRouteName.LoginPage:
        return MaterialPageRoute(
          builder: (context) =>  Loginpage(),
          settings: settings,
        );

      case PagesRouteName.SignUp:
        {
          return MaterialPageRoute(
            builder: (context) => const Signup(),
            settings: settings,
          );
        }
      case PagesRouteName.Products:
        {
          return MaterialPageRoute(
            builder: (context) => const ProductScreen(),
            settings: settings,
          );
        }
      case PagesRouteName.Admin_Add_Items:
        {
          return MaterialPageRoute(
            builder: (context) =>  AddItems(),
            settings: settings,
          );
        }
      case PagesRouteName.Admin_Viewed_all_Items:
        {
          return MaterialPageRoute(
            builder: (context) =>  ViewedAllItems(),
            settings: settings,
          );
        }

      case PagesRouteName.add_payment_method:
        {
          return MaterialPageRoute(
            builder: (context) =>  AddPaymentMethods(),
            settings: settings,
          );
        }
      case PagesRouteName.Payment_Screen:
        {
          return MaterialPageRoute(
            builder: (context) =>  PaymentScreen(),
            settings: settings,
          );
        }
      case PagesRouteName.my_order_screen:
        {
          // var  CommerceApp;
          return MaterialPageRoute(
            builder: (context) =>  MyOrderScreen(),
            settings: settings,
          );
        }
        case PagesRouteName.Admin_order_screen:
        {
          return MaterialPageRoute(
            builder: (context) =>  AdminOrderScreen(),
            settings: settings,
          );
        }

      // case PagesRouteName.order_details:
      //   {
      //     // var  CommerceApp;
      //     return MaterialPageRoute(
      //       builder: (context) =>  OrderDetail(orderId: '',),
      //       settings: settings,
      //     );
      //   }
      // case PagesRouteName.ResetPassword:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) => const ResetPassword(),
      //       settings: settings,
      //     );
      //   }
      case PagesRouteName.HomePage:
        {
          return MaterialPageRoute(
            builder: (context) => const RootScreen(),
            settings: settings,
          );
        }
      case PagesRouteName.AdminHome:
        {
          return MaterialPageRoute(
            builder: (context) => const AdminHomeScreen(),
            settings: settings,
          );
        }
      // case PagesRouteName.PageScreen:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) =>   PageScreen(),
      //       settings: settings,
      //     );
      //
      //   }
      // case PagesRouteName.Add_Card:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) =>  Add_Event(),
      //       settings: settings,
      //     );
      //
      //   }
      // case PagesRouteName.Event_editing:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) => const Eventediting(),
      //       settings: settings,
      //     );
      //
      //   }
      // case PagesRouteName.addEventEditing:
      //   {
      //     return MaterialPageRoute(
      //       builder: (context) {
      //         var event=ModalRoute.of(context)?.settings.arguments as EventDataModel;
      //         return EventDetailsScreen(eventDataModel: event);
      //       },
      //       settings: settings,
      //
      //     );
      //
      //   }

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}