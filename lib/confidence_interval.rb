module ConfidenceInterval

  def self.included(base)
    base.class_exec do
      select_clause = <<-SQL
        *, CASE (up_votes + down_votes)
        WHEN 0 THEN random()
        ELSE
          ((up_votes + 1.9208) / (up_votes + down_votes) -
          1.96 * SQRT((up_votes * down_votes) /
          (up_votes + down_votes) + 0.9604) /
          (up_votes + down_votes)) /
          (1 + 3.8416 / (up_votes + down_votes))
        END AS ci_lower_bound
      SQL

      scope :by_rating,  select(select_clause).order('ci_lower_bound DESC')

    end
  end
end

