<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<%@include file="/WEB-INF/views/inc/asset.jsp"%>

<style>
</style>
</head>
<%@include file="/WEB-INF/views/inc/header.jsp"%>
<body>
	<section class="section pt-0">
		<div class="container mt-16">
			<div class="card px-10">
				<div class="text-center">
					<h1 class="mt-3 gradiTitle">
						<span>굿잡 for U</span>
					</h1>
					<p class="mt-6">회원님과 어울리는 회사를 조회 해보세요.</p>
				</div>
				<div id="matchinfo">
					<div class="cpsChart">
						<canvas id="cpSugradarChart" width="300" height="300"></canvas>
					</div>

					<div class="cpsContent pt-4">
						<div class="cpsMember">
							<h3>${name}님의 성향</h3>
							<div class="job_meta">
								<span class="job-keyword">사람중심</span> <span class="job-keyword">돈보다
									성장</span>
							</div>
							<p>결국 일도 '사람'이 모여서 하는 것!</p>
						</div>
					</div>
				</div>
				<div>
					<div class="border-t border-border py-10">
						<div class="cpsCompanyList">
							<h3>${name}님과 어울리는 회사</h3>
							<div class="cpsCompanyInfo">
								<div class="row mt-10 integration-tab-items">

									<c:forEach var="companyDTO" items="${top3}"
										varStatus="status">
										<div class="mb-8 md:col-6 lg:col-4 integration-tab-item"
											data-groups='["social"]'>
											<div
												class="rounded-xl bg-white px-10 py-8 shadow-lg min-h-400">
												<div
													class="integration-card-head flex items-center space-x-4">
													<img
														src="${companyDTO.dto.image}"
														alt="" />
													<div>
														<h4 class="h4">${companyDTO.dto.cp_name}</h4>
														<span class="font-medium">${companyDTO.dto.idst_name}</span>
													</div>
												</div>
												<div
													class="my-5 border-y border-border py-5 smallradarChart">
													 <canvas id="cp${status.index + 1}SugradarChart"></canvas>
												</div>
												<div class="mb-5 pb-5 border-b border-border">
													<div>
														<span
															class="bg-gradient inline-flex h-16 w-16 items-center justify-center rounded-full">
															${companyDTO.matchScore}% </span>
													</div>
													<span class="">"여기다.<br> ${name}님이 갈 곳!"
													</span>

												</div>
												<div class="job_meta">
												
												<c:forEach var="tag" items="${companyDTO.dto.tag_list}">
													<span class="job-keyword">${tag}</span>
												</c:forEach>		
														
												</div>
											</div>
										</div>

									</c:forEach>

								</div>

							</div>
						</div>
					</div>
				</div>

				<div class="cpsCompany">
					<h3>아쉽게 순위에 들지 못한 기업 :)</h3>
					<div class="row mt-14 cpsCompanyInfo">
					
					<c:forEach items="${list}" var="list">
						<div class="mb-8 sm:col-6 lg:col-4">
							<div class="rounded-xl bg-white p-6 shadow-lg lg:p-8">
								<div class="integration-card-head flex items-center space-x-4">
									<img
										src="${list.dto.image}"
										alt="">
									<div>
										<h4 class="h4">${list.dto.cp_name }</h4>
										<span class="font-medium">${list.dto.idst_name}</span>
									</div>

								</div>
								<div class="job_meta">
									<c:forEach items="${list.dto.tag_list}" var="tag">
										<span class="job-keyword">${tag}</span> 
									</c:forEach>
									
									<i class="fa-solid fa-star gold"></i> ${list.dto.review_avg}</span>
								</div>
							</div>
						</div>
					</c:forEach>
					
					
					
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@include file="/WEB-INF/views/inc/footer.jsp"%>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.4.1/chart.min.js"></script>
	<script>
		var ctx = document.getElementById('cpSugradarChart').getContext('2d');
		var myRadarChart = new Chart(ctx, {
			type : 'radar',
			data : {
				labels : [ '연봉', '조직안정성', '조직문화', '성장 가능성', '복지' ],
				datasets : [ {
					label : '회원', // 새로운 데이터셋의 라벨
					data : [${dto.salary}, ${dto.stability}, ${dto.culture}, ${dto.potential}, ${dto.welfare} ], // 새로운 데이터셋의 데이터
					backgroundColor : 'rgba(54, 162, 235, 0.2)', // fill color
					borderColor : 'rgba(54, 162, 235, 1)', // border color
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					r : {
						min : 0,
						max : 100,
						ticks : {
							stepSize : 20
						}
					}
				}
			}
		});

		<c:forEach var="companyDTO" items="${top3}" varStatus="status">
	    var ctx = document.getElementById('cp${status.index + 1}SugradarChart').getContext('2d');
	    var myRadarChart = new Chart(ctx, {
	      type: 'radar',
	      data: {
	        labels: ['연봉', '조직안정성', '조직문화', '성장 가능성', '복지'],
	        datasets: [{
	          label: '회사',
	          data: [${companyDTO.salary}, ${companyDTO.stability}, ${companyDTO.culture}, ${companyDTO.potential}, ${companyDTO.welfare}],
	          backgroundColor: 'rgba(255, 99, 132, 0.2)',
	          borderColor: 'rgba(255, 99, 132, 1)',
	          borderWidth: 1
	        }, {
	          label: '회원',
	          data: [${dto.salary}, ${dto.stability}, ${dto.culture}, ${dto.potential}, ${dto.welfare}],
	          backgroundColor: 'rgba(54, 162, 235, 0.2)',
	          borderColor: 'rgba(54, 162, 235, 1)',
	          borderWidth: 1
	        }]
	      },
	      options: {
	        scales: {
	          r: {
	            min: 0,
	            max: 100,
	            ticks: {
	              stepSize: 20
	            }
	          }
	        },
	        plugins: {
	          legend: {
	            display: false
	          }
	        }
	      }
	    });
	  </c:forEach>

	</script>
</body>
</html>