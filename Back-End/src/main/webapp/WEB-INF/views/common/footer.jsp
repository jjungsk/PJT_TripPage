<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 아이디 저장하기 변수 설정 --%>    
<c:if test="${cookie.enjoy_id.value != null}">
	<c:set var="saveid" value="${cookie.enjoy_id.value}" />
	<c:set var="idck" value="checked" />
</c:if>    
   
    <!-- Footer start-->
    <footer class="footer text-center text-black-50" style="line-height: 10px">
      <div class="container px-4 px-lg-5">Copyright &copy; SeoSeoDuo</div>
    </footer>
    <!-- Footer end-->
    <!-- 로그인 modal start -->
    <div
      class="modal fade"
      id="loginModal"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">Login</h4>
          </div>
          <!-- Modal body -->
          <div class="modal-body">
            <form action="">
              <div class="form-floating mb-1 modal-checkbox-div d-flex justify-content-end" id="login-saveid-div">
                <input
                class="form-check-input"
                type="checkbox"
                value="ok"
                id="login-saveid"
                name="login-saveid"
                ${idck}
              	/>
              	<label  class="form-check-label" for="login-saveid">
             	  아이디 저장</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="login-id"
                  name="login-id"
                  placeholder="ID"
                  spellcheck="false"
                  value="${saveid}"
                  onkeyup="enterkeyLogin()"
                />
                <label for="login-id" class="form-label">ID</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="password"
                  class="form-control"
                  id="login-password"
                  name="login-password"
                  placeholder="Password"
                  onkeyup="enterkeyLogin()"
                />
                <label for="login-password" class="form-label">Password</label>
              </div>
            </form>
          </div>
          <!-- Modal footer -->
          <div class="modal-footer">
          <!-- kakao login -->
          	<a href="https://kauth.kakao.com/oauth/authorize?client_id=730f9f109193f564342084729f2da770&redirect_uri=http://localhost:8080/user/kakaologin&response_type=code">
          		<img src="${root }/assets/img/kakao_login_medium_narrow.png" style="height: 35px">
          	</a>
            <button
              type="button"
              class="btn-dark btn-sm"
              name="btn-user-login"
              onclick="userLogin()"
            >
              로그인
            </button>
            <button
              type="button"
              class="btn-dark btn-sm"
              name="btn-user-login-find-pass"
              onclick="findPassShow()"
            >
              비밀번호 찾기
            </button>
            <button
              type="button"
              class="btn-dark btn-sm"
              id="btn-user-login-reset"
              data-bs-dismiss="modal"
            >
              취소
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- 로그인 modal end -->
    <!-- 비밀번호 찾기 modal start -->
    <div
      class="modal fade"
      id="findPassModal"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">Find Password</h4>
          </div>
          <!-- Modal body -->
          <div class="modal-body" id="find-pass-modal-body">
            <form action="">
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="find-pass-id"
                  name="find-pass-id"
                  placeholder="ID"
                  spellcheck="false"
                />
                <label for="find-pass-id" class="form-label">ID</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="find-pass-name"
                  name="find-pass-name"
                  placeholder="Name"
                />
                <label for="find-pass-name" class="form-label">Name</label>
              </div>
            </form>
          </div>
          <!-- Modal footer -->
          <div class="modal-footer" id="find-pass-modal-footer">
            <button
              type="button"
              class="btn-dark btn-sm"
              name="btn-find-pass"
              onclick="userFindPass()"
            >
              비밀번호 찾기
            </button>
            <button
              type="button"
              class="btn-dark btn-sm"
              id="btn-find-pass-reset"
              data-bs-dismiss="modal"
            >
              취소
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- 비밀번호 찾기 modal end -->
    <!-- 회원가입 modal start -->
    <div
      class="modal fade"
      id="SignUpModal"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">Sign-Up</h4>
          </div>
          <!-- Modal body -->
          <div class="modal-body">
            <form id="form-join" method="post" action="">
              <input type="hidden" name="act" value="join">
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="join-id"
                  name="join-id"
                  placeholder="ID"
                  spellcheck="false"
                />
                <label for="join-id" class="form-label">ID</label>
                <div class="join-check-result" id="idcheck-result"></div>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="password"
                  class="form-control"
                  id="join-password"
                  name="join-password"
                  placeholder="Password"
                />
                <label for="join-password" class="form-label">Password</label>
                <div class="join-check-result" id="passwordcheck-result"></div>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="password"
                  class="form-control"
                  id="join-password-check"
                  placeholder="Password Check"
                />
                <label for="join-password-check" class="form-label">Confirm Password</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="join-name"
                  name="join-name"
                  placeholder="Name"
                />
                <label for="join-name" class="form-label">Name</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="email"
                  class="form-control"
                  id="join-email"
                  name="join-email"
                  placeholder="seoseoduo@ssafy.com"
                />
                <label for="join-email" class="form-label">Email</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="tel"
                  class="form-control"
                  id="join-tel"
                  name="join-tel"
                  placeholder="010-1234-5678"
                />
                <label for="join-tel" class="form-label">Tel</label>
              </div>
              <div class="form-floating mb-3 modal-checkbox-div d-flex">
                <div>Are you a manager? </div>
                <input
                  type="checkbox"
                  class="form-check-input"
                  id="join-is-manager"
                  name="join-is-manager"
                  value="manager"
                />
                <label class="form-check-label" for="join-is-manager">Yes</label>
              </div>
              <div class="form-floating mb-3" id="join-manager-check-div" style="display: none">
                <input
                  type="text"
                  class="form-control"
                  id="join-manager-check"
                  name="join-manager-check"
                  placeholder="manager-check"
                />
                <label for="join-manager-check" class="form-label">Enter the manager number</label>
              </div>
            </form>
          </div>
          <!-- Modal footer -->
          <div class="modal-footer">
            <button
              type="button"
              class="btn-dark btn-sm"
              name="btn-user-join"
              onclick="userJoin()"
            >
              회원가입
            </button>
            <button
              type="button"
              class="btn-dark btn-sm"
              id="btn-user-join-reset"
              data-bs-dismiss="modal"
            >
              취소
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- 회원가입 modal end -->
    <!-- 회원정보 modal start -->
    <div
      class="modal fade"
      id="infoModal"
      data-bs-backdrop="static"
      data-bs-keyboard="false"
      tabindex="-1"
      aria-labelledby="staticBackdropLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">Info</h4>
          </div>
          <!-- Modal body -->
          <div class="modal-body">
            <form action="">
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="info-id"
                  name="info-id"
									value="${userinfo.id}"
                  readonly
                />
                <label for="info-id" class="form-label">ID</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="password"
                  class="form-control"
                  id="info-password"
                  name="info-password"
                  value="${userinfo.password}"
                />
                <label for="info-password" class="form-label">Password</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="password"
                  class="form-control"
                  id="info-password-check"
                  placeholder="Password Check"
                />
                <label for="info-password-check" class="form-label">Confirm Password</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="text"
                  class="form-control"
                  id="info-name"
                  name="info-name"
                  value="${userinfo.name}"
                  readonly
                />
                <label for="info-name" class="form-label">Name</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="email"
                  class="form-control"
                  id="info-email"
                  name="info-email"
                  value="${userinfo.email}"
                />
                <label for="info-email" class="form-label">Email</label>
              </div>
              <div class="form-floating mb-3">
                <input
                  type="tel"
                  class="form-control"
                  id="info-tel"
                  name="info-tel"
                  value="${userinfo.tel}"
                />
                <label for="info-tel" class="form-label">Tel</label>
              </div>
            </form>
          </div>
          <!-- Modal footer -->
          <div class="modal-footer">
            <button
              type="button"
              class="btn-dark btn-sm"
              name="btn-user-modify"
              onclick="userModify()"
            >
              회원정보 수정
            </button>
            <button
              type="button"
              class="btn-dark btn-sm"
              name="btn-user-delete"
              onclick="userDelete()"
            >
              회원 탈퇴
            </button>
            <button
              type="button"
              class="btn-dark btn-sm"
              id="btn-user-info-reset"
              data-bs-dismiss="modal"
            >
              취소
            </button>
          </div>
        </div>
      </div>
    </div>
    <!-- 회원정보 modal end -->
  </div>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script>
    
    // ***회원가입***
    var isUseId = false;
    //var isPasswordOk = false;

    document.querySelector("#join-id").addEventListener("keyup", function () {
     var userid = this.value;
     let resultDiv = document.querySelector("#idcheck-result");
     if(userid.length < 5 || userid.length > 16) {
    	 resultDiv.style.color = "red";
    	 resultDiv.textContent = "아이디는 5자 이상 16자 이하여야 합니다.";
    	 isUseId = false;
     } else {
    	 let userId = userid;
    	 fetch(`${root}/user/idcheck/\${userId}`)
    	.then(response => response.text())
    	.then(data => {
    		 if(data == 0) {
    		   resultDiv.style.color = "black";
    	     resultDiv.textContent = userId + "는 사용할 수 있습니다.";
    	     isUseId = true;
    		 } else {
    			 resultDiv.style.color = "red";
    	     resultDiv.textContent = userId + "는 사용할 수 없습니다.";
    	     isUseId = false;
    		 }
    	});
     }
    });
    
    function userJoin() {
    	let managerNumber = "1111";
    	let patternEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    	let patternTel = new RegExp("01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}");
    	let email = document.querySelector("#join-email").value;
    	let tel = document.querySelector("#join-tel").value;
    	if (!document.querySelector("#join-id").value) {
    		alert("아이디를 입력해주세요.");
    		return;
    	} else if (!document.querySelector("#join-password").value) {
    		alert("비밀번호를 입력해주세요.");
    		return;
    	} else if (document.querySelector("#join-password").value != document.querySelector("#join-password-check").value) {
    		alert("비밀번호를 다시 확인해주세요.");
    		return;
    	} else if (!document.querySelector("#join-name").value) {
    		alert("이름을 입력해주세요.");
    		return;
    	} else if (!email) {
    		alert("이메일을 입력해주세요.");
    		return;
    	} else if (!tel) {
    		alert("전화번호를 입력해주세요.");
    		return;
    	} else if (document.querySelector("#join-is-manager").checked && !document.querySelector("#join-manager-check").value) {
    		alert("관리자 번호를 입력해주세요.");
    		return;
    	} else if (document.querySelector("#join-is-manager").checked && document.querySelector("#join-manager-check").value != managerNumber) {
    		alert("관리자 번호를 확인해주세요.");
    		return;
    	} else if (!isUseId) {
        alert("아이디를 확인해주세요.");
        return;
    	} else if (!patternEmail.test(email)) {
    		alert("이메일 형식이 맞지 않습니다.");
        return;
      } else {
    		let form = document.querySelector("#form-join");
    		let isManager = 0;
    		if (document.querySelector("#join-is-manager").checked) {
    			isManager = 1;
    		}
        fetch("${root}/user/join", {
        	method: 'POST',
        	cache: 'no-cache',
        	headers: {
        		'Content-Type': 'application/json'
        	},
        	body: JSON.stringify({
            id: form.elements["join-id"].value,
            password: form.elements["join-password"].value,
            name: form.elements["join-name"].value,
            email: form.elements["join-email"].value,
            tel: form.elements["join-tel"].value,
            isManager: isManager
        	})
        })
    		.then(response => response.json())
    		.then(data => {
    			if (data == 1) {
    				joinReset();
    				alert("회원가입에 성공하였습니다.");
    				let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('SignUpModal'));
    	    	modal.hide();
    			} else {
    				alert("회원가입에 실패하였습니다.");
    			}
    		});
    	}
    }
    
    
 		// ***로그인***
 		function enterkeyLogin() {
 			if (window.event.keyCode == 13) {
 				userLogin();
 			}
 		}
 		
 		function userLogin() {
 			let id = document.querySelector("#login-id").value;
 			let pass = document.querySelector("#login-password").value;
 			if (!id) {
        alert("아이디를 입력해주세요.");
        return;
      } else if (!pass) {
        alert("비밀번호를 입력해주세요.");
        return;
      } else {
      	let saveid = 0;
    		if (document.querySelector("#login-saveid").checked) {
    			saveid = 1;
    		}
      	fetch("${root}/user/login", {
        	method: 'POST',
        	cache: 'no-cache',
        	headers: {
        		'Content-Type': 'application/json',
        		"Access-Control-Allow-Origin" : "*",
        		"Access-Control-Allow-Credentials" : true 
        	},
         	body: JSON.stringify({
            id: id,
            password: pass,
            saveid: saveid
        	})
        })
        	.then((response) => response.json())
    		.then(data => {
    			if (data.result == "success") { // 로그인 성공
    				menulogin();
    				document.querySelector("#login-password").value = "";
    				if (!document.querySelector("#login-saveid").checked) {
    					document.querySelector("#login-id").value = "";
        			}
    				setUserInfo(data);
    				location.reload();
    				let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('loginModal'));
    	    		modal.hide();
    			} else if (data.result == "password wrong") {
    				alert("비밀번호가 틀렸습니다.");
    				let loginPassword = document.querySelector("#login-password");
    				loginPassword.value = "";
    				loginPassword.focus();
    			} else if (data.result == "id not exist") {
    				alert("해당하는 아이디가 없습니다.");
    				let loginId = document.querySelector("#login-id");
    				loginId.value = "";
    				loginId.focus();
    			} else {
    				alert("로그인에 실패하였습니다.");
    			}
    		});
      }
 		}
 		
 		function menulogin() {
 		 //nav-item-user-login
 			document.querySelectorAll(".nav-items-user-login").forEach(function(element) {
 				element.style.display = "";
 			});
 			document.querySelectorAll(".nav-items-user-logout").forEach(function(element) {
 				element.style.display = "none";
 			});
 		}
 		
 		// ***비밀번호 찾기***
 		function userFindPass() {
 			let id = document.querySelector("#find-pass-id").value;
 			let name = document.querySelector("#find-pass-name").value;
 			if (!id) {
        alert("아이디를 입력해주세요.");
        return;
      } else if (!name) {
        alert("이름을 입력해주세요.");
        return;
      } else {
      	fetch("${root}/user/findPass", {
        	method: 'POST',
        	cache: 'no-cache',
        	headers: {
        		'Content-Type': 'application/json'
        	},
        	body: JSON.stringify({
        	userid: id,
        	username: name
        	})
        })
    		.then(response => response.text())
    		.then(data => {
    			if (data) { // 비밀번호 찾기 성공
    				showPass(name, data);
        		} else {
        			alert("아이디 또는 이름과 일치하는 사용자가 존재하지 않습니다.");
        		}
    		});
      }
 		}
 		
 		//document.querySelector("#nav-item-find-pass").addEventListener('click', openFindPass);
 		
 		function showPass(name, data) {
 			passContent = `
       			<div>\${name} 님의 비밀번호는 <strong>` + data + `</strong> 입니다.</div>
       		`;
       		document.querySelector("#find-pass-modal-body").innerHTML = passContent;
       		
       		passButton = `
       			<button
                type="button"
                class="btn-dark btn-sm"
                onclick="loginModalShow()"
              >
                로그인하기
              </button>
              <button
                type="button"
                class="btn-dark btn-sm"
                id="btn-find-pass-reset"
                data-bs-dismiss="modal"
              >
                취소
              </button>
       		`;
       		document.querySelector("#find-pass-modal-footer").innerHTML = passButton;
 		}
 		
 		function findPassShow() {
 			openFindPass();
 			let modalFindPass = bootstrap.Modal.getOrCreateInstance(document.getElementById('findPassModal'));
	    	modalFindPass.show();
 			let modalLogin = bootstrap.Modal.getOrCreateInstance(document.getElementById('loginModal'));
	    	modalLogin.hide();
 		}
 		
 		function openFindPass() {
 			passContent = `
 				<form action="">
 	              <div class="form-floating mb-3">
 	                <input
 	                  type="text"
 	                  class="form-control"
 	                  id="find-pass-id"
 	                  name="find-pass-id"
 	                  placeholder="ID"
 	                  spellcheck="false"
 	                />
 	                <label for="find-pass-id" class="form-label">ID</label>
 	              </div>
 	              <div class="form-floating mb-3">
 	                <input
 	                  type="text"
 	                  class="form-control"
 	                  id="find-pass-name"
 	                  name="find-pass-name"
 	                  placeholder="Name"
 	                />
 	                <label for="find-pass-name" class="form-label">Name</label>
 	              </div>
 	            </form>
       		`;
       		document.querySelector("#find-pass-modal-body").innerHTML = passContent;
       		
       		passButton = `
       			<button
                type="button"
                class="btn-dark btn-sm"
                name="btn-find-pass"
                onclick="userFindPass()"
              >
                비밀번호 찾기
              </button>
              <button
                type="button"
                class="btn-dark btn-sm"
                id="btn-find-pass-reset"
                data-bs-dismiss="modal"
              >
                취소
              </button>
       		`;
       		document.querySelector("#find-pass-modal-footer").innerHTML = passButton;
 		}
 		
 		function loginModalShow() {
 			let modalFindPass = bootstrap.Modal.getOrCreateInstance(document.getElementById('findPassModal'));
	    	modalFindPass.hide();
 			let modalLogin = bootstrap.Modal.getOrCreateInstance(document.getElementById('loginModal'));
	    	modalLogin.show();
 		}
 		
 		
 		// ***로그아웃***
 		document.querySelector("#nav-item-logout").addEventListener("click", function () {
 			let tempId = document.querySelector("#info-id").value;
 			
 			if (tempId != "kakaoId") {
 	 			fetch("${root}/user/logout")
 	 			.then(response => {
 	 				removeUserInfo();
 	 				menulogout();
 	 			})
 			} else {
 	 			fetch("${root}/user/kakaologout")
 	 			.then(response => {
 	 				removeUserInfo();
 	 				menulogout();
 	 			})
 			}
 			
 		})
 		
 		function menulogout() {
 			document.querySelectorAll(".nav-items-user-login").forEach(function(element) {
 				element.style.display = "none";
 			});
 			document.querySelectorAll(".nav-items-user-logout").forEach(function(element) {
 				element.style.display = "";
 			});
 		}
 		
 		<c:if test="${empty userinfo}">
 		menulogout();
 		</c:if>
		<c:if test="${!empty userinfo}">
		menulogin();
 		</c:if>
 		
		// ***회원정보***
		function setUserInfo(user) {
			document.querySelector("#info-id").value = user.id;
			document.querySelector("#info-password").value = user.password;
			document.querySelector("#info-password-check").value = "";
			document.querySelector("#info-name").value = user.name;
			document.querySelector("#info-email").value = user.email;
			document.querySelector("#info-tel").value = user.tel;
		}
		
		function removeUserInfo() {
			document.querySelector("#info-id").value = "";
			document.querySelector("#info-password").value = "";
			document.querySelector("#info-name").value = "";
			document.querySelector("#info-email").value = "";
			document.querySelector("#info-tel").value = "";
		}
		
		// ***회원정보 수정***
		function userModify() {
    	let patternEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    	let patternTel = new RegExp("01[016789]-[^0][0-9]{2,3}-[0-9]{3,4}");
    	
    	let id = document.querySelector("#info-id").value;
    	let password = document.querySelector("#info-password").value;
    	let name = document.querySelector("#info-name").value;
    	let email = document.querySelector("#info-email").value;
    	let tel = document.querySelector("#info-tel").value;
    	if (!id) {
    		alert("아이디를 입력해주세요.");
    		return;
    	} else if (!password) {
    		alert("비밀번호를 입력해주세요.");
    		return;
    	} else if (password != document.querySelector("#info-password-check").value) {
    		alert("비밀번호를 다시 확인해주세요.");
    		return;
    	} else if (!name) {
    		alert("이름을 입력해주세요.");
    		return;
    	} else if (!email) {
    		alert("이메일을 입력해주세요.");
    		return;
    	} else if (!tel) {
    		alert("전화번호를 입력해주세요.");
    		return;
    	} else if (!patternEmail.test(email)) {
    		alert("이메일 형식이 맞지 않습니다.");
        return;
      } else {
        fetch("${root}/user/modify", {
        	method: 'POST',
        	cache: 'no-cache',
        	headers: {
        		'Content-Type': 'application/json'
        	},
        	body: JSON.stringify({
            id: id,
            password: password,
            name: name,
            email: email,
            tel: tel
        	})
        })
    		.then(response => response.json())
    		.then(data => {
    			if (data.modify == "success") { // 수정 성공
    				alert("회원정보가 수정되었습니다.");
    				setUserInfo(data.user);
    				let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('infoModal'));
    	    	modal.hide();
    			} else {
    				alert("회원정보 수정에 실패하였습니다.");
    			}
    		});
    	}
    }
		
    // *** 회원 정보 Info 클릭 ***
    /*
		document.querySelector("#nav-item-info").addEventListener('click', function () {
			fetch("${root}/user?act=getInfo")
  		.then(response => response.json())
  		.then(data => {
  			if (data.result == "success") {
	  			setUserInfo(data);
  			} else {
  				alert(data.result);
  			}
  		});
		})
    */
		
		// ***회원탈퇴***
		function userDelete() {
			if (confirm("탈퇴하시겠습니까?")) {
				fetch("${root}/user/delete", {
		        	method: 'DELETE',
		        	headers: {
		        		'Content-Type': 'application/json'
		        	}
				})
	  		.then(response => response.text())
	  		.then(data => {
	  			if (data == "success") {
	  				let modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('infoModal'));
    	    	modal.hide();
    	    	menulogout();
	  			} else {
	  				alert(data);
	  			}
	  		});
			}
		}
 		
    
    </script>
    <script src="${root}/assets/js/scripts.js"></script>
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <!-- * *                               SB Forms JS                               * *-->
    <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
    <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
    <!-- <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>  -->
  </body>
</html>