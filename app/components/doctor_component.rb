class DoctorComponent < ViewComponent::Base
  include ApplicationHelper

  with_collection_parameter :doctor
  attr_reader :doctor
  def initialize(doctor:, **props)
    @doctor = doctor
    @props = props
  end

  def profile_url
    @doctor.profile_url
  end

  def doctor_avatar(**props)
    if doctor.image.present?
      tag.img(
        src: doctor_display_image(doctor),
        alt: "#{doctor.name} - #{doctor.address}",
        **props
      )
    else
      image_pack_tag(
        'doctor_default.svg',
        alt: "#{doctor.name} - #{doctor.address}",
        **props
      )
    end
  end
end
