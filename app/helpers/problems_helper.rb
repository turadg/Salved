module ProblemsHelper
  
  def explanations_for_problem problem
    ary = problem.problem_events.where(:name => 'explanation').group(:step, :ip_address, :id).order('created_at DESC')
    
    ary.inject({}) { |hash, obj|
      step = obj['step']
      hash[step] = [] unless hash[step]
      hash[step] << obj['value']
      hash
    }

  end

end
