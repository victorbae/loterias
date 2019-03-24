package bae.baesso.controller;

import javax.inject.Inject;

import bae.baesso.model.Concurso;
import bae.baesso.model.Ganhador;
import bae.baesso.model.NumerosApostados;
import bae.baesso.service.ConcursoService;
import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;

@Path("/concurso")
@Controller
public class ConcursoController {

	@Inject
	private ConcursoService service;

	@Inject
	private Result result;

	@Get("/novo/{codigoLoteria}")
	public void novo(Long codigoLoteria) {
		result.include("codigoLoteria", codigoLoteria);
	}

	@Get("/editar/{codigoLoteria}/{codigoConcurso}")
	public void editar(Long codigoLoteria, Long codigoConcurso) {
		result.include("concurso", service.findOne(codigoConcurso, codigoLoteria));
		result.redirectTo(this).novo(codigoLoteria);
	}

	@Post("/novo/ganhador")
	public void novoGanhador(Long codLoteria, Concurso concurso, Ganhador ganhador) {
		service.novoGanhador(ganhador, concurso, codLoteria);
		result.redirectTo(this).editar(codLoteria, concurso.getCodigo());
	}

	@Post("/salvar")
	public void salvar(Concurso concurso, Long codigoLoteria) {
		service.salvar(concurso, codigoLoteria);
		result.redirectTo(LoteriaController.class).editar(codigoLoteria);
	}

	@Post("/verificar/apostas")
	public void verificarApostas(Long codigoLoteria, Ganhador ganhador, NumerosApostados numerosApostados) {
		result.include("concursos", service.verificarApostas(ganhador, numerosApostados, codigoLoteria));
		result.include("codigoLoteria", codigoLoteria);
	}

}
