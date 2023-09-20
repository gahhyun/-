<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>    
<c:set var="user_no" value="${sessionScope.user_no}" />
<c:set var="loginId" value="${sessionScope.id}" />
<c:set var="loginout" value="${sessionScope.id == null ? 'logout' : 'login'}" />
<c:set var="loginoutlink" value="${sessionScope.id==null ? '/login' : '/mypage'}" />
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>캘린더</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> 
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js" integrity="sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    	

    <style>
        @import url('https://fonts.googleapis.com/css?family=Questrial&display=swap');

        body { background-color : gray; } 

        body > div:first-child {
            background-color : white;
            height: auto;;
            width: 800px;
            margin: 0px;
            padding: 20px;
            margin: 0 auto;
            border-radius:5px;
            box-shadow:0px 40px 30px -20px rgba(0,0,0,0.3);
        }

        td {
            width: 50px;
            height: 50px;
        }

        .Calendar {
            text-align: center;
        }

        .Calendar>thead>tr:first-child>td {
            font-family: 'Questrial', sans-serif;
            font-size: 1.1em;
            font-weight: bold;
        }

        .Calendar>thead>tr:last-child>td {
            font-family: 'Questrial', sans-serif;
            font-weight: 600;     
        }

        .Calendar>tbody>tr>td>p {
            font-family: 'Montserrat', sans-serif;
            height: 45px;
            width: 45px;
            border-radius: 45px;
            transition-duration: .2s;
            line-height: 45px;
            margin: 2.5px;
            display: block;
            text-align: center;
        }        

        .pastDay {
            color: lightgray;
            cursor: pointer;
        }

        .today {
            background-color: #F5D042;            
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }

        .futureDay {
            background-color: #FFFFFF;
            cursor: pointer;
        }
        .futureDay:hover{
            background:#eee;
        }

        .futureDay.choiceDay,
        .today.choiceDay {
            background: #0A174E;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
        }

        .holiday {
            color: red; /* 공휴일 텍스트 색상을 빨간색으로 설정 */
        }
        
        .todo-wrap{
		    width: 370px;
		    height: auto;
		    left: 390px;
		    bottom: 387px;
		    background-color: palegoldenrod;
		    border-radius: 10px;
		    font-size: 25px;
		    padding: 20px;
        }
        
         .input-box {
		    width: 270px;
		    margin-right: 20px;
		    height: auto; 
		    background: palegoldenrod;
		    color: black;
		    line-height : normal;
		    font-size17px;
		    font-family: inherit;
		    border: 0; 
		    border-bottom: 1px dashed #ddaf35;
		    border-radius: 0; 
		    outline-style: none; 
		    -webkit-appearance: none; 
		    -moz-appearance: none; 
		    appearance: none;
		  }
		  .input-data{
		    cursor: pointer;
		    font-size: 10px;
		    padding: 10px;
		    margin: 10px 0 10px 0;
		    background: #ddaf35;
		    border: none;
		    color: #0b0809;
		    border-radius: 10px;
		  }
		  .input-data:hover{
		    background: #ffffff;
		    color: #0b0809;
		  }
		  .input-list > div{
		    font-size: 10px;
		    width: 60%;
		    float: left;
		    color: #ddaf35;
		  }
		  .input-list > .checked{
		    color: #FFFFFF;
		    text-decoration:line-through
		  }
		  .insertplan{
		    border: none;
		    border-bottom: 2px solid black;
		    width: 274px;
		    height: 27px;
		    font-size: 20px;
		    padding: 10px 0px 5px 10px;
		    resize: none;
		  }
		  
		 /* 기본 버튼 스타일 */
		.planBtn {
		    padding: 3px 14px;
		    font-size: 18px;
		    background-color: green;
		    color: #fff;
		    border: none;
		    border-radius: 8px;
		    cursor: pointer;
		}		
		/* 버튼에 호버 효과 추가 */
		.planBtn:hover {
		  background-color: #0056b3;
		}		
		/* 버튼 클릭 시 약간 어두운 스타일 추가 */
		.planBtn:active {
		  background-color: #004899;
		}
    </style>
