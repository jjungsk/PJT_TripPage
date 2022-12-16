// register, join
document.querySelector("#join-is-manager").addEventListener('change', function() {
	let managerCheckDiv = document.querySelector("#join-manager-check-div");
  if (this.checked) {
  	managerCheckDiv.style.display = "";
  } else {
  	managerCheckDiv.style.display = "none";
  	managerCheckDiv.children[0].value = "";
  }
});

document.querySelector("#join-password").addEventListener("keyup", function () {
  let password = this.value;
  let resultDiv = document.querySelector("#passwordcheck-result");
  let strongPassword = new RegExp('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})');
  let mediumPassword = new RegExp('((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{6,}))|((?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9])(?=.{8,}))');
  
  if (password == "") {
  	resultDiv.textContent = "";
  } else if (strongPassword.test(password)) {
  	resultDiv.textContent = 'Strong Password';
  } else if (mediumPassword.test(password)) {
  	resultDiv.textContent = 'Medium Password';
  } else {
  	resultDiv.textContent = 'Weak Password';
  }
 });

document.querySelector("#btn-user-join-reset").addEventListener('click', joinReset);

function joinReset() {
	document.querySelector("#join-id").value = "";
	document.querySelector("#join-password").value = "";
	document.querySelector("#join-password-check").value = "";
	document.querySelector("#join-name").value = "";
	document.querySelector("#join-email").value = "";
	document.querySelector("#join-tel").value = "";
	document.querySelector("#join-manager-check").value = "";
	document.querySelector("#join-is-manager").checked = false;
	document.querySelector("#join-manager-check-div").style.display = "none";
	document.querySelector("#idcheck-result").textContent = "";
	document.querySelector("#passwordcheck-result").textContent = "";
}


// login
document.querySelector("#btn-user-login-reset").addEventListener('click', loginReset);

function loginReset() {
	document.querySelector("#login-id").value = "";
	document.querySelector("#login-password").value = "";
}

//




//////////////////////////////////////////////

window.addEventListener("DOMContentLoaded", (event) => {
  // Navbar shrink function
  var navbarShrink = function () {
    const navbarCollapsible = document.body.querySelector("#mainNav");
    if (!navbarCollapsible) {
      return;
    }
    if (window.scrollY === 0) {
      navbarCollapsible.classList.remove("navbar-shrink");
    } else {
      navbarCollapsible.classList.add("navbar-shrink");
    }
  };

  // Shrink the navbar
  navbarShrink();

  // Shrink the navbar when page is scrolled
  document.addEventListener("scroll", navbarShrink);

  // Activate Bootstrap scrollspy on the main nav element
  const mainNav = document.body.querySelector("#mainNav");
  if (mainNav) {
    new bootstrap.ScrollSpy(document.body, {
      target: "#mainNav",
      offset: 74,
    });
  }

  // Collapse responsive navbar when toggler is visible
  const navbarToggler = document.body.querySelector(".navbar-toggler");
  const responsiveNavItems = [].slice.call(
    document.querySelectorAll("#navbarResponsive .nav-link")
  );
  responsiveNavItems.map(function (responsiveNavItem) {
    responsiveNavItem.addEventListener("click", () => {
      if (window.getComputedStyle(navbarToggler).display !== "none") {
        navbarToggler.click();
      }
    });
  });
});

function findRecommend(key) {
  let child = key.children[0].textContent;
  localStorage.setItem("keywordRecommend", child);
  location.href = "placeRecommend.html";
}
