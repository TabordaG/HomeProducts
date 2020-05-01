import 'package:course_app/constants.dart';
import 'package:course_app/model/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

PanelController _pc = new PanelController();
TextEditingController _search = TextEditingController();
TextEditingController _filtro = TextEditingController(text: 'Ver Todos');

List _categorias =
  ["Ver Todos", "Frutas", "Verduras", "Legumes", "Outros"];

List<DropdownMenuItem<String>> _dropDownMenuItems;

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
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _filtro.text = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double initialSize = 1 - (265 / MediaQuery.of(context).size.height);
    print(initialSize);
    print(MediaQuery.of(context).size.height);
    return SafeArea(
      child: Scaffold(
        body: SlidingUpPanel(
          controller: _pc,
          renderPanelSheet: false,
          minHeight: MediaQuery.of(context).size.height * initialSize,
          maxHeight: MediaQuery.of(context).size.height,
          panelBuilder: (ScrollController sc) => _gridView(controller: sc),
          header: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(59, 112, 162, 1),
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
    color: Color.fromRGBO(193, 218, 242, 1),
    margin: const EdgeInsets.only(left: 10.0, top: 60.0, right: 10.0, bottom: 30),
    child: SizedBox.expand(
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
        controller: controller,
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

class TopPageHome extends StatefulWidget {
  const TopPageHome({
    Key key,
  }) : super(key: key);

  @override
  _TopPageHomeState createState() => _TopPageHomeState();
}

class _TopPageHomeState extends State<TopPageHome> {
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
                color: Color.fromRGBO(23, 69, 128, 1),
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
                GestureDetector(
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: Color.fromRGBO(59, 112, 162, 1),
                  ),
                  onTap: () {
                    setState(() {
                      print(_search.text);
                      _pc.animatePanelToPosition(1, duration: Duration(milliseconds: 1500), curve: Curves.fastOutSlowIn);
                    });
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: "Procurar", 
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFA0A5BD),
                      ),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _search.text = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Categoria", style: kTitleTextStyle),
              GestureDetector(
                child: Text(
                  _filtro.text,
                  style: kSubtitleTextSyule.copyWith(
                      color: Color.fromRGBO(59, 112, 162, 1)),
                ),
                onDoubleTap: () => print('Double Tap'),
                onTap: () => DropdownButton(
                  value: _filtro.text,
                  items: _dropDownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _filtro.text = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> getDropDownMenuItems() {
  List<DropdownMenuItem<String>> items = new List();
  for (String categoria in _categorias) {
    items.add(new DropdownMenuItem(
        value: categoria,
        child: new Text(categoria)
    ));
  }
  return items;
}