namespace :state do
  desc "Update state slug"
  task update_slug: :environment do
    @states = State.pluck(:id, :name)
    @states.each do |state|
      @state = State.find(state.first)
      @state.slug = state.last.parameterize
      @state.save
    end
    puts "States and cities import is completed"
  end
end
