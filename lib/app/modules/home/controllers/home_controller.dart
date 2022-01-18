import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "hem-dashboard",
  "private_key_id": "4bd44a58d7cbc4ac52f68c1dd9879de934e88d80",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDI5gK2AEZ6nOSV\n7KsVT/azm9EBpEJfX+53zD/AkqhpNsGuCLNc0wQl+OlfpHSdTp1WyrBM7vz1QjGP\nJUqBBNEAUYnKufxKru+Bs7ucQ3VsbZ4kgvfmmIFX68+UBTNquJBD2bEkZoUe2iyU\nfN6Y1/miwraDTgPS88D9bDqbA/X9zYReE9XAWaYA6vBIGOVP1q6pmdNGSHRJ8+Rm\n6n9FIWwj+M83OxvoS5fBZBdtpQheaUvG0LUvtP0Xx1QdwkmqS9kcgUztOjFuadxQ\nLrzheupGgFx2JU2WLoLI12oK6p5EmUNrYV0vYfI7aH0x0xOmnu12uDK54Iitm4u9\nIxZNLPJXAgMBAAECggEAFrdfdhn43jNwa3176OiGUk/bpc5fjO5JhjVLvig3L9J3\nuwiT03qu3OZU6TIs137ErsQzhDd/1fG6rd9/GbCkO19877XxD7bRMT7UB3rfQ7fv\nalx+0I3NDlaFPc0Kv9YHxgxPCfkns1HjOZUXDHxbZ2qR/a3sI8XZPC6pP88GWUDZ\nHGQetlhO7OJ4ICPeKJRcXJcRErvJY9GeB0lekiCnD7up1MHtKqCQku/VywMKAvox\nKOjaI+bskFpCkrKRHVkajKdIT+X/u9Hpe+DNARMG1woW1+HSV+sFt5kjcJNadY2a\nicDh96L9xoP4wjp1I2pHqPL1tzCnyNK5Q1ZzNsmGUQKBgQDmPuNMUr+r8V6+Vc2+\nbmgyBTAY730jPGlJUULk/DYSgsV80kXJ5T2Fl9gCuOLJgLbNaVqfJZsMAoohuL1t\nOJX6s2PHKSuw+/nsrbV08Bi3zBDFU4OO2lUHt8cQNXzr+QhgI9sdkeBhCPO05dgE\nBh4j9Bn59UIyWKaDSBxPgcsbhwKBgQDfXsND/iOzX7Jvy+nlUJ2pMMHC+3pR+2Mx\nz21UR0Dg4SvOVFDRI0cq90lZIP7w+4DHHVO2JkD2TpuqD9v7n99/79TkQk9bQ9SK\nITYuKLCiyJ1vuEKiHyw2dHlII5PnFYRp6I+00+ZJsADoNcKrhK3vhQykGJGXPmYL\nwQ3OBghGsQKBgBY1AJVO8d+yoxG2kuaIHZKdf3sYNjiczgbdSJdvYAO/Cy8z1LlZ\nW+qzr4jrriwDNx5ux+fLp72rzQjdmZ+cMpMAlGIULXufggZ65qKFucyYaRGvMWQo\n2MSqzA9bKVZVKaKkMrESbdLOGztaY9BXirarB4pdRmo2tLC61sgwW5enAoGAG8D7\nhCQ8rVnzot50VnDY1h/fw2lZvnv8zECYtgMQdaCkv8NMM2AtxJHrRC7MXobxbkwf\njZ9dLP2Ba/UCgVZQ/+V9z0rJ724TJ4KO59dYczF4FlyPsvMqnC2GsEbzZqAOztX9\nnRtDHt7GjhO393XJ4tvmQTFoTaGMLmOzYmjveFECgYBPJpITs1QpfC1frECRLaLr\nJMPOrjzUQp5D0qVMEdc8RRgPzMS9BRlEbwEWfOQAYLsLYqAuMjHmHCEoH6ZZHtPA\nIrgfaZh0o5x7Sd/qORWUEwjneN6W225yipamAPFTRiSpOO1MaSv/6ntFnnVh1Akt\nnew7kDJ2tiVeztWQ3SqfqA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@hem-dashboard.iam.gserviceaccount.com",
  "client_id": "103208223460864042695",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40hem-dashboard.iam.gserviceaccount.com"
}
''';
const _spreadsheetId = '1Aj3A0aTxXuhgCBHfNpe9DIBfpIRtXd3PhNqM31ohntw';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late final ss; 
  late final gsheets; 
  late var sheet;
  int count = 0;
  @override
  void onInit() async{
    super.onInit();
  }

  Future<String> getText() async{
    gsheets = GSheets(_credentials);
    ss = await gsheets.spreadsheet(_spreadsheetId);
    sheet = await ss.worksheetByTitle('heart');
    String temp = await sheet.values.value(column: 2, row: 2);
    print('line 35 : $temp');
    sendInfo();
    return temp;
  }

  void sendInfo() async{
    if(count == 0){
      gsheets = GSheets(_credentials);
      ss = await gsheets.spreadsheet(_spreadsheetId);
      sheet = await ss.worksheetByTitle('heart');
    }
    
    for(int k = 1; k <= 60; k++){
      List<String> temp=[];
      // for(int i = 1 ; i <= 14; i++){
      //   temp.add(await sheet.values.value(column : i, row: k));
      // }
      temp = await sheet.values.row(count+2); 
      print(temp.toString());
      await analytics.logEvent(name: 'heart_disease', parameters: {
        'age' : temp[0],
        'sex' : temp[1],
        'cp' : temp[2],	
        'trestbps' : temp[3],	
        'chol' : temp[4],	
        'fbs' : temp[5],	
        'restecg' : temp[6],	
        'thalach' : temp[7],	
        'exang' : temp[8],	
        'oldpeak' : temp[9],	
        'slope' : temp[10],	
        'ca' : temp[11],	
        'thal' : temp[12],	
        'target' : temp[13],
      });
      count++;
      update();
    }
    
  }
  
}
