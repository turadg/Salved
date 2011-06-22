module ProblemsHelper
  
  def explanations_for_problem problem
    # TODO only get latest from a user on a step. had it working but broke on Heroku's PostgreSQL
    ary = problem.problem_events.where(:name => 'explanation')
    
    ary.inject({}) { |hash, obj|
      step = obj['step']
      hash[step] = [] unless hash[step]
      hash[step] << obj['value']
      hash
    }

  end

end
