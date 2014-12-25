

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


  var client;

  client = new Faye.Client('/faye');

  // alert(current_username)

  client.subscribe("/topics/" + current_username, function(payload) {

    // alert(payload.notice_count)
    $('#notice-count').html(payload.notice_count)

    var length = payload.notice_list.length;

    if (length > 0) {
      for (var i=0; i < payload.notice_list.length; i++) {
        $('#notice-list').append(payload.notice_list[i])
      }
    }
    

  });




});


