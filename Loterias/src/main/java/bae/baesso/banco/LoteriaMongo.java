package bae.baesso.banco;

import java.util.Arrays;
import java.util.List;

import javax.enterprise.context.ApplicationScoped;

import com.google.common.collect.Iterables;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import bae.baesso.dao.LoteriaDAO;
import bae.baesso.model.Loteria;

@ApplicationScoped
public class LoteriaMongo implements LoteriaDAO {

	@Override
	public MongoCollection<Loteria> getCollection() {
		return MongoConnection.getDatabase().getCollection("loterias", Loteria.class);
	}

	@Override
	public void inserir(Loteria dado) {
		getCollection().insertOne(dado);
	}

	@Override
	public void alterar(Loteria dado) {
		getCollection().updateOne(Filters.eq("codigo", dado.getCodigo()),
				Updates.combine(Updates.set("nome", dado.getNome()), Updates.set("concursos", dado.getConcursos())));
	}

	@Override
	public void excluir(Loteria dado) {
		getCollection().deleteOne(Filters.eq("codigo", dado.getCodigo()));
	}

	@Override
	public Loteria findOne(Long codigo) {
		return getCollection().find(Filters.eq("codigo", codigo)).first();
	}

	@Override
	public List<Loteria> listar() {
		return Arrays.asList(Iterables.toArray(getCollection().find(), Loteria.class));
	}

}
