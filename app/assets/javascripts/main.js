$(document).ready(function() {

  $("#show-form").click(function() {
    $("#option-forms").slideToggle();
  });

  // alert('dd')

  $("form input[type=submit]").click(function() {
    var email = '', username = '';
    username = $('#user_username').val();

    if (username != '') {
      $('#user_email').val(username + "@example.com");
      email = $('#user_email').val();
    }

    // alert(email)
    

    if (email !== "") {
      $('#new_user').submit();
    }
    
  });

});
