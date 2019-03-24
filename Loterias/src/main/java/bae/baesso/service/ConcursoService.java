package bae.baesso.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import bae.baesso.banco.ConcursoMongo;
import bae.baesso.banco.LoteriaMongo;
import bae.baesso.model.Concurso;
import bae.baesso.model.Ganhador;
import bae.baesso.model.Loteria;
import bae.baesso.model.NumerosApostados;

@ApplicationScoped
public class ConcursoService {

	@Inject
	private ConcursoMongo repository;

	@Inject
	private LoteriaMongo loteriaRepository;

	public void salvar(Concurso concurso, Long codLoteria) {
		if (concurso.getCodigo() == null) {
			concurso.setCodigo(this.geraCodigo());
			repository.inserir(concurso, codLoteria);
		}
	}

	public void novoGanhador(Ganhador ganhador, Concurso concurso, Long codLoteria) {
		if (ganhador.getCodigo() == null) {
			ganhador.setCodigo(this.geraCodigoGanhador());
		}
		repository.inserirGanhador(ganhador, concurso, codLoteria);
	}

	public List<Concurso> verificarApostas(Ganhador ganhador, NumerosApostados numerosApostados, Long codigoLoteria) {
		List<Concurso> concursos = new ArrayList<>();
		Loteria loteria = repository.procuraLoteria(codigoLoteria);

		for (Concurso concurso : loteria.getConcursos()) {
			if (concurso.getNumerosSorteados().containsAll(numerosApostados.getNumerosApostados())) {
				ganhador.setQnt_acertos(6);
				this.novoGanhador(ganhador, concurso, codigoLoteria);
				concursos.add(concurso);

			} else if (cincoAcertos(concurso, numerosApostados)) {
				ganhador.setQnt_acertos(5);
				this.novoGanhador(ganhador, concurso, codigoLoteria);
				concursos.add(concurso);
			}
		}
		return concursos;
	}

	public Concurso findOne(Long codConcurso, Long codLoteria) {
		Loteria loteria = loteriaRepository.findOne(codLoteria);
		for (Concurso concurso : loteria.getConcursos()) {
			if (concurso.getCodigo().equals(codConcurso)) {
				return concurso;
			}
		}
		return null;
	}

	private Boolean cincoAcertos(Concurso concurso, NumerosApostados numerosApostados) {
		int acertos = 0;

		for (int i = 0; i < 6; i++) {
			if (concurso.getNumerosSorteados().contains(numerosApostados.getNumerosApostados().get(i))) {
				acertos++;
			}
		}

		return acertos >= 5;
	}

	private Long geraCodigo() {
		Random rd = new Random();
		Long cod = Long.valueOf((rd.nextInt((333 - 0) + 1) + 0) * 6);

		if (repository.findOne(cod) != null) {
			cod = Long.valueOf((rd.nextInt((333 - 0) + 1) + 0) * 6);
		}

		return cod;
	}

	private Long geraCodigoGanhador() {
		Random rd = new Random();
		Long cod = Long.valueOf((rd.nextInt((333 - 0) + 1) + 0) * 6);

		if (repository.findOneByGanhador(cod) != null) {
			cod = Long.valueOf((rd.nextInt((333 - 0) + 1) + 0) * 6);
		}

		return cod;
	}

}
