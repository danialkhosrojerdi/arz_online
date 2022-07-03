import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/currency_model.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Currency> currency = [];

  Future getJson(BuildContext context) async {
    var url = Uri.parse(
        'http://sasansafari.com/flutter/api.php?access_key=flutter123456');
    var value = await http.get(url);
    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _showSnackBar(context, 'اطلاعات با موفقیت دریافت شد');
        List jsonList = convert.jsonDecode(value.body);

        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  title: jsonList[i]['title'],
                  price: jsonList[i]['price'],
                  changes: jsonList[i]['changes'],
                  status: jsonList[i]['status'],
                  id: jsonList[i]['id']));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getJson(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Image.asset(
            'asset/images/icon.png',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ارز آنلاین',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          const Icon(
            Icons.menu_rounded,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('asset/images/q.png'),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'نرخ ارز آزاد چیست؟',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'نرخ آزاد ارزها نرخ مربوط به معاملات نقدی و رایج روزانه است. معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله، ارز و ریال را با هم تبادل می نمایند.',
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Container(
              height: 40,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'نام ارز آزاد',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'قیمت',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'تغییر',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 350,
              child: listFutureBuilder(context),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ),
                      onPressed: () {
                        currency.clear();
                        listFutureBuilder(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.refresh_bold,
                        color: Colors.black,
                      ),
                      label: Text(
                        'بروزرسانی',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Text(
                    'آخرین بروزرسانی ${_getTime()}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    width: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future: getJson(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                    width: double.infinity,
                    height: 45,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          offset: const Offset(2, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          currency[position].title,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          getFarsiNumber(currency[position].price),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          getFarsiNumber(currency[position].changes),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int position) {
                  if (position % 10 == 0) {
                    return getListAds(context, position);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        msg,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget getListAds(BuildContext context, int position) {
  return Container(
    width: double.infinity,
    height: 45,
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: Colors.orange,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: const Offset(2, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(1000),
    ),
    child: const Center(child: Text('متن تبلیغات')),
  );
}

String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (var element in en) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  }

  return number;
}

String _getTime() {
  DateTime currentTime = DateTime.now();
  return DateFormat('kk:mm:ss').format(currentTime);
}
