package bae.baesso.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = "codigo")
public class Concurso {

	private Long codigo;
	private Long numero;
	private String data;
	private List<Integer> numerosSorteados;
	private List<Ganhador> ganhadores;

}
