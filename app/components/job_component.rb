class JobComponent < ViewComponent::Base
  def initialize(title:)
  end

  def job_avatar(**props)
    image_pack_tag(
      'doctor_PNG15987.png',
      alt: "Job default",
      **props
    )
  end
end
