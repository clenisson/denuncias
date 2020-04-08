class AddResolutionToDelations < ActiveRecord::Migration[6.0]
  def change
    add_column :delations, :resolution, :text, :nullable => true
  end
end
