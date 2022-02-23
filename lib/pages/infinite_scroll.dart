import 'package:flutter/material.dart';

// 무한스크롤 구현
class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({Key? key}) : super(key: key);

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  bool _trailingColor = false;

  // 추가 데이터 가져올때 하단 인디케이터 표시용
  //bool _isMoreRequesting = false;

  // 다음 데이터 위치를 파악하기 위함
  int _nextPage = 0;

  // 서버에 저장되어 있는 데이터들(가상으로 사용하기 위해)
  final List<String> _serverItems = [];

  // 실제 데이터를 서버에 가져와 저장되는 데이터(리스트에 표시할때 사용)
  List<String> _items = [];

  // 드레그 거리를 체크하기 위함
  // 해당 값을 평균내서 50%이상 움직였을때 데이터 불러오는 작업을 하게됨.
  double _dragDistance = 0;

  // 로딩창을 다일로그로 표시함.
  void _showDialog() { 
    showDialog(
      context: context,
      builder: (BuildContext context) { 
        /*Future.delayed(const Duration(seconds: 3), () {
          // 기존화면으로 이동
          Navigator.pop(context);
        });*/

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          content: const SizedBox(
            height: 200,
            child: Center(
              child:SizedBox(
                child: 
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      strokeWidth: 5.0
                    ),
                height: 50.0,
                width: 50.0,
              )
            ),
          ), 
        );
      },
    );
  }

  //스크롤 이벤트 처리
  void scrollNotification(notification) {
    // 스크롤 최대 범위
    var containerExtent = notification.metrics.viewportDimension;

    if (notification is ScrollStartNotification) {
      // 스크롤을 시작하면 발생(손가락으로 리스트를 누르고 움직이려고 할때)
      // 스크롤 거리값을 0으로 초기화함
      _dragDistance = 0;
    } else if (notification is OverscrollNotification) {
      // 안드로이드에서 동작
      // 스크롤을 시작후 움직일때 발생(손가락으로 리스트를 누르고 움직이고 있을때 계속 발생)
      // 스크롤 움직인 만큼 빼준다.(notification.overscroll)
      _dragDistance -= notification.overscroll;
    } else if (notification is ScrollUpdateNotification) {
      // ios에서 동작
      // 스크롤을 시작후 움직일때 발생(손가락으로 리스트를 누르고 움직이고 있을때 계속 발생)
      // 스크롤 움직인 만큼 빼준다.(notification.scrollDelta)
      _dragDistance -= notification.scrollDelta!;
    } else if (notification is ScrollEndNotification) {
      // 스크롤이 끝났을때 발생(손가락을 리스트에서 움직이다가 뗐을때 발생)

      // 지금까지 움직인 거리를 최대 거리로 나눈다.
      var percent = _dragDistance / (containerExtent);
      // 해당 값이 -0.4(40프로 이상) 아래서 위로 움직였다면
      if (percent <= -0.4) {
        // maxScrollExtent는 리스트 가장 아래 위치 값
        // pixels는 현재 위치 값
        // 두 같이 같다면(스크롤이 가장 아래에 있다)
        if (notification.metrics.maxScrollExtent ==
            notification.metrics.pixels) {
          setState(() {
            // 서버에서 데이터를 더 가져오는 효과를 주기 위함
            // 하단에 프로그레스 서클 표시용
            //_isMoreRequesting = true;
            _showDialog();
          });

          // 서버에서 데이터 가져온다.
          requestMore().then((value) {
            setState(() {
              // 다 가져오면 하단 표시 서클 제거
              //_isMoreRequesting = false;
              Navigator.pop(context);
            });
          });
        }
      }
    }
  }

  // 서버에서 처음 데이터 가져오기
  Future<void> requestNew() async {
    // ignore: avoid_print
    print('request New');

    _nextPage = 0;
    _items.clear();
    setState(() {
      _items += _serverItems.sublist(_nextPage * 10, (_nextPage * 10) + 10);
      // 다음을 위해 페이지 증가
      _nextPage += 1;
    });

    // 데이터 가져오는 동안 효과를 보여주기 위해 약 1초간 대기하는 것
    // 실제 서버에서 가져올땐 필요없음
    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  // 서버에서 추가 데이터 가져올 때
  Future<void> requestMore() async {
    // 해당부분은 서버에서 가져오는 내용을 가상으로 만든 것이기 때문에 큰 의미는 없다.

    // 읽을 데이터 위치 얻기
    int nextDataPosition = (_nextPage * 10);
    // 읽을 데이터 크기
    int dataLength = 10;

    // 읽을 데이터가 서버에 있는 데이터 총 크기보다 크다면 더이상 읽을 데이터가 없다고 판다.
    if (nextDataPosition > _serverItems.length) {
      // 더이상 가져갈 것이 없음
      return;
    }

    // 읽을 데이터는 있지만 10개가 안되는 경우
    if ((nextDataPosition + 10) > _serverItems.length) {
      // 가능한 최대 개수 얻기
      dataLength = _serverItems.length - nextDataPosition;
    }
    setState(() {
      // 데이터 읽기
      _items += _serverItems.sublist(nextDataPosition, nextDataPosition + dataLength);

      // 다음을 위해 페이지 증가
      _nextPage += 1;
    });

    // 가상으로 잠시 지연 줌
    return await Future.delayed(const Duration(milliseconds: 500));
  }
  

  @override
  // ignore: must_call_super
  initState() {
    //서버의 가상데이터 150개 만들어둠
    for (var i = 0; i < 150; i++) {
      _serverItems.add('item $i');
    }

    _trailingColor = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                height: 150.0,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    /*
                     스크롤 할때 발생되는 이벤트
                     해당 함수에서 어느 방향으로 스크롤을 했는지를 판단해
                     리스트 가장 밑에서 아래서 위로 40프로 이상 스크롤 했을때 
                     서버에서 데이터를 추가로 가져오는 루틴이 포함됨.
                    */
                    scrollNotification(notification);
                    return false;
                  },
                  child: RefreshIndicator(
                    /*
                     리스트에 위에서 아래로 스크롤 하게되면 onRefresh 이벤트 발생
                     서버에서 새로운(최신) 데이터를 가져오는 함수 구현
                    */
                    onRefresh: requestNew,
                    child: ListView.builder(
                      /*
                       리스트의 데이터가 적어 스크롤이 생성되지 않아 스크롤 이벤트를 받을 수 없을수 있기 때문에 아래의 옵션을 추가함.
                       physics: AlwaysScrollableScrollPhysics()
                      */
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            // ignore: unnecessary_string_interpolations
                            title: Text('${_items[index]}'),
                            subtitle: Text('Sub Title ${_items[index]}'),
                            leading: const CircleAvatar(backgroundImage: AssetImage('assets/images/profile2.png')),
                            trailing: IconButton(
                              icon: Icon(Icons.star, color: _trailingColor ?Colors.yellow:Colors.black26),
                              onPressed: (){}
                            ),
                            onTap: (){ 
                              setState(() {
                                if (_trailingColor) {
                                  _trailingColor = false;
                                } 
                                else {
                                  _trailingColor = true;
                                }
                                // ignore: avoid_print
                                print("Card onTap click!");
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            /*
             추가 데이터 가져올때 하단 효과 표시 용
            */ 
            /*         
            Container(
              height: _isMoreRequesting ? 50.0 : 0,
              color: Colors.white,              
              child: const Center (
                 child: CircularProgressIndicator(),
                ),
              ),
            ),*/
          ],
        ), 
    );
  }
}
