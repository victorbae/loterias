<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Loteria</title>
		
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" ></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" ></script>
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" >
	</head>
	<style type="text/css">
		.pega-clique:hover{
			background-color: rgba(0,0,0,.10) !important;
		}
	</style>
	<script>
	
	</script>
	<body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" >Loterias Baesso <i class="fas fa-tree"></i></a>
		  <div class="" id="navbarNav">
		    <ul class="navbar-nav">
		      <li class="nav-item">
		        <a  class="nav-item nav-link active" href="<c:url value="/"/>">Home</a>
		      </li>
		      <li class="nav-item">
		        <a  class="nav-item nav-link active" href="<c:url value="/loteria/editar/${codigoLoteria}"/>">Voltar</a>
		      </li>
		    </ul>
		  </div>
		</nav>
			<c:choose>
			<c:when test="${not empty concursos}">
				<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px;">
					<div class="col-sm-8">
						<hr class="my-5">
						<div class="col-sm-12 text-center">
						<h3>Você acertou a sequência nesses concursos:</h3>
						<div class="alert alert-success" role="alert" style="margin-top: 12px; margin-bottom: 12px;">
						  Você já foi adicionado na lista de ganhadores dos seguintes concursos:
						</div>
						</div>
						<table class="table table-striped table-bordered ">
						  <thead>
						    <tr>
						      <th scope="col"> Nº </th>
						      <th scope="col"> Data </th>
						      <th scope="col"> Números sorteados </th>
						      <th></th>
						    </tr>
						  </thead>
						  <tbody>
							  <c:forEach items="${concursos}" var="concurso">
							    <tr class="pega-clique">
							      <td>${concurso.numero}</td>
							      <td>${concurso.data}</td>
							      <td>${concurso.numerosSorteados[0]}, ${concurso.numerosSorteados[1]}, ${concurso.numerosSorteados[2]}, ${concurso.numerosSorteados[3]}, ${concurso.numerosSorteados[4]}, ${concurso.numerosSorteados[5]}</td>
							      <td class="text-center"><button type="button" class="btn btn-success" data-toggle="modal" data-target="#receberPremio">Retirar Prêmio <i class="far fa-laugh-beam"></i></button></td>
							    </tr>
							  </c:forEach>
						  </tbody>
						</table>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px; margin-top: 33px;">
					<div class="alert alert-danger" role="alert">
						 Você não acertou a quantidade mínima de números.
					</div>
				</div>
				<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px;">
					<button type="button" class="btn btn-warning" onclick="location.href='<c:url value="/loteria/editar/${codigoLoteria}"/>'">Voltar</button>
				</div>
			</c:otherwise>
			</c:choose>
	
		
		<div class="modal" tabindex="-1" role="dialog" id="receberPremio">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">Retirar Prêmio</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <p>Compareça na agência da Caixa mais próxima, apresente seu recibo de aposta e retire o prêmio.</p>
		      </div>
		    </div>
		  </div>
		</div>
		<footer class="text-center" style="margin-top: 33px;">
			<a href="https://www.facebook.com/victhor.baesso" target="_BLANK" class="nav-link">João Victor Baesso®</a>
		</footer>
	</body>
</html>