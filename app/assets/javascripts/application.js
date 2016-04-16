// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

function attachListeners(){

  $('form').submit(function(event){
    event.preventDefault();
  })

  $('#new_exercise').bind("ajax:error", function(evt, xhr, status, error){

    var $form = $(this),
        errors,
        errorText;
    try {
      // Populate errorText with the comment errors
      errors = $.parseJSON(xhr.responseText);
    } catch(err) {
      // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
      errors = {message: "Please reload the page and try again"};
    }

    // Build an unordered list from the list of errors
    errorText = "There were errors with the submission: \n<ul>";

    for ( error in errors ) {
      errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
    }

    errorText += "</ul>";

    $form.find('div.field_with_errors').html(errorText);

    // $form.find('div.validation-error').html(errorText);
  });


  // Abstracted away to use Remote True - create exercise form
  // $('#new_exercise').submit(function(event){
  //   event.preventDefault();
  //   var form_method = $(this).attr('method');
  //   var form_action = $(this).attr('action');
  //
  //   $.ajax(form_action, {
  //     type: form_method,
  //     dataType: 'script',
  //     data: $(this).serialize()
  //   }).error(function(res){
  //     debugger;
  //   })
  // });

  $('tbody td a').click(function(event){
    event.preventDefault();

    // REMOVED TO USER REMOTE TRUE
    // var method = $(this).data('method');
    // var deleteURL = $(this).attr('href');
    //
    // $.ajax(deleteURL, {
    //   type: method,
    //   dataType: 'script',
    // })
  });

  $('tbody').on('click', 'a.edit-link', function(){
    var workoutRow = $(this).parents('tr')
    // $('input[name="workout[name]"]').focus()
    // Hide workout values and display edit workout input form
    $('span', workoutRow).addClass('hide-row');
    $('input', workoutRow).attr('id', 'edit-workout')
  });

  // $('tbody').on('blur', 'a.edit-link', function(){
  //   var workoutRow = $(this).parents('tr')
  //
  //   // Display workout values and hide edit workout input form
  //   $('span', workoutRow).removeClass('hide-row');
  //   $('input', workoutRow).removeAttr('id');
  // });
}

$(function(){
  attachListeners();
})
