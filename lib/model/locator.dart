

import 'package:get_it/get_it.dart';

import 'package:canary_admin/services/api.dart';
import 'package:canary_admin/model/CRUDModel.dart';

GetIt locator =  GetIt.instance;



void setupLocator() {

  locator.registerLazySingleton(() => Api('products'));
  locator.registerLazySingleton(() => CRUDModel()) ;

}