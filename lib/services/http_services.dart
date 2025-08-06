import 'dart:convert';

import 'package:finance_dashboard/constants/globals.dart';
import 'package:finance_dashboard/providers/data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// String endpoint = "http://127.0.0.1:8000/";
String endpoint = "http://ec2-35-154-160-4.ap-south-1.compute.amazonaws.com:8081/";

class HttpServices {
  Future<Map> getBalance() async {
    var response = await http.get(Uri.parse("${endpoint}getData"));
    return jsonDecode(response.body);
  }

  // Debit Transaction  
  Future<void> debitTransaction(String amount, String reason, String category, int index) async {
    String encodedCategory = Uri.encodeComponent(category);
    if (index == 3) {
      mutualFundTransaction(amount, category, "debit", reason);
    }
    await http.get(Uri.parse("${endpoint}debit?amount=$amount&reason=$reason&category=$encodedCategory&area=${backendAreaRoute[index.toString()]}"));
    Provider.of<SimpleProvider>(navigatorkey.currentContext!, listen: false).increment();
  }

  // Credit Transaction
  Future<void> creditTransaction(String amount, String reason, String category, int index) async {
    String encodedCategory = Uri.encodeComponent(category);
    if (index == 3) {
      mutualFundTransaction(amount, category, "credit", reason);  
    }
    await http.get(Uri.parse("${endpoint}credit?amount=$amount&reason=$reason&category=$encodedCategory&area=${backendAreaRoute[index.toString()]}"));
    Provider.of<SimpleProvider>(navigatorkey.currentContext!, listen: false).increment();
  }


  // Mutual Fund Transaction
  Future<void> mutualFundTransaction(String amount, String fundName, String method, String units) async {
    String encodedFundName = Uri.encodeComponent(fundName);
    await http.get(Uri.parse("${endpoint}mf-transaction?amount=$amount&fund_name=$encodedFundName&method=$method&units=$units"));
    Provider.of<SimpleProvider>(navigatorkey.currentContext!, listen: false).increment();
  }

  // Delete Transaction
  Future<void> deleteTransaction(String id, String amount, String bracket, String mId, String method) async {
    await http.get(Uri.parse("${endpoint}deleteTransaction?id=$id&amount=$amount&bracket=$bracket&m_id=$mId&method=$method"));
    Provider.of<SimpleProvider>(navigatorkey.currentContext!, listen: false).increment();
  } 
 
  // Get Transaction
  Future<Map> getTransactions(String month, String year) async { 
    var response = await http.get(Uri.parse("${endpoint}getTransactions?month=$month&year=$year"));
    return jsonDecode(response.body);
  } 
  
  // Get Transaction
  Future<List> getChoices(String amount) async { 
    var response = await http.get(Uri.parse("${endpoint}getChoices?amount=$amount"));
    return jsonDecode(response.body);
  } 

}