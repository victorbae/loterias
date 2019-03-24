package bae.baesso.controller;

import java.util.List;

import javax.inject.Inject;

import bae.baesso.model.Loteria;
import bae.baesso.service.LoteriaService;
import br.com.caelum.vraptor.Controller;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Result;

@Path("/loteria")
@Controller
public class LoteriaController {

	@Inject
	private LoteriaService service;

	@Inject
	private Result result;

	@Get("/")
	public List<Loteria> lista() {
		return service.listar();
	}

	@Get("/novo")
	public void novo() {
		// Mapeado para jsp
	}

	@Get("/editar/{codigo}")
	public void editar(Long codigo) {
		result.include("loteria", service.getRepository().findOne(codigo));
		result.redirectTo(LoteriaController.class).novo();
	}

	@Get("/excluir/{codigo}")
	public void excluir(Long codigo) {
		service.excluir(service.getRepository().findOne(codigo));
		result.redirectTo(LoteriaController.class).lista();
	}

	@Post("/salvar")
	public void salvar(Loteria loteria) {
		Loteria loteriaSalva;
		loteriaSalva = service.salvar(loteria);
		result.redirectTo(this).editar(loteriaSalva.getCodigo());
	}

}
