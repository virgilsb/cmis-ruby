require_relative 'services'

class Folder < Object
    attr_reader :parent_id
    attr_reader :path
    attr_reader :allowed_child_object_type_ids

    def parent

    end

    def allowed_child_object_types

    end

    def children

    end

    def tree(depth)

    end

    def create(object)

    end

    def delete_tree
        Services.object.delete_tree(repository_id, object_id, true, false, false)
    end

end