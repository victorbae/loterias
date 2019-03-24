package bae.baesso.dao;

import com.mongodb.client.MongoCollection;

import bae.baesso.model.Loteria;

public interface LoteriaDAO extends CrudDAO<Loteria> {

	MongoCollection<Loteria> getCollection();
}
