function stepImages(imagePath, count) {
  // emulate Handlebars in Underscore templating
  _.templateSettings = { interpolate : /\{\{(.+?)\}\}/g  };
  
  template = _.template(imagePath);
  
  // TODO refactor this as a map from integers
  imageList = new Array();
  for (i = 0; i <= count; i+=1) {
    fullImagePath = template({stepIndex : i});
    imageList.push(fullImagePath);
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

// TODO refactor this into the router
var lastJustification = "";
var currentStep; 
var problem_id;

function initProblemUI(problem) {
  console.log("initProblemUI");
  
  var problem_id = problem.id; // TODO confirm this doesn't require problem.get('id')
  
  recordEvent('init', 'initialized');
  
  // set up env
  console.log("getting step images…");
  imageList = stepImages(problem.get('filesPath'), problem.get('step_count'));
  // start loading all the images
  imageList.forEach( function(path) { new Image().src=path; } );
  
  
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

  $('#work_check').click(function() {window.router.navigate('/'+currentStep+'/check', true);});
  $('#work_help').click(function() {window.router.navigate('/'+currentStep+'/check', true);});

  $('button.record-check').click(function() {
    recordEvent('record-check', this.id); // id has their choice
    window.router.steps.at(currentStep).save({selfcheck: this.id});
    window.router.navigate('/'+currentStep+'/explain', true);
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
  
  $('.advance_step').click(function() {
    understood = !!~this.id.indexOf('yes');
    window.router.steps.at(currentStep).save({understood: understood});
    window.router.navigate('/'+(++currentStep)+'/try', true);
  });
  
  $('button.finish_problem').click(function () {
    // button recorded by earlier binding
    attrs = {
      difficulty: $('input:radio[name=difficulty_9pt]:checked').val(),
      note_to_self: $('textarea[name=note_to_self]').val(),
      note_to_instructor: $('textarea[name=note_to_instructor]').val()
    };
    console.log("before save", window.router.elaboration.attributes, attrs);
    window.router.elaboration.save(attrs);
    console.log("after save", window.router.elaboration.attributes);
    // window.router.navigate('/summary', true);
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
