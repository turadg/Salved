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

function incrementExplanation() {
  expl = "<not available>";
  $('#prior_explanation').text(expl);
  currentExplanation += 1;
  if (explanations[currentStep] && currentExplanation >= explanations[currentStep].length) {
    $("#increment_explanation").attr('disabled', 'disabled');
  } else {
    $("#increment_explanation").removeAttr('disabled');
  }
}


// TODO refactor this into the router
var currentStep; 

function initProblemUI(recordEvent) {  
  recordEvent('init', 'initialized');
  
  // record all button presses as id clicked
  $('button').click(function() {  recordEvent(this.id, 'clicked'); });
  // record anchors too
  $('a').click(function() {   recordEvent(this.id, 'clicked'); });
  // record change in any input
  $('input').change(function() {    recordEvent(this.name, this.value);  });
  $('textarea').blur(function() {    recordEvent(this.name, this.value);  });

  // FIXME reimplement pasting last justification on request
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
  $('#work_help').click(function() {window.router.navigate('/'+currentStep+'/explain', true);});

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
  });
  
  $('button.finish_problem').click(function () {
    // button recorded by earlier binding
    attrs = {
      difficulty: $('input:radio[name=difficulty_9pt]:checked').val(),
      note_to_self: $('textarea[name=note_to_self]').val(),
      note_to_instructor: $('textarea[name=note_to_instructor]').val()
    };
    window.router.elaboration.save(attrs);
    window.router.navigate('/summary', true);
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
