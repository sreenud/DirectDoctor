class AddFreeConsultationToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :free_consultation_time, :string)
  end
end
