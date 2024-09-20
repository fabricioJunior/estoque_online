import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:siv_codebar/data_access/local/dt_ultima_sync_datasource.dart';
import 'package:siv_codebar/data_access/local/produtos_local_datasource.dart';
import 'package:siv_codebar/data_access/remote/produtos_remote_client.dart';

import 'package:siv_codebar/presentation/blocs/produtos_bloc/produtos_bloc.dart';
import 'package:siv_codebar/data_access/remote/produtos_local_client.dart';
import 'package:siv_codebar/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:siv_codebar/repositories/produtos_repository.dart';
import 'package:siv_codebar/services/code_bar_service.dart';
import 'package:siv_codebar/services/print_service.dart';

var sl = GetIt.instance;

void injections() async {
  sl.registerLazySingleton<Client>(() => Client());

  sl.registerLazySingleton<CodeBarService>(() => CodeBarService());
  sl.registerLazySingleton<PrintService>(() => PrintService());

  sl.registerLazySingleton<ProdutosLocalClient>(() => ProdutosLocalClient(
        sl<Client>(),
        localServer(),
      ));
  sl.registerLazySingleton<ProdutosRepository>(
    () => ProdutosRepository(
      sl<ProdutosLocalClient>(),
      sl(),
      sl<ProdutosLocalDatasource>(),
      sl<DtUltimaSyncDatasource>(),
    ),
  );

  sl.registerFactory<ProdutosBloc>(
    () => ProdutosBloc(
      sl<ProdutosRepository>(),
    )..add(ProdutosSincronizou()),
  );

  sl.registerFactory<SyncBloc>(() => SyncBloc(sl()));

  sl.registerFactory<ProdutosLocalDatasource>(() => ProdutosLocalDatasource());
  sl.registerFactory<DtUltimaSyncDatasource>(() => DtUltimaSyncDatasource());
  sl.registerFactory<ProdutosRemoteClient>(
    () => ProdutosRemoteClient(
      sl(),
      remoteServer(),
    ),
  );
}

//String server() => '192.168.191.1';
String localServer() => 'localhost';
String remoteServer() => 'estoque.coralcloud.app';
