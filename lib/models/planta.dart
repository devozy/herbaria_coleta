import 'dart:ffi';

class Planta {
  int _id;
  String _numeroColeta;
  String _familia;
  String _genero;
  String _epiteto;
  String _altura;
  String _flor;
  String _fruto;
  String _substrato;
  String _ambiente;
  String _coordenada;
  String _relevo;
  String _obervacao;
  String _id_coleta;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get numeroColeta => _numeroColeta;

  String get id_coleta => _id_coleta;

  set id_coleta(String value) {
    _id_coleta = value;
  }

  String get obervacao => _obervacao;

  set obervacao(String value) {
    _obervacao = value;
  }

  String get relevo => _relevo;

  set relevo(String value) {
    _relevo = value;
  }

  String get coordenada => _coordenada;

  set coordenada(String value) {
    _coordenada = value;
  }

  String get ambiente => _ambiente;

  set ambiente(String value) {
    _ambiente = value;
  }

  String get substrato => _substrato;

  set substrato(String value) {
    _substrato = value;
  }

  String get fruto => _fruto;

  set fruto(String value) {
    _fruto = value;
  }

  String get flor => _flor;

  set flor(String value) {
    _flor = value;
  }

  String get altura => _altura;

  set altura(String value) {
    _altura = value;
  }

  String get epiteto => _epiteto;

  set epiteto(String value) {
    _epiteto = value;
  }

  String get genero => _genero;

  set genero(String value) {
    _genero = value;
  }

  String get familia => _familia;

  set familia(String value) {
    _familia = value;
  }

  set numeroColeta(String value) {
    _numeroColeta = value;
  }
}
