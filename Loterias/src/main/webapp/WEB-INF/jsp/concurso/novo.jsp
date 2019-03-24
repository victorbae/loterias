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
		.arruma-display{
			display: inline !important;
		}
	</style>
	<c:choose>
			<c:when test="${empty concurso.numero}">
				<c:set var="titulo" value="Novo Concurso"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="titulo" value="Concurso Nº${concurso.numero}"></c:set>
				
				<script>
					$(function(){
						$('.block-when-saved').attr('disabled', true);
					})
				</script>
			</c:otherwise>
		</c:choose>
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
		<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px;">
			<div class="col-sm-4">
				<h1 class="display-4 text-center" style="margin-top: 33px; margin-bottom: 33px;">${titulo}</h1>
				<form action="<c:url value="/concurso/salvar"/>" method="post" class="col">
					<div class="form-group">
						<input type="hidden" class="form-control" id="codigoLoteria" name="codigoLoteria" value="${codigoLoteria}">
						<input type="hidden" class="form-control" id="codigoConcurso" name="concurso.codigo" value="${concurso.codigo}">
						
						<input type="text" class="form-control block-when-saved" id="numero" name="concurso.numero" placeholder="Numero" value="${concurso.numero}">
					</div>
					 <div class="form-group">
		                    <input type="text" class="form-control block-when-saved" id="data" name="concurso.data" placeholder="Data" value="${concurso.data}" onfocus="(this.type='date')" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}"/>
		            </div>
					<div class="form-group col-sm-12 p-0 text-center">
						<p class="lead">Números sorteados:</p>
						<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display block-when-saved" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[0]}">
						<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display block-when-saved" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[1]}">
						<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display block-when-saved" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[2]}">
						<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display block-when-saved" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[3]}">
						<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display block-when-saved" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[4]}">
						<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display block-when-saved" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[5]}">
					</div>
					
					<button type="submit" class="btn btn-primary float-right block-when-saved">Salvar</button>
				</form>
			</div>
		</div>
		
		<c:if test="${not empty concurso.codigo}">
			<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px;">
				<div class="col-sm-8">
					<hr class="my-5">
					<h3 class="text-center">Ganhadores</h3>
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newVencedor" style="margin-top: 12px; margin-bottom: 12px;">Adicionar ganhador</button>
					</div>
					<table class="table table-striped table-bordered ">
					  <thead>
					    <tr>
					      <th scope="col"> Nome </th>
					      <th scope="col"> CPF </th>
					      <th scope="col"> Quantidade de acertos </th>
					    </tr>
					  </thead>
					  <tbody>
						  <c:forEach items="${concurso.ganhadores}" var="ganhador">
						    <tr>
						      <td>${ganhador.nome}</td>
						      <td>${ganhador.cpf}</td>
						      <td>${ganhador.qnt_acertos}</td>
						    </tr>
						  </c:forEach>
					  </tbody>
					</table>
				</div>
			</div>
		</c:if>
		<div class="modal fade" tabindex="-1" role="dialog" id="newVencedor">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">Novo ganhador</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
				<form action="<c:url value='/concurso/novo/ganhador' />" method="post">
					<div class="modal-body">
						<div class="form-group">
							<input type="hidden" class="form-control" id="codigoLoteria" name="codLoteria" placeholder="Codigo" value="${codigoLoteria}">
							
							<input type="hidden" class="form-control" id="codigo" name="concurso.codigo" value="${concurso.codigo}">
							<input type="hidden" class="form-control" id="numero" name="concurso.numero" value="${concurso.numero}">
							<input type="hidden" class="form-control" id="data" name="concurso.data" value="${concurso.data}">
							
							<input type="hidden" class="form-control" id="data" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[0]}">
							<input type="hidden" class="form-control" id="data" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[1]}">
							<input type="hidden" class="form-control" id="data" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[2]}">
							<input type="hidden" class="form-control" id="data" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[3]}">
							<input type="hidden" class="form-control" id="data" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[4]}">
							<input type="hidden" class="form-control" id="data" name="concurso.numerosSorteados[]" value="${concurso.numerosSorteados[5]}">
							
							<c:forEach items="${concurso.ganhadores}" var="ganhador">
							    <input type="hidden" class="form-control" id="ganhadores" name="concurso.ganhadores[].nome" value="${ganhador.nome}">
							    <input type="hidden" class="form-control" id="ganhadores" name="concurso.ganhadores[].cpf" value="${ganhador.cpf}">
							    <input type="hidden" class="form-control" id="ganhadores" name="concurso.ganhadores[].qnt_acertos" value="${ganhador.qnt_acertos}">
						  	</c:forEach>
						  
							<input type="text" class="form-control" id="nome" name="ganhador.nome" placeholder="Nome">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" id="nome" name="ganhador.cpf" placeholder="CPF">
						</div>
						<div class="form-group">
							<input type="number" max="6" min="5" class="form-control" id="nome" name="ganhador.qnt_acertos" placeholder="Quantidade de acertos">
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">Salvar</button>
					</div>
				</form>
		    </div>
		  </div>
		</div>
		<footer class="text-center" style="margin-top: 33px;">
			<a href="https://www.facebook.com/victhor.baesso" target="_BLANK" class="nav-link">João Victor Baesso®</a>
		</footer>
	</body>
</html>