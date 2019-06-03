import 'dart:async';
import 'dart:convert';
import './utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String category, name;

  Home({Key key, this.category, this.name}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 52, 52, 100),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 5.0,
        title: (Text('NEWS')),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text(
                "Vishal Parmar",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              accountEmail: Text("vishal.parmar17599@gmail.com"),
              currentAccountPicture: Image.network(
                  "https://cdn.vox-cdn.com/thumbor/R4Y84RUSGhqwKtd9HJ_jBmQGe_Q=/0x0:1382x2048/1200x800/filters:focal(429x278:649x498)/cdn.vox-cdn.com/uploads/chorus_image/image/59271649/DZ9PwU2X4AMEJPc.0.jpg"),
            ),
            ListTile(
                title: Text("Business"),
                leading: Icon(Icons.people),
                onTap: () {
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => Home(
                          category: "&category=business",
                          name: "Business News"));
                  Navigator.of(context).push(route);
                }),
            Divider(),
            ListTile(
                title: Text("Entertainment"),
                leading: Icon(Icons.live_tv),
                onTap: () {
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => Home(
                          category: "&category=entertainment",
                          name: "Entertainment News"));
                  Navigator.of(context).push(route);
                }),
            Divider(),
            ListTile(
                title: Text("Sports"),
                leading: Icon(Icons.videogame_asset),
                onTap: () {
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => Home(
                          category: "&category=sports", name: "Sports News"));
                  Navigator.of(context).push(route);
                }),
            Divider(),
            ListTile(
                title: Text("Technology"),
                leading: Icon(Icons.build),
                onTap: () {
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => Home(
                          category: "&category=technology",
                          name: "Technology News"));
                  Navigator.of(context).push(route);
                }),
            Divider(),
            ListTile(
                title: Text("Science"),
                leading: Icon(Icons.language),
                onTap: () {
                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => Home(
                          category: "&category=science", name: "Science News"));
                  Navigator.of(context).push(route);
                }),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getNews("${widget.category}"),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data;
            List news = data['articles'];
            return ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 8.0),
                  child: Text(
                    "${widget.name}",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                GestureDetector(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: divHeight / 3,
                          width: divWidth,
                          child: Card(
                            color: Colors.black,
                            child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: FadeInImage.assetNetwork(
                                    width: divWidth,
                                    fit: BoxFit.fill,
                                    height: divHeight / 3,
                                    //    "https://s.yimg.com/ny/api/res/1.2/zproc.ihLfOdcA5wfeus4Q--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://img.huffingtonpost.com/asset/5cd962a82100005900802494.jpeg",

                                    placeholder: 'images/error.jpg',
                                    image: news[0]['urlToImage'].toString())),
                          ),
                        ),
                        Container(
                          child: Text(
                            news[0]['title'].toString(),
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          margin:
                              EdgeInsets.only(top: divHeight / 4.2, left: 18.0),
                        )
                      ],
                    ),
                    onTap: () {
                      var route = new MaterialPageRoute(
                          builder: (BuildContext context) => News(
                              url: news[0]['urlToImage'].toString(),
                              name: news[0]['source']['name'].toString(),
                              news: news[0]['content'].toString(),
                              title: news[0]['title'],
                              newsurl: news[0]['url']));
                      Navigator.of(context).push(route);
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: news.length,
                    itemBuilder: (BuildContext context, int position) {
                      if (position.isOdd) {
                        return new Divider(
                          color: Colors.grey,
                        );
                      }
                      final index = position ~/ 2;
                      return ListTile(
                          trailing: FadeInImage.assetNetwork(
                              width: divWidth / 4,
                              height: 500.0,
                              //    "https://s.yimg.com/ny/api/res/1.2/zproc.ihLfOdcA5wfeus4Q--~A/YXBwaWQ9aGlnaGxhbmRlcjtzbT0xO3c9ODAw/https://img.huffingtonpost.com/asset/5cd962a82100005900802494.jpeg",

                              placeholder: 'images/error.jpg',
                              image: news[index + 1]['urlToImage'].toString()),
                          title: Text(
                            news[index + 1]['title'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              news[index + 1]['source']['name'].toString() ==
                                      "null"
                                  ? "News"
                                  : news[index + 1]['source']['name']
                                      .toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onTap: () {
                            var route = new MaterialPageRoute(
                                builder: (BuildContext context) => News(
                                      url: news[index + 1]['urlToImage']
                                          .toString(),
                                      name: news[index + 1]['source']['name']
                                          .toString(),
                                      news:
                                          news[index + 1]['content'].toString(),
                                      title: news[index + 1]['title'],
                                      newsurl: news[index + 1]['url'],
                                    ));
                            Navigator.of(context).push(route);
                          });
                    }),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Future<Map> getNews(String query) async {
  String apiUrl =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=${utils.key}" +
          query;
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}

class News extends StatefulWidget {
  final String url, name, news, title, newsurl;

  News({Key key, this.url, this.name, this.news, this.title, this.newsurl})
      : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 4.0,
      ),
      backgroundColor: Color.fromRGBO(55, 52, 52, 100),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 8.0),
            child: Text(
              "${widget.title}",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FadeInImage.assetNetwork(
                  height: divHeight / 2.8,
                  fit: BoxFit.fill,
                  width: divWidth,
                  placeholder: 'images/error.jpg',
                  image: "${widget.url}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${widget.name}",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${widget.news}",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                child: Text(
              "${widget.newsurl}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Home(
      category: "&q=$query",
      name: "Top Results",
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container(
      color: Colors.black,
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _textContrller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: TextField(
          controller: _textContrller,
          textInputAction: TextInputAction.done,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _textContrller.text = "";
              })
        ],
      ),
    );
  }
}
