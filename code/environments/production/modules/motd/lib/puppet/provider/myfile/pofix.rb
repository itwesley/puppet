Puppet::Type.type(:myfile).provide(:posix) do

  desc "Simple File Support"

  def exists?
    File.exists?(@resource[:name])
  end

  def create
    File.open(@resource[:name], "w") { |f| f.puts "" }
  end

  def destroy
    File.unlink(@resource[:name])
  end

end
