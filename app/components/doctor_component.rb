class DoctorComponent < ViewComponent::Base
  attr_reader :doctor
  def initialize(doctor:, **props)
    @doctor = doctor
    @props = props
  end

  def doctor_avatar(**props)
    if doctor.image.present?
      tag.img(
        src: doctor.image,
        alt: "#{doctor.name} - #{doctor.address}",
        **props
      )
    else
      image_pack_tag(
        'doctor_PNG15987.png',
        alt: "#{doctor.name} - #{doctor.address}",
        **props
      )
    end
  end
end
