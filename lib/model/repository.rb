class Repository
    def self.create(raw_repository)

    end

    attr_reader :id
    attr_reader :name
    attr_reader :description


    def type(type_id)
        Type.create(Services.repository.get_type_definition(id, type_id))
    end

    def type_tree

    end

    def create_type(type)
        Type.create(Services.repository.create_type(id, type))
    end

    def update_type(type)
        Type.create(Services.repository.update_type(id, type))
    end

    def delete_type(type_id)
        Services.repository.delete_type(id, type_id)
    end
end