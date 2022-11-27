import 'package:flutter/material.dart';
import 'package:herbaria_coleta/form_page/planta_page.dart';
import '../sqlite/coleta_db.dart';
import 'dart:async';
import '../form_page/coleta_page.dart';
import '../configs/db_helperColeta.dart';
import '../sqlite/planta_db.dart';

class ListaAtributos extends StatefulWidget {
  final String title;
  ListaAtributos({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListaAtributosState();
  }
}
class _ListaAtributosState extends State<ListaAtributos> {
  Future<List<ColetaDB>> plantas;
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
  int numeroColeta;
  String familia;
  String genero;
  String epiteto;
  String altura;
  String flor;
  String fruto;
  String substrato;
  String ambiente;
  int relevo;
  String coordenada;
  String observacao;

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
      plantas = dbHelper.getPlanta();
    });
  }

  SingleChildScrollView dataTable(List<PlantaDB> plantas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columnSpacing: 14.0,
        headingTextStyle: const TextStyle(
            fontSize: 15.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600),
        columns: const [
          DataColumn(
            label: Text('Nº Coleta', ),
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
            label: Text('Obervação'),
          ),
          DataColumn(

            label: Text(''),
          )
        ],
        rows: plantas
            .map(
              (planta) => DataRow(cells: [
            DataCell(
              Text('${planta.numeroColeta}'),
              onTap: () {
                setState(() {
                  // isUpdating = true;
                  curPlantaId = planta.id;
                });
                controllerNumeroColeta.text = planta.numeroColeta as String;
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
            DataCell(
              Text(planta.observacao),
              onTap: () {
                setState(() {
                  //                    isUpdating = true;
                  curPlantaId = planta.id;
                });
                controllerObservacao.text = planta.observacao;
              },
            ),
            DataCell(IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PlantaPage(curPlantaId)));
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
                 //   Navigator.push(
                  //      context,
                     //   MaterialPageRoute(
                            //builder: (BuildContext context) =>
                               // ColetaPage(2)));
                  },
                  child: Text(
                    //  isUpdating ? 'Nova Coleta' :
                      'Editar Lista de Coletas'),
                ),
                //         ElevatedButton(
                // onPressed: () {
                //       setState(() {
                //               // isUpdating = false;
                //             });
                //           },
                //           child: Text('Excluir Coleta'),
                //         ),
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