class CustomValidator < ActiveModel::Validator

  def validate(obj)
    set_record obj
  end

  private

  def set_record(obj)
    @record = obj
    @errors = @record.errors
  end

end
