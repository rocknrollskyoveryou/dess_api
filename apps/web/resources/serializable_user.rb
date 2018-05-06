class SerializableUser < JSONAPI::Serializable::Resource
    type :users

    attributes :email, :first_name, :last_name
end