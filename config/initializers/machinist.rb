# Add other envs here e.g. cucumber
if Rails.env.test?
  require 'machinist'
  
  def Machinist.clear!
    Sham.clear
  end
  
  def Machinist.load_blueprints
    Dir[Rails.root.join("test/blueprints", "**", "*.rb")].each do |file|
      load file
    end
  end
  
end
