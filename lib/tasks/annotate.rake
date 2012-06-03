 namespace :db do
  task :migrate do
    unless Rails.env.production?
      require "annotate/annotate_models"
      AnnotateModels.do_annotations(:position_in_class => 'before', :position_in_fixture => 'before', :show_indexes => true)
    end
  end

  namespace :migrate do
    [:up, :down, :reset, :redo].each do |t|
      task t do
        unless Rails.env.production?
          require "annotate/annotate_models"
          AnnotateModels.do_annotations(:position_in_class => 'before', :position_in_fixture => 'before', :show_indexes => true)
        end
      end
    end
  end
end