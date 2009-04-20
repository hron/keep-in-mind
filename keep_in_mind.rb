require 'activeresource'
require 'source_annotation_extractor'

module KeepInMind
  TODO_LIST_ID  = '123'
  TODO_LIST_URL = 'http://project.basecamphq.com/todo_lists'
  USER = 'user'
  PASSWORD = 'password'

  class TodoItem < ActiveResource::Base
   self.site = "#{TODO_LIST_URL}/#{TODO_LIST_ID}"
   self.user = USER
   self.password = PASSWORD
  end

  def self.export(tag)
    ex = Exporter.new
    ex.export(tag)
  end

  class Exporter
    def export(tag)
      extractor = SourceAnnotationExtractor.new(tag)
      notes = extractor.find
      notes.each do |file, note|
        content = "#{file} #{note.to_s}".chomp
        puts "Add note => #{content}" unless existing_notes.include?(content)
        TodoItem.create(:content => content) unless existing_notes.include?(content)
      end
    end

    def existing_notes
      @items ||= TodoItem.find(:all).collect(&:content)
    end
  end
end

