class ChronicValidator < ActiveModel::EachValidator

  def validate_each(model, attribute, value)
    model.errors[attribute] << (options.message || "The format of the #{attribute} doesn't appear to be valid") if it_does_not_validate(value)
  end

  def it_does_not_validate(value)
    !Chronic.parse(value).nil?
  end
end
