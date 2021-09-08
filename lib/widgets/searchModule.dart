import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/styles.dart';
import 'package:http/http.dart' as http;

class SearchModule extends StatefulWidget {
  const SearchModule({Key? key}) : super(key: key);

  @override
  _SearchModuleState createState() => _SearchModuleState();
}

class _SearchModuleState extends State<SearchModule> {
  String selectedTypesOfResults = 'All';
  TextEditingController searchController = TextEditingController();
  List<Widget> searchResultWidgetList = [];
  int numberOfTabs = 0;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
              color: moduleBG, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                width: constraints.maxWidth,
                height: 40,
                decoration: BoxDecoration(
                    color: moduleBar,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: Row(
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.1),
                    searchController.text.isEmpty
                        ? Container()
                        : loading
                            ? SizedBox(
                                height: 25,
                                width: 25,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(text2),
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  if (searchController.text == "") {
                                    return;
                                  }
                                  if (selectedTypesOfResults == 'All') {
                                    fetchResults(constraints);
                                  } else if (selectedTypesOfResults ==
                                      'Images') {
                                    showImageResults(constraints);
                                  }
                                },
                                child:
                                    Icon(Icons.refresh, color: text2, size: 32),
                              ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.73,
                      child: Center(
                        child: TextField(
                          controller: searchController,
                          autofocus: false,
                          style: style1.copyWith(fontSize: 22),
                          onSubmitted: (v) {
                            fetchResults(constraints);
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Search',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.01),
                    Icon(Icons.mic,
                        color: text2, size: constraints.maxWidth * 0.01 + 24),
                    SizedBox(width: constraints.maxWidth * 0.01),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: text2, width: 2)),
                          child: Center(
                              child: Text(
                            numberOfTabs.toString(),
                            style: style1.copyWith(color: text2, fontSize: 18),
                          ))),
                    ),
                  ],
                ),
              ),
              Container(height: 1, color: text4),
              searchResultWidgetList.length > 2
                  ? Container(
                      width: constraints.maxWidth,
                      height: 30,
                      color: moduleBar,
                      child: Row(
                        children: <Widget>[
                              SizedBox(width: constraints.maxWidth * 0.1),
                            ] +
                            (searchResultWidgetList.length > 2
                                ? <Widget>[
                                    typesOfSearchesGenerator(
                                        constraints: constraints,
                                        iconData: Icons.search,
                                        text: "All",
                                        onTap: () {
                                          fetchResults(constraints);
                                        }),
                                    typesOfSearchesGenerator(
                                        constraints: constraints,
                                        iconData: Icons.image_search,
                                        text: "Images",
                                        onTap: () {
                                          showImageResults(constraints);
                                        }),
                                    typesOfSearchesGenerator(
                                        constraints: constraints,
                                        iconData: Icons.wysiwyg,
                                        text: "News",
                                        onTap: () {}),
                                    typesOfSearchesGenerator(
                                        constraints: constraints,
                                        iconData: Icons.shopping_bag,
                                        text: "Shopping",
                                        onTap: () {}),
                                    typesOfSearchesGenerator(
                                        constraints: constraints,
                                        iconData: Icons.map_rounded,
                                        text: "Maps",
                                        onTap: () {}),
                                    typesOfSearchesGenerator(
                                        constraints: constraints,
                                        iconData: Icons.ondemand_video,
                                        text: "Videos",
                                        onTap: () {}),
                                  ]
                                : <Widget>[]),
                      ),
                    )
                  : Container(),
              Container(height: 1, color: Colors.black),
              Container(
                height: constraints.maxHeight - 72,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15))),
                child: SingleChildScrollView(
                  child: Column(
                    children: searchResultWidgetList,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget typesOfSearchesGenerator(
      {required BoxConstraints constraints,
      required IconData iconData,
      required String text,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        if (text != selectedTypesOfResults) {
          selectedTypesOfResults = text;
          onTap();
          setState(() {});
        }
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: selectedTypesOfResults == text ? text3 : text4,
              size: 16,
            ),
            Text(
              " $text  ",
              style: style1.copyWith(
                fontSize: 12,
                color: selectedTypesOfResults == text ? text2 : text3,
                fontWeight: selectedTypesOfResults == text
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.01,
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }

  void fetchResults(BoxConstraints constraints, {int pageNumber = 0}) async {
    loading = true;

    selectedTypesOfResults = 'All';
    setState(() {});
    numberOfTabs++;
    Uri url = Uri.parse(
        'https://serpapi.com/search?start=${(pageNumber * 10).toString()}&num=10&q=${searchController.text}&engine=google&api_key=${serpApiKey}');
    print("URL:" + url.toString());
    http.Response response = await http.get(url, headers: {
      "q": searchController.text,
      "engine": engine,
      "api_key": serpApiKey,
      "start": (pageNumber * 10).toString(),
      "num": '15'
    });
    Map webPage = jsonDecode(response.body);
    searchResultWidgetList = [];

    if (webPage['error'] != null) {
      searchResultWidgetList.add(SizedBox(height: constraints.maxHeight * 0.4));
      searchResultWidgetList.add(Center(
        child: Container(
            child: RichText(
          text: TextSpan(
              style: style1.copyWith(fontSize: 16, color: text3),
              children: [
                TextSpan(text: 'Your search - '),
                TextSpan(
                  text: searchController.text,
                  style: style1.copyWith(fontSize: 16, color: text2),
                ),
                TextSpan(text: ' - did not return any results'),
              ]),
        )),
      ));

      setState(() {});
      return;
    }
    Map searchInformation = webPage['search_information'];
    searchResultWidgetList.add(SizedBox(
      height: 10,
    ));
    searchResultWidgetList.add(Container(
      height: 30,
      child: Container(
        width: constraints.maxWidth * 0.9,
        child: Text(
          'About ${searchInformation['total_results'].toString()} results (in ${searchInformation['time_taken_displayed'].toString()} seconds)',
          style: style1.copyWith(fontSize: 10, color: text4),
        ),
      ),
    ));
    if (webPage['local_map'] != null) {
      searchResultWidgetList.add(Center(
        child: Image(
          image: NetworkImage(webPage['local_map']['image']),
          width: constraints.maxWidth * 0.9,
          height: constraints.maxWidth * 0.3,
        ),
      ));
    }

    if (webPage['local_results'] != null) {
      for (Map place in webPage['local_results']['places']) {
        searchResultWidgetList
            .add(LocalResultWidget(place: place, constraints: constraints));
      }
    }

    if (webPage['related_questions'] != null) {
      List<Widget> relatedQuestions = [];
      for (Map question in webPage['related_questions']) {
        relatedQuestions.add(RelatedQuestionsWidgets(
            question: question, constraints: constraints));
      }
      searchResultWidgetList.add(Container(
        width: constraints.maxWidth * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                Text(
                  "People also ask",
                  style: style1.merge(TextStyle(
                    color: text1,
                    fontSize: 20,
                  )),
                ),
              ] +
              relatedQuestions,
        ),
      ));
      searchResultWidgetList.add(Container(
        width: constraints.maxWidth * 0.9,
        color: text4,
        height: 1,
      ));
      searchResultWidgetList.add(SizedBox(
        height: 20,
      ));
    }
    if (webPage['inline_images'] != null) {
      List<Widget> inlineImages = [];
      for (Map inlineImage in webPage['inline_images']) {
        inlineImages.add(Image(
          height: constraints.maxWidth * 0.15,
          width: constraints.maxWidth * 0.15,
          fit: BoxFit.cover,
          image: NetworkImage(inlineImage['thumbnail'].toString()),
        ));
      }
      searchResultWidgetList.add(Container(
        width: constraints.maxWidth * 0.9,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.image,
              color: text3,
            ),
            SizedBox(width: 10),
            Text(
              "Images",
              style: style1.copyWith(color: text1, fontSize: 16),
            )
          ],
        ),
      ));
      searchResultWidgetList.add(Container(
        width: constraints.maxWidth * 0.9,
        child: Wrap(
          children: inlineImages,
        ),
      ));
      searchResultWidgetList.add(SizedBox(height: 10));
      searchResultWidgetList.add(Container(
        width: constraints.maxWidth * 0.9,
        child: Row(children: <Widget>[
          Container(
            height: 1,
            width: (constraints.maxWidth * 0.45 - 150),
            color: text3,
          ),
          InkWell(
            onTap: () {
              showImageResults(constraints);
            },
            child: Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Text("View All",
                        style: TextStyle(
                            color: text2,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)))),
          ),
          Container(
            height: 1,
            width: (constraints.maxWidth * 0.45 - 150),
            color: text3,
          ),
        ]),
      ));
      searchResultWidgetList.add(SizedBox(height: 10));
    }
    if (webPage['inline_videos'] != null) {
      searchResultWidgetList.add(Container(
        width: constraints.maxWidth * 0.9,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.ondemand_video,
              color: text3,
            ),
            SizedBox(width: 10),
            Text(
              "Videos",
              style: style1.copyWith(color: text1, fontSize: 16),
            )
          ],
        ),
      ));
      for (Map inlineVideo in webPage['inline_videos']) {
        searchResultWidgetList
            .add(SearchVideoItem(constraints: constraints, video: inlineVideo));
      }
      searchResultWidgetList.add(Container(
          color: text4, width: constraints.maxWidth * 0.9, height: 0.4));
      searchResultWidgetList.add(SizedBox(
        height: 15,
      ));
    }
    List normalResponses = webPage['organic_results'];

    print("Data: " + normalResponses.toString());
    for (Map normalResponse in normalResponses) {
      searchResultWidgetList.add(NormalResponseWidget(
        response: normalResponse,
        constraints: constraints,
      ));
    }
    if (webPage['related_searches'] != null) {
      searchResultWidgetList.add(RelatedSearches(
          constraints: constraints,
          relatedSearches: webPage['related_searches']));
    }
    searchResultWidgetList.add(endingWidget(
      constraints,
      webPage['pagination'],
    ));
    loading = false;
    setState(() {});
  }

  void showImageResults(BoxConstraints constraints) async {
    loading = true;
    selectedTypesOfResults = 'Images';
    setState(() {});

    Uri url = Uri.parse(
        'https://serpapi.com/search.json?q=${searchController.text}&tbm=isch&api_key=$serpApiKey');
    print("URL:" + url.toString());
    http.Response response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      "q": searchController.text,
      "api_key": serpApiKey,
      'tbm': 'isch',
      'ijn': '0'
    });
    Map webPage = jsonDecode(response.body);
    searchResultWidgetList = [];
    searchResultWidgetList.add(SizedBox(height: 10));
    List<Widget> suggestedSearches = [];
    for (Map search in webPage['suggested_searches']) {
      suggestedSearches.add(SuggestedImageSearches(
        search: search,
        constraints: constraints,
        onTap: () {
          searchController.text = search['name'];
          showImageResults(constraints);
        },
      ));
    }
    searchResultWidgetList.add(SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: suggestedSearches,
      ),
    ));
    // print(webPage);
    List<Widget> imageResults1 = [];
    List<Widget> imageResults2 = [];
    List<Widget> imageResults3 = [];
    List<Widget> imageResults4 = [];
    int remainder = 0;
    for (Map imageResult in webPage['images_results']) {
      print(remainder);
      switch (remainder) {
        case 0:
          imageResults1.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                onTap: () {},
                child: Column(children: <Widget>[
                  FadeInImage(
                    width: constraints.maxWidth * 0.2,
                    image: NetworkImage(imageResult['thumbnail'].toString()),
                    placeholder: AssetImage('assets/Loading.gif'),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Text(imageResult['title'].toString(),
                        style: style1.copyWith(color: text2, fontSize: 16)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(imageResult['source'].toString(),
                      style: style1.copyWith(color: text3, fontSize: 10)),
                ]),
              ),
            ),
          ));
          remainder = 1;
          break;
        case 1:
          imageResults2.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                onTap: () {},
                child: Column(children: <Widget>[
                  FadeInImage(
                    width: constraints.maxWidth * 0.2,
                    image: NetworkImage(imageResult['thumbnail'].toString()),
                    placeholder: AssetImage('assets/Loading.gif'),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Text(imageResult['title'].toString(),
                        style: style1.copyWith(color: text2, fontSize: 16)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(imageResult['source'].toString(),
                      style: style1.copyWith(color: text3, fontSize: 10)),
                ]),
              ),
            ),
          ));
          remainder = 2;
          break;
        case 2:
          imageResults3.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                onTap: () {},
                child: Column(children: <Widget>[
                  FadeInImage(
                    width: constraints.maxWidth * 0.2,
                    image: NetworkImage(imageResult['thumbnail'].toString()),
                    placeholder: AssetImage('assets/Loading.gif'),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Text(imageResult['title'].toString(),
                        style: style1.copyWith(color: text2, fontSize: 16)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(imageResult['source'].toString(),
                      style: style1.copyWith(color: text3, fontSize: 10)),
                ]),
              ),
            ),
          ));
          remainder = 3;
          break;
        case 3:
          imageResults4.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                onTap: () {},
                child: Column(children: <Widget>[
                  FadeInImage(
                    width: constraints.maxWidth * 0.2,
                    image: NetworkImage(imageResult['thumbnail'].toString()),
                    placeholder: AssetImage('assets/Loading.gif'),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: Text(imageResult['title'].toString(),
                        style: style1.copyWith(color: text2, fontSize: 16)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(imageResult['source'].toString(),
                      style: style1.copyWith(color: text3, fontSize: 10)),
                ]),
              ),
            ),
          ));
          remainder = 0;
          break;
      }
    }
    searchResultWidgetList.add(SizedBox(height: 10));
    searchResultWidgetList.add(Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: imageResults1),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: imageResults2),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: imageResults3),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: imageResults4),
      ],
    )));
    loading = false;
    setState(() {});
  }

  Widget endingWidget(BoxConstraints constraints, Map pagination) {
    List<Widget> numberList = [];
    numberList = List<int>.generate(10, (i) => i + 1).map((int e) {
      return InkWell(
        onTap: () {
          pagination['current'] != e
              ? fetchResults(constraints, pageNumber: e)
              : print(e);
          print(e);
        },
        onHover: (_) {},
        child: Text(
          e.toString(),
          style: TextStyle(
              color: pagination['current'] == e ? text3 : text4,
              fontSize: 14,
              fontWeight: pagination['current'] == e
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
      );
    }).toList();
    return InkWell(
      onTap: () {},
      child: Container(
        width: constraints.maxWidth,
        color: moduleBar,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Mercury Browser",
              style: TextStyle(
                  color: text1, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: constraints.maxWidth < 200 ? constraints.maxWidth : 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: numberList,
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NormalResponseWidget extends StatefulWidget {
  Map response;
  BoxConstraints constraints;
  NormalResponseWidget({required this.response, required this.constraints});

  @override
  _NormalResponseWidgetState createState() => _NormalResponseWidgetState();
}

class _NormalResponseWidgetState extends State<NormalResponseWidget> {
  bool _hover = false;
  bool _underline = false;
  List<Widget> richSnippet = [];
  List<Widget> sitelinks = [];
  @override
  void initState() {
    super.initState();

    if (widget.response['rich_snippet'] != null) {
      if (widget.response['rich_snippet']['bottom'] != null) {
        for (String s in widget.response['rich_snippet']['bottom']
            ['extensions']) {
          richSnippet.add(RichText(
            text: TextSpan(
                style: TextStyle(
                  color: text4,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: s.split(':').first,
                    style: TextStyle(
                        color: text3,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ':' + s.split(':').last,
                  ),
                ]),
          ));
        }
      }
    }
    if (widget.response['sitelinks'] != null) {
      if (widget.response['sitelinks'].containsKey('inline')) {
        for (Map s in widget.response['sitelinks']['inline']) {
          sitelinks.add(SitelinkWidget(
            title: s['title'],
          ));
          sitelinks.add(SizedBox(
            width: 15,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        width: widget.constraints.maxWidth * 0.9,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  MouseRegion(
                    cursor:
                        !_hover ? MouseCursor.defer : SystemMouseCursors.click,
                    onEnter: (v) {
                      _hover = true;
                      setState(() {});
                    },
                    onExit: (v) {
                      _hover = false;
                      setState(() {});
                    },
                    child: Text(
                      widget.response['displayed_link'],
                      style: style1.copyWith(fontSize: 10, color: text3),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openWebPage(widget.response['link'], context);
                    },
                    child: MouseRegion(
                      cursor: !_underline
                          ? MouseCursor.defer
                          : SystemMouseCursors.click,
                      onEnter: (v) {
                        _underline = true;
                        setState(() {});
                      },
                      onExit: (v) {
                        _underline = false;
                        setState(() {});
                      },
                      child: Text(
                        widget.response['title'],
                        style: style1.merge(TextStyle(
                            color: text1,
                            fontSize: 18,
                            decoration: _underline
                                ? TextDecoration.underline
                                : TextDecoration.none)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.response['snippet'],
                    style: style1.merge(TextStyle(color: text4, fontSize: 8)),
                  ),
                ] +
                (richSnippet.isEmpty ? <Widget>[] : richSnippet) +
                (sitelinks.isEmpty
                    ? <Widget>[]
                    : <Widget>[
                        Row(
                          children:
                              (sitelinks.isEmpty ? <Widget>[] : sitelinks),
                        )
                      ])),
      ),
    );
  }
}

// ignore: must_be_immutable
class LocalResultWidget extends StatefulWidget {
  BoxConstraints constraints;
  Map place;
  LocalResultWidget({Key? key, required this.constraints, required this.place})
      : super(key: key);

  @override
  _LocalResultWidgetState createState() => _LocalResultWidgetState();
}

class _LocalResultWidgetState extends State<LocalResultWidget> {
  late Map place;
  late BoxConstraints constraints;
  bool _underline = false;
  @override
  void initState() {
    super.initState();
    place = widget.place;
    constraints = widget.constraints;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: !_underline ? MouseCursor.defer : SystemMouseCursors.click,
        onEnter: (v) {
          _underline = true;
          setState(() {});
        },
        onExit: (v) {
          _underline = false;
          setState(() {});
        },
        child: Container(
          width: constraints.maxWidth * 0.9,
          height: 100,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: text4, width: 0.4))),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    place['title'],
                    style: style1.merge(TextStyle(
                        color: text1,
                        fontSize: 16,
                        decoration: _underline
                            ? TextDecoration.underline
                            : TextDecoration.none)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        place['rating'].toString(),
                        style: style1.copyWith(fontSize: 14, color: text3),
                      ),
                      SizedBox(
                        width: 0.8,
                      ),
                      RatingBar.builder(
                        initialRating: place['rating'],
                        minRating: place['rating'],
                        maxRating: place['rating'],
                        direction: Axis.horizontal,
                        itemSize: 16,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '(${place['reviews'].toString()}) · ${place['type'].toString()}',
                        style: style1.copyWith(fontSize: 14, color: text3),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    '${place['address'].toString()}',
                    style: style1.copyWith(fontSize: 14, color: text3),
                  ),
                ],
              ),
              Spacer(),
              Image.network(
                place['thumbnail'],
                height: 80,
                width: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RelatedQuestionsWidgets extends StatefulWidget {
  BoxConstraints constraints;
  Map question;
  RelatedQuestionsWidgets(
      {Key? key, required this.constraints, required this.question})
      : super(key: key);

  @override
  _RelatedQuestionsWidgetsState createState() =>
      _RelatedQuestionsWidgetsState();
}

class _RelatedQuestionsWidgetsState extends State<RelatedQuestionsWidgets>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  bool _underline = false;
  bool _hover = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // animation = AnimationLen
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: text4, width: 0.4))),
        width: widget.constraints.maxWidth,
        duration: Duration(milliseconds: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: InkWell(
                  onTap: () {
                    if (completed) {
                      animationController.forward(from: 0);
                    } else {
                      animationController.reverse();
                    }
                    completed = !completed;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Text(
                        widget.question['question'],
                        style: TextStyle(color: text2, fontSize: 16),
                      ),
                      Spacer(),
                      RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5)
                              .animate(animationController),
                          child: Icon(Icons.keyboard_arrow_up))
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 3),
                      Container(
                        width: widget.constraints.maxWidth * 0.9,
                        child: Text(
                          widget.question['snippet'].length <
                                  widget.question['title'].length
                              ? widget.question['title']
                              : widget.question['snippet'],
                          style: style1.copyWith(color: text4, fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 15),
                      widget.question['displayed_link'] == null
                          ? Container()
                          : MouseRegion(
                              cursor: !_hover
                                  ? MouseCursor.defer
                                  : SystemMouseCursors.click,
                              onEnter: (v) {
                                _hover = true;
                                setState(() {});
                              },
                              onExit: (v) {
                                _hover = false;
                                setState(() {});
                              },
                              child: Text(
                                widget.question['displayed_link'],
                                style:
                                    style1.copyWith(fontSize: 10, color: text3),
                              ),
                            ),
                      SizedBox(height: 5),
                      MouseRegion(
                        cursor: !_underline
                            ? MouseCursor.defer
                            : SystemMouseCursors.click,
                        onEnter: (v) {
                          _underline = true;
                          setState(() {});
                        },
                        onExit: (v) {
                          _underline = false;
                          setState(() {});
                        },
                        child: Text(
                          titleCase(widget.question['snippet'].length <
                                  widget.question['title'].length
                              ? widget.question['link']
                                  .toString()
                                  .split('/')[widget.question['link']
                                          .toString()
                                          .split('/')
                                          .length -
                                      2]
                                  .replaceAll('-', ' ')
                              : widget.question['title']),
                          style: style1.merge(TextStyle(
                              color: text2,
                              fontSize: 14,
                              decoration: _underline
                                  ? TextDecoration.underline
                                  : TextDecoration.none)),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  crossFadeState: completed
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 200))
            ]));
  }
}

class SearchVideoItem extends StatefulWidget {
  BoxConstraints constraints;
  Map video;
  SearchVideoItem({Key? key, required this.constraints, required this.video})
      : super(key: key);

  @override
  _SearchVideoItemState createState() => _SearchVideoItemState();
}

class _SearchVideoItemState extends State<SearchVideoItem> {
  late Map video;
  late BoxConstraints constraints;
  bool _underline = false;
  @override
  void initState() {
    super.initState();
    video = widget.video;
    constraints = widget.constraints;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: !_underline ? MouseCursor.defer : SystemMouseCursors.click,
        onEnter: (v) {
          _underline = true;
          setState(() {});
        },
        onExit: (v) {
          _underline = false;
          setState(() {});
        },
        child: Container(
          width: constraints.maxWidth * 0.9,
          height: 70,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: text4, width: 0.4))),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                child: Stack(
                  children: [
                    Image.network(
                      video['thumbnail'],
                      height: 90,
                      width: 90,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 15),
                        child: Container(
                          height: 8,
                          width: 15,
                          decoration: BoxDecoration(
                              color: text2,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              video['duration'] != null
                                  ? video['duration']
                                  : '',
                              style: style1.copyWith(color: text4, fontSize: 6),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    video['title'],
                    style: style1.merge(TextStyle(
                        color: text1,
                        fontSize: 16,
                        decoration: _underline
                            ? TextDecoration.underline
                            : TextDecoration.none)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  RichText(
                    text: TextSpan(
                        style: style1.copyWith(
                            fontSize: 14,
                            color: text3,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '${video['platform'].toString()}',
                          ),
                          TextSpan(
                              text: ' · ${video['channel'].toString()}',
                              style: style1.copyWith(
                                fontSize: 14,
                                color: text4,
                              )),
                        ]),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    '${video['date'].toString()}',
                    style: style1.copyWith(
                      fontSize: 12,
                      color: text4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RelatedSearches extends StatefulWidget {
  BoxConstraints constraints;
  List relatedSearches;
  RelatedSearches(
      {Key? key, required this.constraints, required this.relatedSearches})
      : super(key: key);

  @override
  _RelatedSearchesState createState() => _RelatedSearchesState();
}

class _RelatedSearchesState extends State<RelatedSearches> {
  late BoxConstraints constraints;
  late List relatedSearches;

  @override
  void initState() {
    super.initState();
    constraints = widget.constraints;
    relatedSearches = widget.relatedSearches;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.constraints.maxWidth * 0.9,
      child: Column(
        children: <Widget>[
          Text(
            "Related Searches",
            style: style1.merge(
              TextStyle(
                color: text1,
                fontSize: 20,
              ),
            ),
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: (22 * relatedSearches.length).toDouble(),
            width: constraints.maxWidth * 0.9,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: constraints.maxWidth * 0.3,
                    childAspectRatio: constraints.maxWidth * 0.4 / 50,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: relatedSearches.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: widget.constraints.maxWidth * 0.3,
                      height: 20,
                      decoration: BoxDecoration(
                          color: moduleBadge,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.constraints.maxWidth * 0.03),
                            child: Icon(Icons.search, color: text2),
                          ),
                          Text(
                            relatedSearches[index]['query'],
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: text2,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SitelinkWidget extends StatefulWidget {
  String title;
  SitelinkWidget({Key? key, required this.title}) : super(key: key);

  @override
  _SitelinkWidgetState createState() => _SitelinkWidgetState();
}

class _SitelinkWidgetState extends State<SitelinkWidget> {
  bool _underline = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: !_underline ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: (PointerEnterEvent e) {
        _underline = true;
        setState(() {});
      },
      onExit: (PointerExitEvent e) {
        _underline = false;
        setState(() {});
      },
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: text3,
              fontSize: 22,
            ),
            children: [
              TextSpan(
                text: widget.title,
                style: TextStyle(
                  color: text2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: _underline
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
              TextSpan(text: ' '),
              TextSpan(
                text: '·',
              ),
            ]),
      ),
    );
  }
}

class SuggestedImageSearches extends StatefulWidget {
  BoxConstraints constraints;
  Map search;
  Function onTap;
  SuggestedImageSearches(
      {Key? key,
      required this.constraints,
      required this.search,
      required this.onTap})
      : super(key: key);

  @override
  _SuggestedImageSearchesState createState() => _SuggestedImageSearchesState();
}

class _SuggestedImageSearchesState extends State<SuggestedImageSearches> {
  Color containerColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    // print(widget.search);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        onHover: (bool hovering) {
          if (hovering) {
            print("Hee haww");
            containerColor = Colors.grey[300]!;
            setState(() {});
            return;
          }
          containerColor = Colors.white;
          setState(() {});
        },
        onTap: () {
          widget.onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 40,
          constraints: BoxConstraints(minWidth: 80),
          child: Row(
            children: <Widget>[
              Image(
                height: 35,
                width: 35,
                image: (widget.search['thumbnail'] == null
                        ? AssetImage('assets/loading.gif')
                        : NetworkImage(widget.search['thumbnail'].toString()))
                    as ImageProvider,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                titleCase(widget.search['name'].toString()),
                style: style1.copyWith(color: text2, fontSize: 16),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String titleCase(String text) {
  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

void openWebPage(String url, BuildContext context) async {
  // windowController = WindowController();
  // windowController!.openHttp(
  //   uri: Uri.parse(url),
  // );
  // windowController!.window;

  // final html.IFrameElement _iframeElement = html.IFrameElement();

  // _iframeElement.height = '500';
  // _iframeElement.width = '1000';
  // _iframeElement.src = 'https://www.youtube.com/embed/RQzhAQlg2JQ';
  // _iframeElement.style.border = 'none';

  // ui.platformViewRegistry.registerViewFactory(
  //   url,
  //   (int viewId) => _iframeElement,
  // );
  // await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Material(
  //         child: Container(
  //           width: 500,
  //           height: 500,
  //         ),
  //       );
  //     });
  // await launch(url);
}
