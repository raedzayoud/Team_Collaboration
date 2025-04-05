import 'package:collab_doc/core/class/statusrequest.dart';

HandleData(respone){

  if(respone is StatusRequest){
    return respone;
  }

  else{
    return StatusRequest.success;
  }

}