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
			cursor: pointer;
		}
		.arruma-display{
			display: inline !important;
		}
	</style>
	<body>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" >Loterias Baesso <i class="fas fa-tree"></i></a>
		  <div class=" " id="navbarNav">
		    <ul class="navbar-nav">
		      <li class="nav-item">
		        <a  class="nav-item nav-link active" href="<c:url value="/"/>">Home</a>
		      </li>
		      <li class="nav-item">
		        <a  class="nav-item nav-link active" href="<c:url value="/"/>">Voltar</a>
		      </li>
		    </ul>
		  </div>
		</nav>
		<c:choose>
			<c:when test="${empty loteria.nome}">
				<c:set var="titulo" value="Nova Loteria"></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="titulo" value="${loteria.nome}"></c:set>
				<script type="text/javascript">
					$(function(){
						$('.block-when-saved').attr('disabled', true);
					})
				</script>
			</c:otherwise>
		</c:choose>
		<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px;">
			<div class="col-sm-4 text-center">
				<h1 class="display-4" style="margin-top: 33px; margin-bottom: 33px;">${titulo}</h1>
				<form action="<c:url value = "/loteria/salvar"/>" method="post" class="col">
					<div class="form-group">
						<input type="hidden" class="form-control block-when-saved" id="codigo" name="loteria.codigo" value="${loteria.codigo}">
						
						<input type="text" class="form-control block-when-saved" id="nome" name="loteria.nome" placeholder="Nome" value="${loteria.nome}" required="required">
					</div>
					
					<button type="submit" class="btn btn-success pull-right block-when-saved">Salvar</button>
				</form>
			</div>
		</div>
		<c:if test="${not empty loteria.codigo}">
			<div class="row justify-content-sm-center" style="margin-left: 0px; margin-right: 0px;">
				<div class="col-sm-8">
					<hr class="my-5">
					<div class="col-sm-12 text-center">
					<h3>Concursos ${loteria.nome}</h3>
						<div class="row justify-content-sm-center" style="margin-top: 12px; margin-bottom: 12px;">
							<div class="col-sm-3">
								<button type="button" class="btn btn-primary" onclick="location.href='<c:url value="/concurso/novo/${loteria.codigo}" />'" >Adicionar concurso</button>
							</div>	
							<div class="col-sm-3">
								<button type="button" class="btn btn-info" data-toggle="modal" data-target="#findWinners">Verificar apostas</button>
							</div>	
						</div>	
					</div>
					<table class="table table-striped table-bordered ">
					  <thead>
					    <tr>
					      <th scope="col"> Nº </th>
					      <th scope="col"> Data </th>
					      <th scope="col"> Números sorteados </th>
					    </tr>
					  </thead>
					  <tbody>
						  <c:forEach items="${loteria.concursos}" var="concurso">
						    <tr onclick="location.href='<c:url value="/concurso/editar/${loteria.codigo}/${concurso.codigo}"/>'" class="pega-clique">
						      <td>${concurso.numero}</td>
						      <td>${concurso.data}</td>
						      <td>${concurso.numerosSorteados[0]}, ${concurso.numerosSorteados[1]}, ${concurso.numerosSorteados[2]}, ${concurso.numerosSorteados[3]}, ${concurso.numerosSorteados[4]}, ${concurso.numerosSorteados[5]}</td>
						    </tr>
						  </c:forEach>
					  </tbody>
					</table>
				</div>
			</div>
		</c:if>
		
		<div class="modal fade" tabindex="-1" role="dialog" id="findWinners">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">Verificar Apostas</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
			      <div class="container-fluid">
				      <div class="row" style="margin-top: 12px; margin-bottom: 12px;">
						<form action="<c:url value="/concurso/verificar/apostas"/>" method="post" class="col">
							<div class="form-group col-sm-12 p-0 text-center">
								<div class="form-group">
									<input type="hidden" class="form-control" id="codigoLoteria" name="codigoLoteria" value="${loteria.codigo}">
								
									<input type="text" class="form-control" id="nome" name="ganhador.nome" placeholder="Nome" required="required">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="nome" name="ganhador.cpf" placeholder="CPF" required="required">
								</div>
								<p class="lead">Números apostados:</p>
								<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display" required name="numerosApostados.numerosApostados[]" >
								<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display" required name="numerosApostados.numerosApostados[]" >
								<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display" required name="numerosApostados.numerosApostados[]" >
								<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display" required name="numerosApostados.numerosApostados[]" >
								<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display" required name="numerosApostados.numerosApostados[]" >
								<input type="number" min="1" max="60" class="form-control col-sm-3 col-md-3 arruma-display" required name="numerosApostados.numerosApostados[]" >
							</div>
							<button type="submit" class="btn btn-primary float-right">Procurar</button>
						</form>
					</div>
				</div>
		    </div>
		  </div>
		</div>
		<footer class="text-center" style="margin-top: 33px;">
			<a href="https://www.facebook.com/victhor.baesso" target="_BLANK" class="nav-link">João Victor Baesso®</a>
		</footer>
	</body>
</html>