import 'package:flutter/material.dart';
import '../sqlite/coleta_db.dart';
import 'dart:async';
import '../sqlite/db_helperColeta.dart';

class PlantaPage extends StatefulWidget {
  final String title;

  PlantaPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlantaPageState();
  }
}

class _PlantaPageState extends State<PlantaPage> {
  //
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
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelperColeta();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      coletas = dbHelper.getColeta();
    });
  }

  clearAll() {
    controllerProjeto.text = '';
    controllerColetor.text = '';
    controllerEstado.text = '';
    controllerMunicipio.text = '';
    controllerData.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        ColetaDB e = ColetaDB(curColetaId, projeto, coletor, estado, municipio, data);
        dbHelper.update(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        ColetaDB e = ColetaDB(curColetaId,projeto, coletor, estado, municipio, data);
        dbHelper.save(e);
      }
      clearAll();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Projeto',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerProjeto,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => projeto = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Coletor',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerColetor,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => coletor = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Estado',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerEstado,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => estado = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Município',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerMunicipio,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => municipio = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Data',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerData,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => data = val,
            ),
            const Espaco(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed:validate,
                  child: Text(isUpdating ? 'ATUALIZAR' : 'ADICIONAR'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    FocusScope.of(context).unfocus();
                    clearAll();
                  },

                  child: Text('CANCELAR'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<ColetaDB> coletas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          columnSpacing: 14.0,
          headingTextStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600),
        columns: [
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
                  isUpdating = true;
                  curColetaId = coleta.id;
                });
                controllerProjeto.text = coleta.projeto;
              },
            ),
                DataCell(
                  Text('${coleta.coletor}'),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerColetor.text = coleta.coletor;
                  },
                ),
                DataCell(
                  Text(coleta.estado),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerEstado.text = coleta.estado;
                  },
                ),
                DataCell(
                  Text(coleta.municipio),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerMunicipio.text = coleta.municipio;
                  },
                ),
                DataCell(
                  Text(coleta.data),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curColetaId = coleta.id;
                    });
                    controllerData.text = coleta.data;
                  },
                ),
                DataCell(IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                dbHelper.delete(coleta.id);
                refreshList();
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
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Lista de Coletas"),
        centerTitle: true,
      ),

      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            list(),

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