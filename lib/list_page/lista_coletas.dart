import 'package:flutter/material.dart';
import 'package:herbaria_coleta/form_page/planta_page.dart';
import '../sqlite/coleta_db.dart';
import 'dart:async';
import '../form_page/coleta_page.dart';
import '../sqlite/db_helperColeta.dart';
import '../sqlite/planta_db.dart';
import 'lista_plantas.dart';

class ListaColetas extends StatefulWidget {
  final String title;
  ListaColetas({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListaColetasState();
  }
}
class _ListaColetasState extends State<ListaColetas> {
  Future<List<ColetaDB>> coletas;
  TextEditingController controllerProjeto = TextEditingController();
  TextEditingController controllerColetor = TextEditingController();
  TextEditingController controllerEstado = TextEditingController();
  TextEditingController controllerMunicipio = TextEditingController();
  TextEditingController controllerData = TextEditingController();

  int curColetaId;
  String projeto;
  String coletor;
  String estado;
  String municipio;
  String data;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  // bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelperColeta();
    // isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      coletas = dbHelper.getColeta();
    });
  }

  SingleChildScrollView dataTable(List<ColetaDB> coletas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columnSpacing: 5.0,
          headingTextStyle: const TextStyle(
            fontSize: 15.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600),
        columns: const [
          DataColumn(
            label: Text('PROJETO', ),
          ),
          DataColumn(
            label: Text('COLETOR'),
          ),
          DataColumn(
            label: Text('UF'),
          ),
          DataColumn(
            label: Text('CIDADE'),
          ),
          DataColumn(
            label: Text('DATA'),
          ),
          DataColumn(

            label: Text(''),
          )
        ],
        rows: coletas
            .map(
              (coleta) => DataRow(cells: [
            DataCell(
              Text('${coleta.projeto}'),
              onTap: () {
                setState(() {
                  // isUpdating = true;
                  curColetaId = coleta.id;
                });
                controllerProjeto.text = coleta.projeto;
              },
            ),
                DataCell(
                  Text(coleta.coletor),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerColetor.text = coleta.coletor;
                  },
                ),
                DataCell(
                  Text(coleta.estado),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerEstado.text = coleta.estado;
                  },
                ),
                DataCell(
                  Text(coleta.municipio),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerMunicipio.text = coleta.municipio;
                  },
                ),
                DataCell(
                  Text('${coleta.data}'),
                  onTap: () {
                    setState(() {
  //                    isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerData.text = coleta.data;
                  },
                ),
                DataCell(IconButton(
              icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ListaPlantas(coleta.id, coleta.projeto, coleta.data)),
                    );

                  },
            )),
          ]),
        )
            .toList(),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: coletas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Coletas Registradas'),
        centerTitle: true,
      ),
      body:  Container(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            list(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ColetaPage('deu certo')));
                  },
                  child: Text(
                      'Editar Lista de Coletas'),
                ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              refreshList();
            });
          },
          child: Text('Atualizar'),
        )
    ],
            ),
          ],
        ),
      ),
    );
  }
}


class Espaco extends StatelessWidget {
  const Espaco({Key key}) : super(key: key);

  @override
  Widget build(BuildContext contex) {
    return const SizedBox(
      height: 5,
    );
  }
}