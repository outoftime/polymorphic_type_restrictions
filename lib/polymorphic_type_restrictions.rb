module PolymorphicTypeRestrictions
   class <<self
     def included(base)
       class <<base
         include ClassMethods
         alias_method_chain :belongs_to, :polymorphic_type_restrictions
       end
     end
   end
 
   module ClassMethods
     def belongs_to_with_polymorphic_type_restrictions(association_name, options = {})
       allow = options.delete(:allow)
       belongs_to_without_polymorphic_type_restrictions(association_name, options)
       if allow
         module_eval(<<-RUBY)
           def #{association_name}_with_type_restriction=(object)
             unless object.is_a?(#{allow})
               raise(
                 ActiveRecord::AssociationTypeMismatch,
                 '#{association_name.inspect} only allows objects of type #{allow}'
               )
             end
             #{association_name}_without_type_restriction = object
           end
           alias_method_chain #{association_name.inspect}=, :type_restriction

           def #{association_name}_type=(class_name)
             begin
               clazz = class_name.constantize
             rescue NameError => e
               raise(ActiveRecord::AssociationTypeNameError, e.message)
             end
             unless class_name.constantize.ancestors.include?(#{allow})
               raise(
                 ActiveRecord::AssociationTypeMismatch,
                 '#{association_name.inspect} only allows objects of type #{allow}'
               )
             end
             write_attribute(#{:"#{association_name}_type".inspect}, class_name)
           end
         RUBY
       else
         module_eval(<<-RUBY)
           def #{association_name}_type=(class_name)
             begin
               class_name.constantize
             rescue NameError => e
               raise(ActiveRecord::AssociationTypeNameError, e.message)
             end
             write_attribute(#{:"#{association_name}_type".inspect}, class_name)
           end
         RUBY
       end
    end
  end
end

module ActiveRecord
  AssociationTypeNameError = Class.new(NameError)
end
