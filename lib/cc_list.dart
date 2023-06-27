import 'package:cc_tracker/cc_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget {
  const CCList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {
  List<CCData> data = [];
  @override
  void initState() {
    _loadCC();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptocurrency List'),
      ),
      body: ListView(
        children: _buildList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadCC,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  _loadCC() async {
    final response = await http.get(
        Uri.parse(
            "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5000&convert=USD"),
        headers: {
          "X-CMC_PRO_API_KEY": "77fc0747-d858-47fd-907d-87066d04b258",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      var allData = json.decode(response.body)['data'];
      var ccDataList = <CCData>[];
      allData.forEach((value) {
        var record = CCData(
            name: value['name'],
            symbol: value['symbol'],
            rank: value['cmc_rank'],
            price: value["quote"]['USD']['price']);
        ccDataList.add(record);
      });
      setState(() {
        data = ccDataList;
      });
    }
  }

  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              title: Text(f.name),
              subtitle: Text(f.symbol),
              leading: CircleAvatar(
                child: Text(f.rank.toString()),
              ),
              trailing: Text('\$${f.price.toString()}'),
            ))
        .toList();
  }
}
