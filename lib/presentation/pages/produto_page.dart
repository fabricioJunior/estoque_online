import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siv_codebar/domain/models.dart';
import 'package:siv_codebar/injections.dart';

import '../blocs/produto_bloc/produto_bloc.dart';

class ProdutoPage extends StatelessWidget {
  final Produto produto;

  const ProdutoPage({super.key, required this.produto});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${produto.referencia} - ${produto.descricao}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ProdutoBloc, ProdutoState>(
          bloc: sl<ProdutoBloc>()..add(ProdutoIniciou(produto: produto)),
          builder: (context, state) {
            if (state is ProdutoCarregarSucesso) {
              return DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                sortAscending: false,
                isHorizontalScrollBarVisible: true,
                fixedColumnsColor: Colors.grey[300],
                fixedCornerColor: Colors.grey[400],
                sortArrowIcon: Icons.abc,
                sortColumnIndex: 0,
                columns: _columns(state.tamanhos),
                rows: List<DataRow>.generate(
                  state.cores.length,
                  (index) {
                    var cor = state.cores[index];
                    return _dataRow(
                      cor,
                      state.tamanhos,
                      state.corTamanhoParaQuantidade,
                    );
                  },
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }

  void _sort<T>(
    Comparable<T> Function(Produto d) getField,
    int columnIndex,
    bool ascending,
  ) {}

  List<DataColumn2> _columns(List<String> tamanhos) {
    List<DataColumn2> columns = [];
    columns.add(
      DataColumn2(
        label: Text('CORES'),
        size: ColumnSize.L,
        onSort: (columnIndex, ascending) {},
      ),
    );
    columns.addAll(
      tamanhos.map(
        (tamanho) => DataColumn2(
          label: Text(tamanho),
          size: ColumnSize.L,
        ),
      ),
    );

    return columns;
  }

  DataRow _dataRow(
    String cor,
    List<String> tamanhos,
    Map<String, String> tamanhoQuantidadeParaCor,
  ) {
    List<DataCell> cells = [];
    cells.add(
      DataCell(Text(cor)),
    );
    var tamanhosCells = tamanhos.map(
      (tamanho) =>
          _dataCell(tamanhoQuantidadeParaCor['${cor}_$tamanho'] ?? '*'),
    );
    cells.addAll(tamanhosCells);

    return DataRow(cells: cells.toList());
  }

  DataCell _dataCell(String quantidade) {
    return DataCell(Text(quantidade));
  }
}
