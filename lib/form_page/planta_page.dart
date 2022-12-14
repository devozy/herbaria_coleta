import 'package:flutter/material.dart';
import 'package:herbaria_coleta/db/planta_database.dart';
import 'dart:async';

import 'package:herbaria_coleta/models/planta.dart';

int cur_coletaId;

class PlantaPage extends StatefulWidget {
  PlantaPage(int coleta) {
    cur_coletaId = coleta;
  }

  @override
  State<StatefulWidget> createState() {
    return _PlantaPageState();
  }
}

class _PlantaPageState extends State<PlantaPage> {
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
  int idColeta;

  final formKey = new GlobalKey<FormState>();
  PlantaDatabase db;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    db = PlantaDatabase.instance;
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      plantas = db.findAll();
    });
  }

  clearAll() {
    controllerNumeroColeta.text = '';
    controllerFamilia.text = '';
    controllerGenero.text = '';
    controllerEpiteto.text = '';
    controllerAltura.text = '';
    controllerFlor.text = '';
    controllerFruto.text = '';
    controllerSubstrato.text = '';
    controllerAmbiente.text = '';
    controllerRelevo.text = '';
    controllerCoordenada.text = '';
    controllerObservacao.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      if (isUpdating) {
        Planta planta = Planta(
            id: curPlantaId,
            numeroColeta: controllerNumeroColeta.text,
            familia: controllerFamilia.text,
            genero: controllerGenero.text,
            epiteto: controllerEpiteto.text,
            altura: controllerAltura.text,
            flor: controllerFlor.text,
            fruto: controllerFruto.text,
            substrato: controllerSubstrato.text,
            ambiente: controllerAmbiente.text,
            relevo: controllerRelevo.text,
            coordenada: controllerCoordenada.text,
            observacao: controllerObservacao.text,
            coletaId: cur_coletaId
        );
        db.update(planta);
        setState(() {
          isUpdating = false;
        });
      }
      else {
        Planta planta = Planta(
           // id: null,
            numeroColeta: controllerNumeroColeta.text,
            familia: controllerFamilia.text,
            genero: controllerGenero.text,
            epiteto: controllerEpiteto.text,
            altura: controllerAltura.text,
            flor: controllerFlor.text,
            fruto: controllerFruto.text,
            substrato: controllerSubstrato.text,
            ambiente: controllerAmbiente.text,
            relevo: controllerRelevo.text,
            coordenada: controllerCoordenada.text,
            observacao: controllerObservacao.text,
            coletaId: cur_coletaId);
        db.save(planta);
      }
      clearAll();
    }
  }

  form() {
    return Flexible(
        child: SingleChildScrollView(
            child: Form(
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
                  labelText: 'N?? de Coleta',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerNumeroColeta,
              keyboardType: TextInputType.number,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => numeroColeta = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Familia',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerFamilia,
              keyboardType: TextInputType.text,
              onSaved: (val) => familia = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Genero',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerGenero,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => genero = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Ep??teto',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerEpiteto,
              keyboardType: TextInputType.text,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => epiteto = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Altura',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerAltura,
              keyboardType: TextInputType.number,
//              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => altura = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Flor',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerFlor,
              keyboardType: TextInputType.text,
              onSaved: (val) => flor = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Fruto',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerFruto,
              keyboardType: TextInputType.text,
              onSaved: (val) => fruto = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Substrato',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerSubstrato,
              keyboardType: TextInputType.text,
              onSaved: (val) => substrato = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Ambiente',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerAmbiente,
              keyboardType: TextInputType.text,
              onSaved: (val) => ambiente = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Relevo',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerRelevo,
              keyboardType: TextInputType.number,
              onSaved: (val) => relevo = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Coordenada',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerCoordenada,
              keyboardType: TextInputType.text,
              onSaved: (val) => coordenada = val,
            ),
            const Espaco(),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Observa????o',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 59, 93, 77), width: 3.0),
                  ),
                  border: OutlineInputBorder()),
              controller: controllerObservacao,
              keyboardType: TextInputType.text,
              onSaved: (val) => observacao = val,
            ),
            const Espaco(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: validate,
                  child: Text('ADICIONAR'),
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
    )));
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
        title: Text("Novo Esp??cime"),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
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
