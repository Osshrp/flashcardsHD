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
	
  permit_params :email, :password, :password_confirmation, local_ids: [], 
    role_ids: []

  index do
    id_column
    column :email
    column :roles do |user|
      user.roles.map(&:name)
    end
    actions
  end

  form do |f|
    f.inputs "User details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles, :as => :select, :collection => Role.all
    end
    f.actions
  end

end

# ActiveAdmin.register Role do
#   belongs_to :User
# end