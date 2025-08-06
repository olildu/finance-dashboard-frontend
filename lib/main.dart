import 'package:finance_dashboard/constants/globals.dart';
import 'package:finance_dashboard/providers/data_provider.dart';
import 'package:finance_dashboard/providers/transaction_card_provider.dart';
import 'package:finance_dashboard/responsive_screen/desktop_screens/desktop_home_page.dart';
import 'package:finance_dashboard/responsive_screen/desktop_screens/desktop_transactions_page.dart';
import 'package:finance_dashboard/responsive_screen/mobile_screens/home/mobile_home_page.dart';
import 'package:finance_dashboard/responsive_screen/mobile_screens/debit_credit/mobile_monthly_expense_catergories_page.dart';
import 'package:finance_dashboard/responsive_screen/mobile_screens/transactions/mobile_transactions_page.dart';
import 'package:finance_dashboard/responsive_screen/screen_decider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());
  
final GoRouter _router = GoRouter(
initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: "/debit",
      pageBuilder: (context, state) {
        final int? amount = int.tryParse(state.uri.queryParameters['amount'] ?? '');
        return CupertinoPage(
          child: MobileMonthlyExpenseCatergoriesPage(index: 0, isDebit: true, amount: amount),
        );
      },
    ),

    GoRoute(
      path: "/transactions",
      pageBuilder: (context, state) => const CupertinoPage(
        child: ScreenDecider(
          mobilePage: MobileTransactionPage(),
          desktopPage: DesktopTransactionsPage(),
        ),
      ),
    ),

    GoRoute(
      path: "/",
      pageBuilder: (context, state) => const CupertinoPage(
        child: ScreenDecider(
          mobilePage: MobileHomePage(),
          desktopPage: DesktopHomePage(),
        ),
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size.width > 800 
        ? const Size(1536, 695.2000122070312)
        : const Size(500, 729.5999755859375),
      minTextAdapt: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SimpleProvider()),
          ChangeNotifierProvider(create: (_) => TransactionCardProvider()),
        ],
        child: MaterialApp.router(
        key: navigatorkey,
          title: 'NoBroke',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 174, 222, 52)),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          routerConfig: _router,
        ),
      ),
    );
  }
}
