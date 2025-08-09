import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:siv_codebar/data_access/local/dt_ultima_sync_datasource.dart';
import 'package:siv_codebar/data_access/local/produtos_local_datasource.dart';
import 'package:siv_codebar/data_access/remote/pedidos_local_client.dart';
import 'package:siv_codebar/data_access/remote/produto_pedidos_remote_client.dart';
import 'package:siv_codebar/data_access/remote/produtos_remote_client.dart';
import 'package:siv_codebar/presentation/blocs/pagamentos_bloc/pagamentos_bloc.dart';
import 'package:siv_codebar/presentation/blocs/produto_bloc/produto_bloc.dart';

import 'package:siv_codebar/presentation/blocs/produtos_bloc/produtos_bloc.dart';
import 'package:siv_codebar/data_access/remote/produtos_local_client.dart';
import 'package:siv_codebar/presentation/blocs/pedidos_bloc/pedidos_bloc.dart';
import 'package:siv_codebar/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:siv_codebar/repositories/produtos_pedidos_repository.dart';
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

  sl.registerFactory<PedidosRepository>(
    () => PedidosRepository(localClient: sl(), remoteClient: sl()),
  );

  sl.registerFactory(() => PedidosBloc(sl()));

  sl.registerFactory<ProdutosBloc>(
    () => ProdutosBloc(
      sl<ProdutosRepository>(),
    )..add(ProdutosSincronizou()),
  );

  sl.registerFactory<ProdutoBloc>(() => ProdutoBloc(sl()));

  sl.registerFactory<SyncBloc>(() => SyncBloc(sl()));

  sl.registerFactory<ProdutosLocalDatasource>(() => ProdutosLocalDatasource());
  sl.registerFactory<DtUltimaSyncDatasource>(() => DtUltimaSyncDatasource());
  sl.registerFactory<ProdutosRemoteClient>(
    () => ProdutosRemoteClient(
      sl(),
      remoteServer(),
    ),
  );
  sl.registerFactory<PedidosRemoteClient>(
    () => PedidosRemoteClient(
      client: sl(),
      remoteServer: remoteServer(),
    ),
  );
  sl.registerFactory<ProdutoPedidosLocalClient>(
    () => ProdutoPedidosLocalClient(
      client: sl(),
      localServer: localServer(),
    ),
  );

  sl.registerFactory<PagamentosBloc>(() => PagamentosBloc(sl()));
}

//String server() => '192.168.191.1';
String localServer() => '192.168.191.1';
//String localServer() => 'localhost';
//String remoteServer() => 'localhost:5080';
String remoteServer() => 'estoque.coralcloud.app';
