module SearchHelper
  def render_star_rating(rating, **props)
    custom_class = props.delete(:class)
    filled_stars = rating.to_f.round
    empty_stars = 5 - filled_stars
    content_tag(:div, class: "flex items-center #{custom_class}", **props) do
      filled_stars.times { concat(star) }
      empty_stars.times { concat(star(variant: 'empty')) }
    end
  end

  def doctor_pins
    @doctors.map { |doc| doctor_pin_string(doc) }.join('|')
  end

  def doctor_pin_string(doctor)
    [:lat, :lng, :price, :id].map { |a| doctor.send(a) || '' }.join(',')
  end

  def render_doctor_cards
    @doctors.map do |doc|
      tag.div(doctor_card(doc) + doctor_contact_info(doc), class: 'w-full box-bottom-shadow')
    end.join('').html_safe
  end

  def doctor_card(doctor, **props)
    custom_class = props.delete(:class)
    content_tag(:div, class: "w-full flex mt-6 #{custom_class}", id: "doc-#{doctor.id}", **props) do
      concat(doctor_avatar(doctor))
      concat(doctor_info(doctor))
      concat(doctor_stats(doctor))
      concat(doctor_actions(doctor))
    end
  end

  def doctor_contact_info(doctor, **props)
    custom_class = props.delete(:class)
    content_tag(:div, class: "w-full flex border-b pb-6 #{custom_class}", id: "doc-contact-#{doctor.id}", **props) do
      concat(
        tag.div(
          tag.div('MDVIP Group', class: 'text-md tracking-wide font-hurmebold mt-4 text-center'),
          class: 'w-1/2'
        )
      )
      concat(
        doctor_contact_div(
          'Message<span class=" ml-10 border-r border-gray-800"></span>',
          'email',
          custom_class: 'ml-6'
        )
      )
      concat(
        doctor_contact_div(
          '090078601 <span class=" ml-10 border-r border-gray-800"></span>',
          'phone'
        )
      )
      concat(doctor_contact_div('www.johndoe.com', 'web'))
    end
  end

  private

  def doctor_avatar(doctor)
    content_tag(:div, class: 'w-40') do
      if doctor.image.present?
        concat(
          tag.img(
            src: doctor.image,
            alt: "#{doctor.name} - #{doctor.address}",
            class: 'h-40 w-full object-cover border rounded-lg'
          )
        )
      else
        concat(
          image_pack_tag('doctor_PNG15987.png', class: 'h-40 w-full object-cover border rounded-lg')
        )
      end
    end
  end

  def doctor_info(doctor)
    content_tag(:div, class: 'w-3/12 ml-4') do
      concat(tag.div(
        tag.h2(doctor.name, class: 'text-2xl'),
        class: 'tracking-wide font-hurmebold'
      ))
      # TODO: change the following accordingly
      concat(tag.div('Internal Medicine', class: 'mt-2'))
      concat(doctor_rating(doctor))
      concat(tag.div('Max no. of Patients: 300', class: 'mt-2 text-base text-gray-600'))
      concat(tag.div(
        tag.div(image_pack_tag('icons/medal.svg', class: 'w-5 h-5 text-green-500')) +
        tag.div('Telehealth', class: 'pl-2'),
        class: 'w-full flex mt-2 text-base text-gray-600'
      ))
    end
  end

  def doctor_rating(_doctor)
    content_tag(:div, class: 'mt-2 w-full flex') do
      concat(render_star_rating(4))
      concat(tag.div(
        link_to('(300 Reviews)', '#', class: 'text-blue-500'),
        class: 'text-sm'
      ))
    end
  end

  def doctor_stats(_doctor)
    content_tag(:div, class: 'w-3/12 mt-4') do
      concat(tag.div('24/7 Direct Phone Access'))
      concat(tag.div('Direct Primary Care', class: 'mt-2'))
      concat(tag.div('Fee $10,0000', class: 'mt-2 text-base text-gray-600'))
      concat(tag.div('Apt: Same day', class: 'mt-2 text-base text-gray-600'))
      concat(doctor_medal('Home Visit Book', class: 'w-full flex mt-2 text-base text-gray-600'))
    end
  end

  def doctor_actions(_doctor)
    lcls = 'border-doctor-yellow rounded-lg px-2 bg-doctor-yellow text-white cursor-pointer hover:bg-doctor-yellow pt-1'
    content_tag(:div, class: 'w-3/12 mt-4') do
      concat(tag.div(
        link_to(
          'Book Appointment',
          '#',
          class: lcls
        ) + tag.div(image_pack_tag('icons/favorite.svg', class: 'w-5 h-5 ml-2')),
        class: 'w-full flex'
      ))
      concat(tag.div('13 years experience', class: 'mt-2'))
      concat(tag.div('FMDD Score: 9/10', class: 'mt-2 text-base text-gray-600'))
      concat(doctor_medal('Free Consultation', class: 'w-full flex mt-2 text-base text-gray-600'))
      concat(doctor_medal('Holistic/Lifestyle Med', class: 'w-full flex mt-2 text-base text-gray-600'))
    end
  end

  def star(variant: 'filled')
    fill_class = variant == 'filled' ? 'text-doctor-yellow' : 'text-gray-400'
    content_tag(:svg, class: "w-4 h-4 fill-current #{fill_class}", viewBox: '0 0 20 20') do
      concat(star_shape)
    end
  end

  def doctor_medal(text, **props)
    content_tag(:div, **props) do
      concat(tag.div(image_pack_tag('icons/medal.svg', class: 'w-5 h-5 text-green-500')))
      concat(tag.div(text, class: 'pl-2'))
    end
  end

  def star_shape
    tag.path(
      d: 'M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z'
    )
  end

  def doctor_contact_div(text, type, custom_class: '')
    content_tag(:div, class: "w-1/2 #{custom_class}") do
      concat(
        content_tag(:div, class: 'w-full flex mt-4 text-base') do
          concat(tag.div(image_pack_tag("icons/#{type}.svg", class: 'w-5 h-5')))
          concat(tag.div(text.html_safe, class: 'pl-2'))
        end
      )
    end
  end
end
