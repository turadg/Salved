function stepImages(dir, count) {
  imageList = new Array();
  for (i = 0; i <= stepCount; i+=1) {
    imagePath = dir + "/step-" + i + extension;
    imageList.push(imagePath);
  }
  return imageList;
}

function showProblemStep(step) {
  path = imageList[step];
  $('#work_shown').attr('src', path);
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

var lastJustification = "";
var currentStep;

function initProblemUI() {
  recordEvent('init', 'initialized');
  
  // record all button presses as id clicked
  $('button').click(function() {  recordEvent(this.id, 'clicked'); });
  // record anchors too
  $('a').click(function() {   recordEvent(this.id, 'clicked'); });
  // record change in any input
  $('input').change(function() {    recordEvent(this.name, this.value);  });
  $('textarea').blur(function() {    recordEvent(this.name, this.value);  });

  // save justification for explanation
  $('textarea[name="justification"]').blur(function() {
    lastJustification = this.value;
  });
  // paste it in on request
  $('#paste_justification').click(function () {
    selector = 'textarea[name="explanation"]';
    concatenated = $(selector).val() + " " + lastJustification;
    $(selector).val(concatenated);
    // and record new value
    recordEvent('explanation', concatenated);
  });  
  $('button.advance_problem').click(function() {
    recordEvent('advance_problem', this.id);
  });  
  $('.star-off').click(function() {
    $(this).addClass("star-on");
    recordEvent('star-on', this.id);
  });

  $('#work_check').click(function() {window.location.hash='/'+currentStep+'/check';});
  $('#work_help').click(function() {window.location.hash='/'+currentStep+'/explain';});

  $('button.record-check').click(function() {
    recordEvent('record-check', this.id); // id has their choice
    window.location.hash = '/'+currentStep+'/explain';
  });
  
  $('button.show_prior').click(function () {
    recordEvent('show_prior', this.id);
    $('#write_explanation').hide();
    $('#read_explanations').show();
  });
  
  $('button#revise_explanation').click(function() {
    $('#write_explanation').show();
    $('#read_explanations').hide();
  });
  
  $('#increment_explanation').click(incrementExplanation);
  
  $('button.finish_problem').click(function () {
    // button recorded by earlier binding
    window.location.hash = '/summary';
  });
}


$(document).ready(function()
{
  // Match all <A/> links with hovertip class and use title attr as content for a tooltip
  $('.hovertip').qtip({
    position: {
       my: 'top left', 
       at: 'bottom left'
    }
  }
  );
});
