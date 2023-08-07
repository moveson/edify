class String
  def numeric?
    true if Float(self)
  rescue StandardError
    false
  end
end
