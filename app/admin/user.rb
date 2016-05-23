ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	
  permit_params :email, roles: [:id, :name, :resource_type]

  index do
    id_column
    column :email
    column :roles do |user|
      user.roles.first.name if user.roles.first
    end
    actions
  end

  # form do |f|
  #   f.inputs do
  #   #   f.has_many :roles do |r|
  #   #     r.input :name
  #   #   end
  #   end
  #   f.input 'Email', :email
  #   f.actions
  # end

end

# ActiveAdmin.register Role do
#   belongs_to :User
# end