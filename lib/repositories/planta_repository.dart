import 'package:herbaria_coleta/helpers/constants_helpers.dart';

import '../configs/dao.dart';
import '../models/planta.dart';

class PlantaRepository {
  Dao dao;

  PlantaRepository() {
    dao = Dao();
  }

  Planta save(final Planta planta) {
    var result = dao.insert(ConstantsHelpers.TAB_PLANTA, toMap(planta));
    result.then((value) => planta.id);
    return planta;
  }

  Planta findById(final int id) {
    Planta planta = Planta();
    dao
        .search(ConstantsHelpers.TAB_PLANTA, ConstantsHelpers.getTablesPlanta(),
            'ID = $id')
        .then((value) => {planta = toPlanta(value.first)});
    return planta;
  }

  Map<String, dynamic> toMap(final Planta planta) {
    var map = <String, dynamic>{
      ConstantsHelpers.ID: null,
      ConstantsHelpers.NUMERO_COLETA: planta.numeroColeta,
      ConstantsHelpers.FAMILIA: planta.familia,
      ConstantsHelpers.GENERO: planta.genero,
      ConstantsHelpers.EPITETO: planta.epiteto,
      ConstantsHelpers.ALTURA: planta.altura,
      ConstantsHelpers.FLOR: planta.flor,
      ConstantsHelpers.FRUTO: planta.fruto,
      ConstantsHelpers.SUBSTRATO: planta.substrato,
      ConstantsHelpers.AMBIENTE: planta.ambiente,
      ConstantsHelpers.COORDENADA: planta.coordenada,
      ConstantsHelpers.RELEVO: planta.relevo,
      ConstantsHelpers.ID_COLETA : planta.id_coleta
    };
    return map;
  }

  Planta toPlanta(Map<String, dynamic> map) {
    var planta = Planta();
    planta.id = map[ConstantsHelpers.ID];
    planta.numeroColeta = map[ConstantsHelpers.NUMERO_COLETA];
    planta.familia = map[ConstantsHelpers.FAMILIA];
    planta.genero = map[ConstantsHelpers.GENERO];
    planta.epiteto = map[ConstantsHelpers.EPITETO];
    planta.altura = map[ConstantsHelpers.ALTURA];
    planta.flor = map[ConstantsHelpers.FLOR];
    planta.fruto = map[ConstantsHelpers.FRUTO];
    planta.substrato = map[ConstantsHelpers.SUBSTRATO];
    planta.ambiente = map[ConstantsHelpers.AMBIENTE];
    planta.coordenada = map[ConstantsHelpers.COORDENADA];
    planta.relevo = map[ConstantsHelpers.RELEVO];
    return planta;
  }
}
