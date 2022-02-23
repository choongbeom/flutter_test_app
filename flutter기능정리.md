# flutter 기능 정리

* 샘플소스 이외 기능 정리
    * 다일로그를 생성
        * 'showDialog()' 이용하여 구현
        * Future.delayed(Duration(seconds: 3), () { Navigator.pop(context); });를 이용하여 자동종료를 구현할 수 있음. (예시> 3초이후 종료)

```
void _showDialog() { 
    showDialog(
      context: context,
      builder: (BuildContext context) { 
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          content: SizedBox(
            height: 200,
            child: Center(
              child:SizedBox(
                child: 
                    new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(Colors.blue),
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
```
 
* 이모티콘 코드 : https://apps.timwhitlock.info/emoji/tables/unicode

* 버튼의 종류는 4가지로 구분됨 (TextButton, ElevatedButton(구 RaisedButton), OutlinedButton, IconButton)


