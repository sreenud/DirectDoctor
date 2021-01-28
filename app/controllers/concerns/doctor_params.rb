module DoctorParams
  extend ActiveSupport::Concern

  private

  def doctor_params
    params.require(:doctor).permit(:title, :gender, :name, :slug, :practice_name, :style,
      :speciality_id, :min_experience, :max_experience, :language, :is_holistic_medicine, :holistic_option,
      :is_telehealth_service, :telehealth_option, :is_home_visit, :home_visit_option, :aditional_services,
      :min_price, :max_price, :min_patients, :max_patients, :access, :appointments, :consultation,
      :free_consultation_time, :about_clinic, :about_doctor, :email, :phone, :address_line_1, :address_suite,
      :state, :city, :zipcode, :fax, :website_url, :disciplinary_action_taken, :fmdd_score, :image, :status,
      :lat, :lng, :price_options, :patients_options, :prices, :patients_in_panel,
      :disciplinary_action_details, :update_request, other_specialities: [], active_licenses: [],
      social_profiles: [[:social_link]], education: [[:year], [:name]],
      certifications: [[:year], [:name]], achievements: [[:year], [:name]])
  end
end
