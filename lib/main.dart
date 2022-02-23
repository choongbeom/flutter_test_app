import 'package:flutter/material.dart';
import 'pages/database.dart';
import 'pages/infinite_scroll.dart';
import 'pages/map.dart';
import 'pages/mypermission.dart';
import 'pages/restApi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _pageIndex = 0;
  final double _buttonWidth = 130.0;
  final double _buttonHeight = 50.0;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바
      appBar: AppBar(
        title: const Text('Demo'),
        // 아이콘 색상을 테마를 이용하여 변경함.
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.amber, // appBar color
        centerTitle: true, // 중앙 정렬
        elevation: 6, // 상단바 그림자 강도
        actions: <Widget>[
          IconButton(            
            icon: const Icon(Icons.search),
            onPressed: (){
              // ignore: avoid_print
              print('Search button is clicked');
            }, 
          ),  
          IconButton(
            icon: const Icon(Icons.shopping_cart), // 카트 아이콘 생성
            onPressed: () {
              // 아이콘 버튼 실행
              // ignore: avoid_print
              print('Shopping cart button is clicked');
            },
          ),
        ],
      ),

      // sidebar
      drawer: Drawer(      
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  // 현재 계정 이미지 set
                  backgroundImage: AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.white,
                ),
                /*otherAccountsPictures: <Widget>[
                  // 다른 계정 이미지[] set
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/profile2.png'),
                  ),
                ],*/
                accountName: Text('CBKIM'),
                accountEmail: Text('toonme@email.com'),
                // 다른계정이 있을 경우 선택할 수 있는 화살표 생성
                // const를 사용하면 해당 함수적용이 안됨.
                /*onDetailsPressed: (){
                  // ignore: avoid_print
                  print("arrow is clicked");
                },*/
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
              },
            ),
          ],
        ),
      ),

      // body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("InfiniteScroll"), 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfiniteScroll()),
                  );
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("Map"), 
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Map()),
                  );
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("MyPermission"), 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyPermission()),
                  );
                }, 
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("RestApi"), 
                onPressed: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RestApi()),
                  );
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("DataBase"), 
                onPressed: () {   
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DataBase()),
                  );             
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {
                }, 
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {                
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {                
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {
                }, 
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {                
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {                
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {
                }, 
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {                
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {                
                }, 
              ),
              ElevatedButton( 
                style: ElevatedButton.styleFrom(fixedSize: Size(_buttonWidth, _buttonHeight)),
                child: const Text("None"), 
                onPressed: () {
                }, 
              )
            ]
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // 접근성 기능에서 사용됩니다.
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: (){},
      ),

      // 네이게이션바
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          currentIndex: _pageIndex,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black26,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'photo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'more',
            )
          ],
        ),
    );
  }
}
