package bae.baesso.banco;

import java.util.ArrayList;
import java.util.List;

import javax.enterprise.context.ApplicationScoped;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import bae.baesso.dao.ConcursoDAO;
import bae.baesso.model.Concurso;
import bae.baesso.model.Ganhador;
import bae.baesso.model.Loteria;

@ApplicationScoped
public class ConcursoMongo implements ConcursoDAO {

	@Override
	public MongoCollection<Loteria> getCollection() {
		return MongoConnection.getDatabase().getCollection("loterias", Loteria.class);
	}

	@Override
	public void inserir(Concurso dado, Long codLoteria) {
		getCollection().updateOne(Filters.eq("codigo", codLoteria), Updates.push("concursos", dado));
	}

	@Override
	public void inserirGanhador(Ganhador ganhador, Concurso concurso, Long codLoteria) {
		getCollection().updateOne(Filters.eq("codigo", codLoteria),
				Updates.pull("concursos", Filters.eq("codigo", concurso.getCodigo())));
		if (concurso.getGanhadores() == null) {
			List<Ganhador> ganhadores = new ArrayList<>();
			concurso.setGanhadores(ganhadores);
		}
		concurso.getGanhadores().add(ganhador);
		getCollection().updateOne(Filters.eq("codigo", codLoteria), Updates.addToSet("concursos", concurso));
	}

	public Loteria findOne(Long codigo) {
		return getCollection().find(Filters.eq("concursos.codigo", codigo)).first();
	}

	@Override
	public Loteria procuraLoteria(Long codigoLoteria) {
		return getCollection().find(Filters.eq("codigo", codigoLoteria)).first();
	}

	public Object findOneByGanhador(Long codigo) {
		return getCollection().find(Filters.eq("concursos.ganhadores.codigo", codigo)).first();
	}

}
