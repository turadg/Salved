function stepImages(dir, count) {
  imageList = new Array();
  for (i = 0; i <= stepCount; i+=1) {
    imagePath = dir + "/step-" + i + extension;
    imageList.push(imagePath);
  }
  return imageList;
}

function updateProblem(imageList, currentStep) {
  path = imageList[currentStep];
  $('#work_shown').attr('src', path);
  currentExplanation = 0;
  incrementExplanation();
  
  // empty the fields
  $('textarea').val('');
  $("input:checkbox").removeAttr("checked");
  $('.supplement').hide();
  $('#write_explanation').show();
  $('#read_explanations').hide();    
  
}

function incrementExplanation() {
  expl = explanations[currentStep] ? explanations[currentStep][currentExplanation] : "<not available>";
  $('#prior_explanation').text(expl);
  currentExplanation += 1;
  if (explanations[currentStep] && currentExplanation >= explanations[currentStep].length) {
    $("#increment_explanation").attr('disabled', 'disabled');
  } else {
    $("#increment_explanation").removeAttr('disabled');
  }
}

function recordEvent(name, value) {
  // common: problem_id, currentStep
  data = {'problem_event': {
    'problem_id': problem_id,
    'step': currentStep,
    'name': name,
    'value': value
  }};
  $.post('/problem_events', data);
}    

$(function () {  
  
  recordEvent('init', 'initialized');
  
  // record all button presses as id clicked
  $('button').click(function() {
    recordEvent(this.id, 'clicked');
  });
  // record change in any input
  $('input').change(function() {
    recordEvent(this.name, this.value);
  });
  $('textarea').blur(function() {
    recordEvent(this.name, this.value);
  });
  
  
  
  $('button.advance_problem').click(function() {
    recordEvent('advance_problem', this.id);
  });
  
  revealAndDiscuss = function(next_div) {
    $('#prompt').hide();
    $(next_div).show();
    currentStep += 1;
    updateProblem(imageList, currentStep);
  };  
  $('#work_help').click(function() {revealAndDiscuss('#dialog');});
  $('#work_check').click(function() {revealAndDiscuss('#work-check');});
  $('button.record-check').click(function() {
    recordEvent('record-check', this.id);
    $('#work-check').hide();
    $('#dialog').show();
  });
  
  $('button.show_prior').click(function () {
    recordEvent('record-check', this.id);
    $('#write_explanation').hide();
    $('#read_explanations').show();
  });
  
  $('button#revise_explanation').click(function() {
    $('#write_explanation').show();
    $('#read_explanations').hide();    
  });
  
  $('#increment_explanation').click(incrementExplanation);
  
  $('button.advance_step').click(function () {
    $('#dialog').hide();
    if (currentStep < stepCount) {
      $('#prompt').show();
    } else {
      $('#done').show();
    }
  });

  updateProblem(imageList, currentStep); // step 0, the problem statement
});
