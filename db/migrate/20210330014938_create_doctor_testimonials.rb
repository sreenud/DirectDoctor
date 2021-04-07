class CreateDoctorTestimonials < ActiveRecord::Migration[6.0]
  def change
    create_table(:doctor_testimonials) do |t|
      t.integer(:testimonial_by)
      t.integer(:testimonial_to)
      t.text(:message)
      t.string(:status, default: "draft")

      t.timestamps
    end
  end
end
