<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
<script>
  window.onload = function() { // window.addEventListener('load', (event) => {와 동일합니다.

		var result = '<c:out value="${result}" />';

/*		
		console.log(result);
		
		if(result === '' || history.state) {
			
			console.log("return");
			return;
		}
*/		
		if(parseInt(result)>0){
			window.alert(result + " 번이 등록되었습니다.");
		}
		else if(result) {
			window.alert("처리가 완료 되었습니다");
		
		}
		
//		history.replaceState({}, null, null);
		
  };
</script>
<script type="text/javascript">

	function boardRegister() {
		window.location = "/board/register";
	}
</script>
<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
</script>

<script type="text/javascript">

$(document).ready(function(){

	var actionForm=$("#actionForm");
	
	$("#pageBtn a").on("click", function(e){
		
		e.preventDefault();
		
		console.log('click page button');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		e.preventDefault();
		
		actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	})
	

})
</script>

</head>
<body>
	<h1>Board List Page</h1>
	<button id="regBtn" type="button" onclick="boardRegister();">Register
		New Board</button>

	<table border='1'>
		<thead>
			<tr>
				<td>#번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>수정일</td>
			</tr>
		</thead>
		<tbody>
			<!-- tr>
				<td>${list[0].bno }</td>
				<td>${list[0].title}</td>
				<td>${list[0].writer}</td>
				<td>${list[0].regdate}</td>
				<td>${list[0].updateDate}</td>
			</tr>			
			<tr>
				<td>${list[1].bno }</td>
				<td>${list[1].title}</td>
				<td>${list[1].writer}</td>
				<td>${list[1].regdate}</td>
				<td>${list[1].updateDate}</td>
			</tr> -->


			<c:forEach items="${list}" var="board">
				<tr>
					<td><c:out value="${board.bno}" /></td>
					<td>
						<a class='move' href='<c:out value="${board.bno}" />'><c:out value="${board.title}" />
						</a>
					</td>
					<td><c:out value="${board.writer}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
							value="${board.regdate}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
							value="${board.updateDate}" /></td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	
	<div>
		<c:if test="${pageMaker.prev }">
			<button>Prev</button>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			<button id='pageBtn'><a href="${num}">${num}</a></button>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<button>Next</button>
		</c:if>
	</div>
	
	<form id='actionForm' action="/board/listpaging" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
	</form>
	
</body>
</html>