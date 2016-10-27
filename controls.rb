class Controls

  # TODO use yaml or json
  def initialize(control_file)
    @control_file = control_file
  end

  def speed
    if @control_file.nil?
      0.2
    else
      File.read(@control_file).to_f
    end
  end
end



