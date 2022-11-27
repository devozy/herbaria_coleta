class ConstantsHelpers {
  static const String DATA_BASE_NAME = 'database.db';
  static const String TAB_PLANTA = 'TAB_PLANTA';
  static const String ID = 'id';
  static const String NUMERO_COLETA = 'numeroColeta';
  static const String FAMILIA = 'familia';
  static const String GENERO = 'genero';
  static const String EPITETO = 'epiteto';
  static const String ALTURA = 'altura';
  static const String FLOR = 'flor';
  static const String FRUTO = 'fruto';
  static const String SUBSTRATO = 'substrato';
  static const String AMBIENTE = 'ambiente';
  static const String COORDENADA = 'coordenada';
  static const String RELEVO = 'relevo';
  static const String OBSERVACAO = 'obervacao';
  static const String ID_COLETA = 'id_coleta';
  static const String TAB_COLETA = 'TAB_COLETA';
  static const String PROJETO = 'projeto';
  static const String COLETOR = 'coletor';
  static const String ESTADO = 'estado';
  static const String MUNICIPIO = 'municipio';
  static const String DATA = 'data';

  static List<String> getTablesPlanta(){
    return List.of([ID, NUMERO_COLETA, FAMILIA, GENERO, EPITETO, ALTURA, FLOR, FRUTO, SUBSTRATO, AMBIENTE, COORDENADA, RELEVO, OBSERVACAO, ID_COLETA]);
  }
}
