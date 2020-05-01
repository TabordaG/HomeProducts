import 'package:course_app/constants.dart';
import 'package:course_app/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course App',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double initialSize = 1 - (275 / MediaQuery.of(context).size.height);
    print(initialSize);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            TopPageHome(),
            DraggableScroll(initialSize: initialSize),
          ],
        ),
      ),
    );
  }
}

class DraggableScroll extends StatelessWidget {
  const DraggableScroll({
    Key key,
    @required this.initialSize,
  }) : super(key: key);

  final double initialSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: initialSize,
        minChildSize: initialSize,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
              color: Color.fromRGBO(39, 113, 177, 1),
            ),
            padding: EdgeInsets.only(top: 20, right: 10, left: 10),
            child: ListView(
              controller: scrollController,
              children: <Widget>[
                Center(child: Text('Teste ListView')),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  // height: 200,
                  height: initialSize * MediaQuery.of(context).size.height,
                  child: StaggeredGridView.countBuilder(                      
                    // controller: scrollController, //SliverStaggeredGridDelegateWithFixedCrossAxisCount usar com CustomScrollView
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        height: index.isEven ? 200 : 240,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(categories[index].image),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              categories[index].name,
                              style: kTitleTextStyle,
                            ),
                            Text(
                              '${categories[index].numOfCourses} Courses',
                              style: TextStyle(
                                color: kTextColor.withOpacity(.5),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class TopPageHome extends StatelessWidget {
  const TopPageHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SvgPicture.asset("assets/icons/menu.svg", color: Color.fromRGBO(76, 150, 203, 1),),
              Image.asset("assets/images/user.png"),
            ],
          ),
          SizedBox(height: 20),
          Text("Hey Gabriel,", style: kHeadingextStyle),
          Text("Find a product you want to taste",
              style: kSubheadingextStyle),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset("assets/icons/search.svg", color: Color.fromRGBO(76, 150, 203, 1),),
                SizedBox(width: 10),
                Text(
                  "Search for anything",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFA0A5BD),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category", style: kTitleTextStyle),
              Text(
                "See All",
                style: kSubtitleTextSyule.copyWith(color: Color.fromRGBO(76, 150, 203, 1)),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

class DragabbleScrollableSheetDemo extends StatefulWidget {
  @override
  _DragabbleScrollableSheetDemoState createState() =>
      _DragabbleScrollableSheetDemoState();
}

class _DragabbleScrollableSheetDemoState
    extends State<DragabbleScrollableSheetDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DraggableScrollableSheet'),
        ),
        body: Container(
          child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (BuildContext context, myscrollController) {
              return Container(
                color: Colors.tealAccent[200],
                child: ListView.builder(
                  controller: myscrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(
                      'Dish $index',
                      style: TextStyle(color: Colors.black54),
                    ));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
