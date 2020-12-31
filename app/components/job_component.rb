class JobComponent < ViewComponent::Base
  with_collection_parameter :doctor
  attr_reader :doctor

  def initialize(doctor:, reviews_data:, **props)
    @doctor = doctor
    @reviews_data = reviews_data
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

  def doctor_total_reviews
    if @reviews_data[doctor.id].present?
      review = @reviews_data[doctor.id]&.first
      review[:total]
    else
      0
    end
  end

  def doctor_avg_review
    if @reviews_data[doctor.id].present?
      review = @reviews_data[doctor.id]&.first
      review[:avg_rating]&.round
    end
  end

  def job_posted
    doctor.job_posted_on.strftime("%b %d, %y")
  end
end
