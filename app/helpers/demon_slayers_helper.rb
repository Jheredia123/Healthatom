module DemonSlayersHelper
  def l_or(value, alternative_value = "")
    if value.present?
      l(value)
    else
      alternative_value
    end
  end
end
