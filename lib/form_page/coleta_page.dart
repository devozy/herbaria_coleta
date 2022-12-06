import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herbaria_coleta/db/coleta_database.dart';
import 'package:herbaria_coleta/models/coleta.dart';

int cur_coletaId;

class ColetaPage extends StatefulWidget {
  ColetaPage(int curColetaId){
    cur_coletaId = curColetaId;
  }

  @override
  State<StatefulWidget> createState() {
    return _ColetaPageState();
  }
}

class _ColetaPageState extends State<ColetaPage> {
  Future<List<Coleta>> coletas;
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
  ColetaDatabase db;

  @override
  void initState() {
    super.initState();
    db = ColetaDatabase.instance;
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      coletas = db.findAll();
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
        Coleta coleta = Coleta(
            id: curColetaId,
            projeto: projeto,
            coletor: coletor,
            estado: estado,
            municipio: municipio,
            data: DateTime.now().toIso8601String());
        db.update(coleta);
        setState(() {
          isUpdating = false;
        });
      } else {
        Coleta coleta = Coleta(
            projeto: projeto,
            coletor: coletor,
            estado: estado,
            municipio: municipio,
            data: DateTime.now().toIso8601String());

        db.save(coleta);
      }
      clearAll();
      refreshList();
    }
  }

  updateFields(coleta) {
    controllerProjeto.text = coleta.projeto;
    controllerColetor.text = coleta.coletor;
    controllerEstado.text = coleta.estado;
    controllerMunicipio.text = coleta.municipio;
    controllerData.text = coleta.data;
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
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
                  onPressed: validate,
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

  SingleChildScrollView dataTable(List<Coleta> coletas) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: AlignmentDirectional.centerStart,
          width: 600,
          child: DataTable(
            columnSpacing: 6.0,
            headingTextStyle: const TextStyle(
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
            columns: [
              DataColumn(
                label: Text(
                  'PROJETO',
                ),
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
                  (coleta) =>
                  DataRow(cells: [
                    DataCell(Text('${coleta.projeto}'), onTap: () {
                      setState(() {
                        isUpdating = true;
                        curColetaId = coleta.id;
                      });
                      updateFields(coleta);
                    }),
                    DataCell(
                      Text('${coleta.coletor}'),
                      onTap: () {
                        setState(() {
                          isUpdating = true;
                          curColetaId = coleta.id;
                        });
                        updateFields(coleta);
                      },
                    ),
                    DataCell(
                      Text(coleta.estado),
                      onTap: () {
                        setState(() {
                          isUpdating = true;
                          curColetaId = coleta.id;
                        });
                        updateFields(coleta);
                      },
                    ),
                    DataCell(
                      Text(coleta.municipio),
                      onTap: () {
                        setState(() {
                          isUpdating = true;
                          curColetaId = coleta.id;
                        });
                        updateFields(coleta);
                      },
                    ),
                    DataCell(
                      Text('${coleta.data.substring(0, 9).replaceAll('-', '/').trim()}'),
                      onTap: () {
                        setState(() {
                          isUpdating = true;
                          curColetaId = coleta.id;
                        });
                        updateFields(coleta);
                      },
                    ),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        db.deleteById(coleta.id);
                        refreshList();
                      },
                    )),
                  ]),
            )
                .toList(),
          ),
        ));
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
