import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:remote_hospital/services/pref_util.dart';

class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class DioUtil {
  static final DioUtil _instance =DioUtil._init();
  static Dio _dio;
  static Dio _dio_without_login;
  static BaseOptions _options = getDefOptions();
  factory DioUtil(){
    return _instance;
  }
  DioUtil._init(){
    _dio =new Dio();
    _dio_without_login=new Dio();
    setOptions(_options);
  }
  static BaseOptions getDefOptions(){
    BaseOptions options = BaseOptions();
    options.connectTimeout=10*1000;
    options.receiveTimeout=20*1000;
    options.baseUrl="https://ytkeno.top:4443";
    options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    Map<String, dynamic> headers = Map<String,dynamic>();
    headers['Accept']='application/json';
    options.headers=headers;
    return options;
  }
   setOptions(BaseOptions options){
    _options=options;
    _dio.options=_options;
    _dio_without_login.options=_options;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (Options options) async {
        _dio.interceptors.requestLock.lock();
        options.headers["token"]= await getPrefString("token");;
        _dio.interceptors.requestLock.unlock();
        return options;
      }
    ));
//   String PEM ="MIIEpAIBAAKCAQEA2K9vFFFBp8xKbk4JOouVfPycCaQHo55jSWWhh2AB2bJFQgCi"+
//    "tMyaImHs5EUkl39Nqc7tiDMcmZ1bHM+OrOLkau3XZJfi5vKVWwrMNxITeFFT0rZr"+
//    "3Y/ShJpU2LWhtVt6MKrPn8MZvdcQtOnu2VmIC2nAxJfMfBwmj2LyJgxA0GbgyDZL"+
//    "fs6x0qzECH1xCdMRsMv+PzV0k/gCI8zmpBajA8nIoYRqWPEF4mHzzYju3IMcjyjF"+
//    "M66qPeofkBd4uNwe0ndeQ7K/agi10/s5J9d0uvgCUl2+KDoWn8VGjeh/i9dUXOvu"+
//    "leSK+Ap7xvceizvE0dkaHEMr5h3H61SVk8RM9wIDAQABAoIBADkUEWchNnHMmyiu"+
//    "TrkIzuKDKllRx59emBnb9y5RaHtffeXyg+mrYci/0eaZnhd4Nc2O0DxJ9nUyoa8X"+
//    "r6Y0CGZwa4Y4ilE6woQedoflL5LInZOKcSSGf7Zlbwc85TGAPNI4FIQpoQzEa8a0"+
//    "PrIrZu5Wt6wxrnBc+/1WW6IRJTuf+da0LAB7/xkb1phYkLh9ipKdrmfcatbKy5q+"+
//     "oCvuk/NghmAMwjK+ZdldiWOW4wywGTGzUmFg997UfhpLO8aAKIRnBy8ndE+ldS61"+
//     "of8Zqa4W56OAKAqKi9UJQbRMDikIQbL4yqQOGRTJI4fnc5LRxPWcUIpEftzpAKcD"+
//     "f1eLDzkCgYEA9LbvxNUxlga9X9sKygiPzKV4/j1cZWBX8JRYpaRUWo/DpiNnY0xe"+
//     "bbyxYWBSMsmYCSQZR+MtnghwZSiM8CKt6EGmESnc2VDV+uWW5zrDhV0ObAdVcozt"+
//     "s+tb3y9rjXIigGCINDOoe74h7/MhWV2nQeQ6GMmoY6xM8xPREcNiOHkCgYEA4q2W"+
//     "agDUkVZA2eyc+w4DBbFJTTLluGl3n8UHHSgVJilxJtYfEfxGL8jPZcwEza6kfd74"+
//     "kA4pWG7MhtcBbH9Bg0ZrgaMkcstTxY2/LJGFe9aFzK4E0yIT38z9TAf1CAf6w/eb"+
//     "e7vMTmoIVbdGUo2wZKgZTCfncEbO1B1wAnAhNO8CgYAKviEmdel4WZFkrNv7ZIbT"+
//     "iAwYtR7iQGl74TdHBkDBvP/swi8et9KJZLgwuybAngLzm8cUVc/B2UL93draC9uw"+
//     "j3k31auhSqAqJHwMaJL+vsgMTAIfRjqFJHbjBFTnX7ROCG7SQ9ZIoF8jBnxXTPoz"+
//     "tU4rmmavAXhbT2plKjucmQKBgQCGl21lGYMdnKo6+xwmkSZIPgD5Hox5192YdwOH"+
//     "U2JjW139IkwmgLUn8EL8/YuomNbAiiDqYA46nOdB9O26f0Dl8m0o9zZQFtxxw31M"+
//     "uEcaxcCCTJ0+w9ArJWsMtvjNwPcrXpzqdhKUSK8UPhM6NzkSOyFyL4tjBhgOqD/2"+
//     "op+E7wKBgQCY1AOitr9hkYvIZCq4WHDje7uQhQSjHqbKuWL1I+/0tm0b53O/09LY"+
//     "XtxAFFEBYZmsvbkeGq3rStw72a2ZzGHjFTXX9CKUDGNfeQ4tcZQbvLRdrzi2EGN2"+
//     "8BOe4F4fas+QQuTv5/2Eyv7maJOaFgPy5MSFnuhMoT/0qoWiMuGEQQ==";

   String PEM="MIIEogIBAAKCAQEAhe0PsuY6aH8r6/FF7UmnZ+yZvyvf383WtRwzK1ULZCHkhRAu"+
     "Fbh5N++9yZ3Y97eTgEIlwNE8Tzc0nD7yPhdCKQ9gEN/iN06VMjl6ReFy023t4Zsr"+
     "Czj98nA84cwiEFIwZirJM5fnvUCKqaZCpR83xa3wesxWrNY2vtbrQYQR8Q3iY12b"+
     "C6rBJx8rJWs/xy5CplmImxpFAw3DE3NRvWyGx8reoDe7tIfl+vV7wAmASqTWKm0x"+
     "v7NyRhJeIaJ+XJF+SwBEKUV2Bj5xJ+f1VwU/7pZMWgbU53F8NW6mN7C9qNzY4LDG"+
     "W7UajmdVZ4naAeQE0LSRr6RgvjHV/rht/AnwvQIDAQABAoIBAHgIwIBUz1bnXINt"+
     "TYJe+Hcx3Z81gMND50OOUeJtp/cIVZxZoyR+oc7bxpvVKSjlVYOoRdQq9MX/Md00"+
     "ocO67uaETFLzhvqRKTHJyGinp1YO+h2yCINXgmxv4nFyl7lPIOgBQzJF3UOHfICP"+
     "br42W7OGsbouOSVSHeEwGc0vxTDqN3ClmK9f1ji8r5eXLGRmEhhqURJEvNarutFe"+
     "AaOINiWFAJ71ophUBMp25T9W0XX6gltiERznUcq/9nW+91UsMRqxdes+p4OMG1hw"+
     "sKBfy7gc4EDJvEXPvC3dZX8aZrkvYp7QFE9iu1RGZek+GaKG+IOoJOOQnGscMenp"+
     "l/FyOLUCgYEAw1sqdVCb8Fss+Wrnj+zcUz5H7UpZiC9/45ETTykhQAOKFMHmv85j"+
     "YjXBB36385EdXZU8DHKDLkWoAv1MjjqMBjUvwwf/Kl1q/KjlysAfLeFMhKBgGIuK"+
     "kuIMVIFrntbLL+iATL1qTCs/1TswBsk5eXLZdwPT1cib1M62qbE97sMCgYEAr4AV"+
     "FkWl+rdfAWy7xyC3kVXtijp+/iRSylPj/Kmq6UP/WlzIhjwaMr1JjKN72Pb2oIbX"+
     "vPb/ZdNnhbFjlncj60dp1G0nX+3K9PiRqFM2ioPCuGqEtMlLWznvA/IBOmbG3CpG"+
     "nDL5YumbnxVnklL3Nd4rQkw5AHEeRR1s6BUBqn8CgYA+ArtIf+zv79En3vJgMjyB"+
     "w/xK61XeL821q8BoWVLvoe/7xMz9R4MukoeSXHwBuaeLpCpqfRL85il9wW/Cmf0G"+
     "n21oyCoMBZlHWEmRAUkkZCbI1quKPwketNhbHrXNtrrKm0/WjC2ovfXGNsJ49Pjk"+
     "fzteVv2wF7y3YWKEHPnexwKBgEGgeMIyW0Xs6kcDHRjygBKF+mTVSQXKGXd1dWzX"+
     "GYVPGx70UTv5H6bXp7hCrh5NA561rdkI2CqAqlaRJfdvJ+xkcQuxoaa6qkl+5iD2"+
     "tQ+JA/ioRGXCXD6J5HoqNhFbu4M6/9qLKTy2tK4BeBB8m9r18GFDVZF3u2UHAuGq"+
     "cUwLAoGADGKId9JXuuAyFHB3eP3zVHia8Vgc56+QGzYgP0Vy/RVdZ6Ft8EIYkjsS"+
     "YnCOj8SuPwHFAZxDP8q/Y3jl7JJSZicIcpi3S8A9z2vQBRsvQQ2V2alsaz+zfFPt"+
     "tb2Rox//0ifta0kebfE5EAALNcqBmcKw6ZxTGJbZsuvP7cOIkyY=";
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
      client.badCertificateCallback=(X509Certificate cert, String host, int port){
        if(cert.pem==PEM){ // Verify the certificate
          return true;
        }
        return false;
      };
    };
    (_dio_without_login.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
      client.badCertificateCallback=(X509Certificate cert, String host, int port){
        if(cert.pem==PEM){ // Verify the certificate
          return true;
        }
        return false;
      };
    };
  }
  Future<Map<String ,dynamic>> postWithJson(bool isLogin,String path,{queryParameters,data,Function errorCallback}){
    return request(isLogin,true,path,method: Method.post,queryParameters: queryParameters,data: data,errorCallback: errorCallback);
  }
  Future<Map<String ,dynamic>> post(bool isLogin,String path,{queryParameters,data,Function errorCallback}){
    return request(isLogin,false,path,method: Method.post,queryParameters: queryParameters,data: data,errorCallback: errorCallback);
  }
  Future<Map<String ,dynamic>> get(bool isLogin,String path,{queryParameters,data,Function errorCallback}){
    return request(isLogin,false,path,method: Method.get,queryParameters: queryParameters,data: data,errorCallback: errorCallback);
  }
  Future<Map<String,dynamic>> request(bool isLogin,bool isPostJson,String path,{String method,Map queryParameters,data,Function errorCallback }) async{
//    if(pathParams!=null){
//      pathParams.forEach((key,value){
//        if(path.indexOf(key)!=-1){
//          path = path.replaceAll(":$key", value.toString());
//        }
//      });
//    }
    print(path);
    Response response;
    if(isLogin){
      print(_dio_without_login.options.baseUrl);
      print("queryParameters:");
      print(queryParameters);
      print("data:");
      print(data);
      if(isPostJson){
           _dio.options.contentType = ContentType.parse('application/json');
           try {
             response = await _dio.request(
                 path, queryParameters: queryParameters,
                 data: data,
                 options: Options(method: method));
           }on DioError catch (e) {
             print('post error---------$e');
            // formatError(e);
             Map<String,dynamic> err = Map<String,dynamic>();
             err["code"]="-1";
             err["msg"]=formatError(e);
             return err;
           }
      }else{
           _dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
           try {
              response= await _dio.request(path,queryParameters:queryParameters,data:data,options:Options(method:method));
           }on DioError catch (e) {
             print('post error---------$e');
             // formatError(e);
             Map<String,dynamic> err = Map<String,dynamic>();
             err["code"]="-1";
             err["msg"]=formatError(e);
             return err;
           }
      }
    }else{
      print(_dio.options.baseUrl);
      print("queryParameters:");
      print(queryParameters);
      print("data:");
      print(data);
      try{
          response =await _dio_without_login.request(path,queryParameters:queryParameters,data:data,options:Options(method:method));
      }on DioError catch (e) {
        print('post error---------$e');
        // formatError(e);
        Map<String,dynamic> err = Map<String,dynamic>();
        err["code"]="-1";
        err["msg"]=formatError(e);
         return err;
      }
    }

    if(response.statusCode==HttpStatus.ok||response.statusCode==HttpStatus.created){
      try{
        if(response.data is Map){
          //print("1");
          return response.data;
        }else{
         // print("2");
          return json.decode(response.data.toString());
        }
      }catch(e){
        print(e.toString());
        return null;
      }
    }else{
      _handleHttpError(response.statusCode);
      if(errorCallback!=null){
        errorCallback(response.statusCode);
      }
      return null;
    }
  }
  void _handleHttpError(int errorCode){

  }
  String formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
      return "连接超时";
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
      return "请求超时";
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
      return "响应超时";
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
      return "出现异常";
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
      return "请求取消";
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
      return "未知错误";
    }
  }
}