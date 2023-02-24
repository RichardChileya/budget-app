class AddIconColumnToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :icon, :string, default: "https://cdn-icons-png.flaticon.com/512/4835/4835459.png"
  end
end
