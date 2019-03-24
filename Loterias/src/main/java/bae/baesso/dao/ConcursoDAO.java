package bae.baesso.dao;

import com.mongodb.client.MongoCollection;

import bae.baesso.model.Concurso;
import bae.baesso.model.Ganhador;
import bae.baesso.model.Loteria;

public interface ConcursoDAO {

	MongoCollection<Loteria> getCollection();

	void inserirGanhador(Ganhador dado, Concurso concurso, Long codLoteria);

	void inserir(Concurso dado, Long codLoteria);

	Loteria procuraLoteria(Long codigoLoteria);
}
