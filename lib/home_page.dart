import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   
  late final List currencies;
  HomePage(this.currencies);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto App"),
        centerTitle: true,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget(){
    return Container(
      child: Scrollbar(
        thickness: 10,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            final Map currency = widget.currencies[index];
            final MaterialColor color = _colors[index % _colors.length];

            return _getListItemUI(currency, color,widget.currencies[index]["id"]);
          },
          itemCount: widget.currencies.length,
          ),
      ),
    );
  }

  Widget _getListItemUI(Map currency, MaterialColor color,int id){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText((currency['quote']['USD']['price']), (currency['quote']['USD']['percent_change_1h'])),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(double priceUSD, double percentageChange){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",
    style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if(percentageChange > 0){
      percentageChangeTextWidget = TextSpan(text: percentageChangeText,
      style: TextStyle(color: Colors.green));
    }
    else{
      percentageChangeTextWidget = TextSpan(text: percentageChangeText,
      style: TextStyle(color: Colors.red));
    }

    // percentageChangeTextWidget = TextSpan(text: percentageChangeText,
    //     style: TextStyle(color: Colors.green));
    
    return RichText(text: TextSpan(
      children: [priceTextWidget, percentageChangeTextWidget]
    ));
  }

}