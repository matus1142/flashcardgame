import 'package:flashcardgame/providers/FlashcardProvider.dart';
import 'package:flashcardgame/screen/dict_screen.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:provider/provider.dart';


const credentials = r'''
{
  "type": "service_account",
  "project_id": "fluttergsheet-369614",
  "private_key_id": "c9b2ed8d2ba18a4ceab9bcbe3a33ed4d6cd5b097",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCtywZ8UG6zg5Zf\nOwKgtyDdgjHy2olL3jGiEwnZXKpSeCBIsQuhsR9j9w8z/3eWNOky/wZURFjfqmnE\nB27liRsnPbPs8Z0GftImkMmpWTPIi2oBhpU3wxtHxwcVRoXme4p0cOpWm6zsEQ9R\naa6K9CUIY0Lm10Q8jqHPAKJMWcGep7uxc3MxHBFHUSw14OmYGnNzLz9WiFg05F4Q\nPgXYMtFwfI4MxSEDvpO/7DxvPBRb+8+DHEahNO+ErPd7Ym9pQGMufynRcSt9akPp\nerBOHbwtRSmts6xxnhjeJD7xHDewZDMSfOj95xFFbbz4YBs/eV4ho5ksgO8d427A\n/hbg9qXjAgMBAAECggEADDREdX4HyrxerBD5RhmbXw1m/jOsI4iWugJrP8565Bqt\nGF2yaugvbkt++lBMxglbfOodYtUqhokG2gNe8r3Liy275lOF4DBksoearwqQETD/\nwIatENg3ILW7FhqN3u8QUc1MxMiJfp7+ETdXe0jaFuTdjFdT4orDlcU+IG1xzsxr\n8MXboTUtdZJlcN20droTY3w1bbw4pHINMju0im6qL5alycTc812pzKG/zgvYYjh1\niKmexp6MXgp8u2Pex2GL94Nabsuz5Vbhu5USr6zjKa0MwufjWp1HuBmgkd9uHIxb\nS3ySXOOt9LlfjysW6TcLE1tgJqQqEg3w58iIa9ze8QKBgQDY9IWp8A42qpeOuNFn\n9iylPm1pnRiQ2SttG9fIsNpugEGGmmyQu/WZV83ENcazSszziDcWtMT+VQJQ3FVd\nbIyuAk264MfJjHwEOfwazsLYvVLY3fac3oad+QIom4zdNUIV2Ni9dEtgnHW/DBlK\nkyqz5e1hLvPVrMAaKmUrGTyVkQKBgQDNEfSA9upYlPbI1ZmIfNL/Io/jNR82Ga8B\nDUUIkfpj+zBbE1/uW+fz328cvYi2jSK/GnkU4EPU27wviGyUdl/9Y+5Z+Fb7B97F\nfuzdtsg/st8N1LyOFiE5TzYOiY09k0IW2v3pk5mVu6/k5fIOJpECtj/PInED2M4+\nU014tuI6MwKBgGQkwooFp9nt9pVHlEmDpWoFHeXxQMSjqdrsTjdyAvGcvCJQp6pL\nSHumvvFBzV03OtFy39LYUFIBlVcTzUeZcnpjz9NiLHZJJXmh9k+9fs0i3toB4vLX\n+JV0ul1aJ7R3//ArrygMRTrsHaG5CPeWZNCzYlZIoP7Rhb7OMPKq7H8xAoGALJ4S\nd5jBZiKLCylGLWcTNUWczs95CflOlUkA0xuHwgcd/0LY5XCDqBDeCP/H5ggRHkkx\nPPSKbZ6ddC4Xibmzqtr6OgMJUbblpky2Vor1SL6vP0AhAj0YX3K3jTQqUdJfV7+v\n7QkbKnPakk/heWi0tkVW3sdclXyvauoO+gu4bvcCgYEAixOIPuVs6l/1Ky0qlOUi\nkJlvHo5VUSxlP/y9+eoKPRewQUNgeiHlIlS1LDYONrSJg9LgogjBKNaRpgpH1SvO\nHUe8Bx1Lc+zXYhYqomRYJ+IlSCXeceIplr5aIDSRAC7OzH+bJl06cqiZL6cFHCtf\n/MmlundBB39iY2aEclI34eU=\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttergsheet@fluttergsheet-369614.iam.gserviceaccount.com",
  "client_id": "115246316935385633373",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttergsheet%40fluttergsheet-369614.iam.gserviceaccount.com"
}
''';

const spreadsheetId = '1-rLBQdU1Wj0UeUl2CP0xgmiDw6pNOJasmRuWJzxVyhs';

void main() async{
  // final gsheets = GSheets(credentials);
  // final ss = await gsheets.spreadsheet(spreadsheetId);
  // final sheet = ss.worksheetByTitle('Test1');

  //await sheet!.values.insertValue('B',column: 2,row: 1);
  print("a");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [//รับ providers ที่ส่งมา
        ChangeNotifierProvider(create: (context){
          return FlashcardProvider(); // เรียกใช้ FlashcardProvider
        })
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: DictScreen()),
    );
  }
}
