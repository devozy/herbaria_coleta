import 'dart:async';

import 'package:flutter/material.dart';
import 'package:herbaria_coleta/db/coleta_database.dart';
import 'package:herbaria_coleta/models/coleta.dart';

import '../db/planta_database.dart';
import '../models/planta.dart';

int cur_plantaId;
int cur_coletaId;
String cur_plantaNumero;
String cur_plantaFamilia;
String cur_plantaGenero;
String cur_plantaEpiteto;
String cur_plantaAltura;
String cur_plantaFlor;
String cur_plantaFruto;
String cur_plantaSubstrato;
String cur_plantaAmbiente;
String cur_plantaRelevo;
String cur_plantaCoordenada;
String cur_plantaObservacao;


class AtributoPage extends StatefulWidget {
  AtributoPage(
      int plantaId
      , int coletaId
      , String numero
      , String familia
      , String genero
      , String epiteto
      , String altura
      , String flor
      , String fruto
      , String substrato
      , String ambiente
      , String relevo
      , String coordenada
      , String observacao)
  {
    cur_plantaId = plantaId;
    cur_coletaId = coletaId;
    cur_plantaNumero = numero;
    cur_plantaFamilia = familia;
    cur_plantaGenero = genero;
    cur_plantaEpiteto = epiteto;
    cur_plantaAltura = altura;
    cur_plantaFlor = flor;
    cur_plantaFruto = fruto;
    cur_plantaSubstrato = substrato;
    cur_plantaAmbiente = ambiente;
    cur_plantaRelevo = relevo;
    cur_plantaCoordenada = coordenada;
    cur_plantaObservacao = observacao;

  }

  @override
  State<StatefulWidget> createState() {
    return _AtributoPageState();
  }
}

class _AtributoPageState extends State<AtributoPage> {
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
  var dbHelper;
  bool isUpdating;
  PlantaDatabase db;

  @override
  void initState() {
    super.initState();
    db = PlantaDatabase.instance;
    isUpdating = true;
    refreshList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {updateFields();
    });
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
   //   formKey.currentState.save();
      if (isUpdating) {
        Planta planta = Planta(
            id: cur_plantaId,
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
        db.update(planta);
        setState(() {
          //isUpdating = false;
        });
      } else {
        Planta planta = Planta(
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

   //     db.save(planta);
      }
      clearAll();
      refreshList();
    }
  }

  updateFields() {
    controllerNumeroColeta.text = cur_plantaNumero;
    controllerFamilia.text = cur_plantaFamilia;
    controllerGenero.text = cur_plantaGenero;
    controllerEpiteto.text = cur_plantaEpiteto;
    controllerAltura.text = cur_plantaAltura;
    controllerFlor.text = cur_plantaFlor;
    controllerFruto.text = cur_plantaFruto;
    controllerSubstrato.text = cur_plantaSubstrato;
    controllerAmbiente.text = cur_plantaAmbiente;
    controllerRelevo.text = cur_plantaRelevo;
    controllerCoordenada.text = cur_plantaCoordenada;
    controllerObservacao.text = cur_plantaObservacao;
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
                          labelText: 'Nº de Coleta',
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
                          labelText: 'Epíteto',
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
                          labelText: 'Observação',
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
                          child: Text('ATUALIZAR'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isUpdating = true;
                            });
                            db.deleteById(cur_plantaId);
                            clearAll();
                            FocusScope.of(context).unfocus();
                          },
                          child: Text('Excluir'),
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
        title: Text(cur_plantaNumero + '. ' + cur_plantaGenero + ' ' + cur_plantaEpiteto),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
  //          list(),

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
