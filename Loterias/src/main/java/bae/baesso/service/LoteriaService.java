package bae.baesso.service;

import java.util.List;
import java.util.Random;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import bae.baesso.banco.LoteriaMongo;
import bae.baesso.model.Loteria;

@ApplicationScoped
public class LoteriaService {

	@Inject
	private LoteriaMongo repository;

	public List<Loteria> listar() {
		return repository.listar();
	}

	public Loteria salvar(Loteria loteria) {
		Loteria loteriaSalva;
		if (loteria.getCodigo() == null) {
			loteria.setCodigo(this.geraCodigo());
			repository.inserir(loteria);
			loteriaSalva = loteria;
		} else {
			repository.alterar(loteria);
			loteriaSalva = loteria;
		}

		return loteriaSalva;
	}

	public void excluir(Loteria loteria) {
		repository.excluir(loteria);
	}

	public LoteriaMongo getRepository() {
		return this.repository;
	}

	private Long geraCodigo() {
		Random rd = new Random();
		Long cod = Long.valueOf((rd.nextInt((333 - 0) + 1) + 0) * 6);

		if (repository.findOne(cod) != null) {
			Long.valueOf((rd.nextInt((333 - 0) + 1) + 0) * 6);
		}

		return cod;
	}

}