</head>
<body>
    <div>
        <table class="Calendar">
            <thead>
                <tr>
                    <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
                    <td colspan="5">
                        <span id="calYear"></span>년    
                        <span id="calMonth"></span>월                      
                        <span onClick="goToday();" style="cursor:pointer; color: darkslateblue;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Today</span>
                    </td>
                    <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
                      
                </tr>
                <tr style="height: 10px;">
                    <td style="display: flex; height: 25px;">
                        &nbsp;&nbsp;
                        <select id="yearSelect" onchange="updateCalendar()" style="border: none;"></select>
                        <select id="monthSelect" onchange="updateCalendar()" style="border: none;"></select> 
                    </td>
                </tr>
                <tr>
                    <td>일</td>
                    <td>월</td>
                    <td>화</td>
                    <td>수</td>
                    <td>목</td>
                    <td>금</td>
                    <td>토</td>
                </tr>
            </thead>

            <tbody>
            </tbody>
            
        </table>
        <form action="/plan/write" method="post" id="planForm">
        	<input type="hidden" id="selectedDate" name="plan_date" value="">
        	<!-- input에서 name 속성은 서버에서 폼 데이터를 처리할 때 필드를 식별하는 데 사용됩니다.  -->
	        <textarea placeholder="행사 등록" id="insertplan"  name="plan_content" class="insertplan"></textarea>
	        <button type="button" class="planBtn" id="planBtn">등록</button>
	        <div class="todo-wrap" style=" position: relative;" >
	              <div class="todo-title">Todo List</div>
	              <div class="input-wrap" style="padding-top: 15px">
	                <input type="text" placeholder="please write here!!" id="input-box" class="input-box">
	                <button type="button" id="input-data" class="input-data">INPUT</button>
	                <div id="input-list" class="input-list"></div>
	              </div>
	        </div>
	</form>
	
    	<div class="modal fade" id="commentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
     		<div class="modal-dialog modal-dialog-centered">
       		<div class="modal-content">
          		<div class="modal-header">
            		<h1 class="modal-title fs-5" id="exampleModalLabel">알림</h1>
            		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          		</div>
          		<div class="modal-body body"></div>
          		<div class="modal-footer">
            		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
          		</div>
        	</div>
      	</div>
   	</div>
	
    </div>
	 <script>
			document.addEventListener("DOMContentLoaded", function() {

				const insertPlan = document.getElementById("insertplan");
	        	const selectedDate = document.getElementById("selectedDate");
	        	const planForm = document.getElementById("planForm");
	
	        function choiceDate(newDIV) {
           		 // 선택한 날짜로 Plan_date 설정
	            selectedDate.value = new Date().toISOString().slice(0, 10);
	            
	            if (document.getElementsByClassName("choiceDay")[0]) {
	                document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
	            }
	            newDIV.classList.add("choiceDay");
	        }
	
	        document.getElementById("planBtn").addEventListener("click", function() {
	            // 텍스트 입력 값을 plan_content에 설정
	            const planContent = insertPlan.value;
	            if (planContent.trim() === "") {
	                alert("일정을 입력하세요.");
	                return;
	            }
	            planForm.submit();
	        });
	    });
	</script>
	
        <script>
			window.onload = function () { 

				const yearSelect = document.getElementById("yearSelect");
                const monthSelect = document.getElementById("monthSelect");
                populateYearMonthOptions(); 
                buildCalendar(); }    // 웹 페이지가 로드되면 buildCalendar 실행
    
            	let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
            	let today = new Date();     // 페이지를 로드한 날짜를 저장
            	today.setHours(0, 0, 0, 0);    // 비교 편의를 위해 today의 시간을 초기화
    
            	// 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
            	function buildCalendar() {
    
	                let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
	                let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날
	    
	                let tbody_Calendar = document.querySelector(".Calendar > tbody");
	                document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
	                document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신
	    
	                while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
	                    tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
	                }
	    
	                let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           
	    
	                for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
	                    let nowColumn = nowRow.insertCell();        // 열 추가
	                }
    
					for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  
                    	let nowColumn = nowRow.insertCell();        // 새 열을 추가하고
	                    let newDIV = document.createElement("p");
	                    newDIV.innerHTML = leftPad(nowDay.getDate());        // 추가한 열에 날짜 입력
	                    nowColumn.appendChild(newDIV);
    
					//토요일은 파란색, 일요일은 빨간색
                    if (nowDay.getDay() == 0) {
                   		newDIV.style.color = "red";
                    } else if (nowDay.getDay() == 6) {
                        newDIV.style.color = "blue";
                    }
    
                    if (nowDay < today) {                       // 지난날인 경우
                        newDIV.className = "pastDay";
                        newDIV.onclick = function () { 
                        	choiceDate(this); 
                        };
                    } else if (                                   // 오늘인 경우  
                   		nowDay.getFullYear() == today.getFullYear() && 
                        nowDay.getMonth() == today.getMonth() && 
                        nowDay.getDate() == today.getDate()
                    ) {          
                        newDIV.className = "today";
                        newDIV.onclick = function () { 
                            choiceDate(this); 
                        };
                        
                    } else {                                      // 미래인 경우
                        newDIV.className = "futureDay";
                        newDIV.onclick = function () { 
                            choiceDate(this); 
                        };
                    }
                    if (nowDay.getDay() == 6) { // 토요일인 경우
                        nowRow = tbody_Calendar.insertRow();
                    }


                    // 공휴일 설정
                    let holidayStart = new Date(2023, 8, 28); // 2023년 9월 28일
                    let holidayEnd = new Date(2023, 9, 3); // 2023년 10월 3일

                    if (
                        nowDay >= holidayStart &&
                        nowDay <= holidayEnd
                    ) {
                        newDIV.classList.add("holiday"); // 공휴일 클래스 추가
                    }   
                    
                    // 크리스마스 설정 (매년 12월 25일)
                    let christmas = new Date(nowDay.getFullYear(), 11, 25); // 11은 12월을 나타냅니다 (0부터 시작하므로)
                    if (
                        nowDay.getMonth() === christmas.getMonth() &&
                        nowDay.getDate() === christmas.getDate()
                    ) {
                        newDIV.classList.add("holiday"); // 크리스마스를 공휴일로 표시
                    }

                }
                

            }


            
            // 연도와 월 선택 드롭다운 메뉴를 가져옵니다.


            // 연도와 월 옵션을 동적으로 생성합니다.
            function populateYearMonthOptions() {
                const currentYear = new Date().getFullYear();
                for (let year = currentYear - 5; year <= currentYear + 5; year++) {
                    const option = document.createElement("option");
                    option.value = year;
                    option.textContent = year;
                    yearSelect.appendChild(option);
                }

                const months = [
                    "1월", "2월", "3월", "4월", "5월", "6월",
                    "7월", "8월", "9월", "10월", "11월", "12월"
                ];

                for (let i = 0; i < 12; i++) {
                    const option = document.createElement("option");
                    option.value = i;
                    option.textContent = months[i];
                    monthSelect.appendChild(option);
                }

                // 드롭다운 메뉴 초기값 설정
                yearSelect.value = nowMonth.getFullYear();
                monthSelect.value = nowMonth.getMonth();
            }

            // 드롭다운 메뉴가 변경될 때마다 달력을 업데이트합니다.
            function updateCalendar() {
                const selectedYear = parseInt(yearSelect.value);
                const selectedMonth = parseInt(monthSelect.value);
                nowMonth = new Date(selectedYear, selectedMonth, 1);
                buildCalendar();
            }
    
            // 날짜 선택
            function choiceDate(newDIV) {
                if (document.getElementsByClassName("choiceDay")[0]) {                              			// 기존에 선택한 날짜가 있으면
                    document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");  // 해당 날짜의 "choiceDay" class 제거
                }
                newDIV.classList.add("choiceDay");           // 선택된 날짜에 "choiceDay" class 추가
            }
    
            // 이전달 버튼 클릭
            function prevCalendar() {
                nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
                buildCalendar();    // 달력 다시 생성
            }
            // 다음달 버튼 클릭
            function nextCalendar() {
                nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
                buildCalendar();    // 달력 다시 생성
            }
    
            // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
            function leftPad(value) {
                if (value < 10) {
                    value = "0" + value;
                    return value;
                }
                return value;
            }

            function goToday() {
                const date = new Date();
                nowMonth = date; // 현재 날짜로 현재 월을 설정
                buildCalendar(); // 달력 다시 생성
            }  
            
            $(document).ready(function(){
            	
					//ajax-get방식 축약버전 호출방식
					$.get(
							"/ottt/plan/getPlanList"
				    		, function(data){
								//일정목록 호출 ajax 결과
								console.log(data);
							}
					);

			});
                       
        </script>	

</body>
</html>