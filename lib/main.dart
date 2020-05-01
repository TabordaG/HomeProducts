import 'package:course_app/constants.dart';
import 'package:course_app/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

PanelController _pc = new PanelController();

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
    double initialSize = 1 - (265 / MediaQuery.of(context).size.height);
    print(initialSize);
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          controller: _pc,
          renderPanelSheet: false,
          // backdropEnabled: true,
          minHeight: MediaQuery.of(context).size.height * initialSize,
          maxHeight: MediaQuery.of(context).size.height + 50,
          panelBuilder: (ScrollController sc) => _gridView(controller: sc),
          // collapsed: _floatingCollapsed(),
          header: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(76, 150, 203, .8),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
            ),
            height: 40,
            width: MediaQuery.of(context).size.width - 20,
            margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            child: Center(
              child: Text(
                "Produtos",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: Center(
            child: TopPageHome(),
          ),
        ),
      ),
    );
  }
}

Widget _gridView ({ScrollController controller}) {
  return Container(
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.all(Radius.circular(24.0)),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center, 
        colors: [const Color.fromRGBO(76, 150, 203, .6), Colors.white.withAlpha(50)], 
      ),
      // boxShadow: [
      //   BoxShadow(
      //     blurRadius: 20.0,
      //     color: Colors.grey[50],
      //   ),
      // ]
    ),
    margin: const EdgeInsets.only(left: 10.0, top: 60.0, right: 10.0, bottom: 30),
    child: SizedBox.expand(
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
        controller: controller, //SliverStaggeredGridDelegateWithFixedCrossAxisCount usar com CustomScrollView
        crossAxisCount: 2,
        shrinkWrap: false,
        itemCount: categories.length,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            height: 180, //index.isEven ? 200 : 240,
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
                  '${categories[index].numOfCourses}',
                  style: TextStyle(
                    color: kTextColor.withOpacity(.8),
                  ),
                )
              ],
            ),
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      ),
    ),
  );
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
              SvgPicture.asset(
                "assets/icons/menu.svg",
                color: Color.fromRGBO(76, 150, 203, 1).withAlpha(255),
              ),
              Image.asset("assets/images/user.png"),
            ],
          ),
          SizedBox(height: 20),
          Text("Olá Gabriel,", style: kHeadingextStyle),
          Text("Encontre o produto perfeito para sua mesa", style: kSubheadingextStyle),
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
                SvgPicture.asset(
                  "assets/icons/search.svg",
                  color: Color.fromRGBO(76, 150, 203, 1),
                ),
                SizedBox(width: 10),
                Text(
                  "Procurar",
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
              Text("Categoria", style: kTitleTextStyle),
              Text(
                "Ver Todos",
                style: kSubtitleTextSyule.copyWith(
                    color: Color.fromRGBO(76, 150, 203, 1)),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}