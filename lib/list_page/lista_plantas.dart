import 'dart:core';

import 'package:flutter/material.dart';
import 'package:herbaria_coleta/db/planta_database.dart';
import 'package:herbaria_coleta/form_page/planta_page.dart';
import 'package:herbaria_coleta/list_page/lista_atributos.dart';
import 'package:herbaria_coleta/models/planta.dart';

import '../form_page/atributo_page.dart';

int cur_coletaId;
String cur_coletaProjeto;
String cur_coletaData;

class ListaPlantas extends StatefulWidget {
  ListaPlantas(
    int coleta,
    String projeto,
    String data,
  ) {
    cur_coletaId = coleta;
    cur_coletaProjeto = projeto;
    cur_coletaData = data.substring(0,10);
  }

  @override
  State<StatefulWidget> createState() {
    return _ListaPlantasState();
  }
}

class _ListaPlantasState extends State<ListaPlantas> {
  Future<List<Planta>> plantas;
  TextEditingController controllerNumeroColeta = TextEditingController();
  TextEditingController controllerFamilia = TextEditingController();
  TextEditingController controllerGenero = TextEditingController();
  TextEditingController controllerEpiteto = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  TextEditingController controllerFlor = TextEditingController();
  TextEditingController controllerFruto = TextEditingController();
  TextEditingController controllerSubstrato = TextEditingController();
  TextEditingController controllerAmbiente = TextEditingController();
  TextEditingController controllerRelevo = TextEditingController();
  TextEditingController controllerCoordenada = TextEditingController();
  TextEditingController controllerObservacao = TextEditingController();

  int curPlantaId;
  String numeroColeta;
  String familia;
  String genero;
  String epiteto;
  String altura;
  String flor;
  String fruto;
  String substrato;
  String ambiente;
  String relevo;
  String coordenada;
  String observacao;
  int curColetaId;

  final formKey = new GlobalKey<FormState>();
  PlantaDatabase dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = PlantaDatabase.instance;
    refreshList();
  }

  refreshList() {
    setState(() {
      plantas = dbHelper.findByColeta(cur_coletaId);
    });
  }

  SingleChildScrollView dataTable(List<Planta> plantas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 14.0,
        headingTextStyle: const TextStyle(
            fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.w600),
        columns: const [
          DataColumn(
            label: Text(
              'Nº',
            ),
          ),
          DataColumn(
            label: Text('Gênero'),
          ),
          DataColumn(
            label: Text('Epíteto'),
          ),
          DataColumn(
            label: Text('Família'),
          ),
          DataColumn(
            label: Text(''),
          )
        ],
        rows: plantas
            .map(
              (planta) => DataRow(cells: [
                DataCell(
                  Text(planta.numeroColeta),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curPlantaId = planta.id;
                    });
                    controllerNumeroColeta.text = planta.numeroColeta;
                  },
                ),
                DataCell(
                  Text(planta.genero),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curPlantaId = planta.id;
                    });
                    controllerGenero.text = planta.genero;
                  },
                ),
                DataCell(
                  Text(planta.epiteto),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curPlantaId = planta.id;
                    });
                    controllerEpiteto.text = planta.epiteto;
                  },
                ),
                DataCell(
                  Text(planta.familia),
                  onTap: () {
                    setState(() {
                      // isUpdating = true;
                      curPlantaId = planta.id;
                    });
                    controllerFamilia.text = planta.familia;
                  },
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AtributoPage(planta.id, planta.coletaId, planta.numeroColeta, planta.familia, planta.genero, planta.epiteto, planta.altura, planta.flor, planta.fruto, planta.substrato, planta.ambiente, planta.relevo, planta.coordenada, planta.observacao)));
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
        future: plantas,
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Coleta ' + cur_coletaProjeto + ' - ' + cur_coletaData),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
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
                                PlantaPage(cur_coletaId)));
                  },
                  child: Text(
                      //  isUpdating ? 'Nova Coleta' :
                      'Editar Lista de Plantas'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      refreshList();
                    });
                  },
                  child: Text('Atualizar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      refreshList();
                    });
                  },
                  child: Text('Exportar'),
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
