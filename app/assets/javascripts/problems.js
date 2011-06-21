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
  $("input:radio").removeAttr("checked");
  $('.supplement').hide();

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
    
$(function () {
  
  $("input[name=match]").change(function () {

    switch ($(this).val()) {
      case "yes":
        $('.supplement').hide();
        break;
      case "no":
        $('#help_supplement').show();
        $('#mine_supplement').hide();
        break;
      case "fine":
        $('#help_supplement').hide();
        $('#mine_supplement').show();
        break;
    }
    
  });
  
  revealAndDiscuss = function() {
    $('#prompt').hide();
    $('#dialog').show();
    currentStep += 1;
    updateProblem(imageList, currentStep);
  };  
  $('button.advance_problem').click(revealAndDiscuss);
  
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
