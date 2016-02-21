module Cbe
  class CompetencyOutcome < ActiveRecord::Base
    self.table_name = 'cbe_competency_outcomes'
    belongs_to :competency

  end
end