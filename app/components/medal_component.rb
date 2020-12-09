class MedalComponent < ViewComponent::Base
  def initialize(width:, height:, badge_color:, **props)
    @props = props

    @height = height.present? ? width : '20'
    @width = width.present? ? width : '20'
    @badge_color = badge_color
  end
end
