package bae.baesso.dao;

import java.util.List;

public interface CrudDAO<T> {

	void inserir(T dado);

	void alterar(T dado);

	void excluir(T dado);

	List<T> listar();

	T findOne(Long codigo);

}
