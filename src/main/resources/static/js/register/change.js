$(function () {

  /*修改个人头像弹框上传照片按钮事件*/
  if (typeof FileReader === "undefined") {
    $("input[type=file]").attr("disabled", "disabled");
  } else {
    $("#edit_photo_form .file input").change(function () {
      var file = $(this).get(0).files[0];//读取文件
      //FileReader，用于把文件读入内存，并读取文件中的数据
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        $("#edit_photo_form .photo_border dt img").attr("src", this.result);
        $("a.file img").attr("src", this.result);
      }

    });
  }


  $("#old_password").on("blur", function () {
    var token = $("body").attr("data-token");
    var password = $(this).val();
    if (password == undefined || password == null || password == "") {
      $($(this).siblings("span").get(0)).text("请输入您的当前密码").addClass(
          "text-danger").removeClass("text-success");
      $(this).focus();
      return;
    }
    var $input = $(this);
    $.post("/register/checkPassword", {
      token: token,
      password: password
    }, function (response) {
      if (response == "ok") {
        $($input.siblings("span").get(0)).text("密码正确").addClass(
            "text-success").removeClass("text-danger");
      } else if (response == "error") {
        $($input.siblings("span").get(0)).text("密码错误，请重新输入").addClass(
            "text-danger").removeClass("text-success");
        $input.val("").focus();
      } else if (response == "logout") {
        window.location.href = "/logout/" + token;
      }
    });

    $("#check_password").on("keyup", function () {
      var newPassword = $("#new_password").val();
      var checkPassword = $(this).val();
      if (checkPassword == "") {
        $($(this).siblings("span").get(0)).text("该项不能为空").addClass(
            "text-danger").removeClass("text-success");
        $(this).focus();
        return;
      } else if (newPassword != "" && checkPassword == newPassword) {
        $($(this).siblings("span").get(0)).text("密码正确").addClass(
            "text-success").removeClass("text-danger");
        return;
      } else {
        $($(this).siblings("span").get(0)).text("密码不匹配").addClass(
            "text-danger").removeClass("text-success");
        $(this).focus();
        return;
      }
    });

    $("#password_form").on("submit", function (event) {
      event.stopPropagation();
      event.preventDefault();
      var password = $("#new_password").val();
      var check_password = $("#check_password").val();
      if (password == "") {
        $($("#new_password").siblings("span").get(0)).text("该项不能为空").addClass(
            "text-danger").removeClass("text-success");
        $("#new_password").focus();
        return false;
      } else if (check_password == "") {
        $($("#check_password").siblings("span").get(0)).text("该项不能为空").addClass(
            "text-danger").removeClass("text-success");
        $("#check_password").focus();
        return false;
      } else if (password != check_password) {
        $($("#check_password").siblings("span").get(0)).text("密码不匹配").addClass(
            "text-danger").removeClass("text-success");
        $("#check_password").focus();
        return false;
      } else {
        var token = $("body").attr("data-token");
        $.post("/register/changePassword", {
          token: token,
          password: password
        }, function (response) {
          if (response == "ok") {
            alert("修改成功");
          } else if (response == "error") {
            alert("修改失败");
          } else if (response == "logout") {
            window.location.href = "/logout/" + token;
          }
          $("input").val("");
          $("input").siblings("span").text("").removeClass(
              "text-danger").removeClass("text-success");
        });
        return false;
      }
    });
  });

});