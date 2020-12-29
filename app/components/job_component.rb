class JobComponent < ViewComponent::Base
  with_collection_parameter :doctor
  attr_reader :doctor

  def initialize(doctor:, **props)
    @doctor = doctor
    @props = props
  end

  def doctor_avatar(**props)
    if doctor.image.present?
      tag.img(
        src: doctor.image_url,
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
