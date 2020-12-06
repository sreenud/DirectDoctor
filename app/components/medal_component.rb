class MedalComponent < ViewComponent::Base
  def initialize(width:, height:, **props)
    @props = props

    @height = height.present? ? width : '20'
    @width = width.present? ? width : '20'
  end
end
