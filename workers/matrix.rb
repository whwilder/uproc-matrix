stations = {}

ARGV.each do |filename|
   STDERR.puts filename
   file = File.open("#{filename}")
   samples = {}
   file.readlines.each do |line|
      s=line.split(",")
      sample = s[0]
      freq   = s[1]
      samples[sample] = [] if samples[sample].nil?
      samples[sample] << freq.to_i
   end
   STDERR.puts "Done reading #{filename}"
   
   file.close
   # sum up the the frequency for each sample at this station
   samples.each do |sample,freq|
      totalFreq = freq.reduce(:+)
      samples[sample] = totalFreq
   end
   STDERR.puts "Done summing frequencies"
   stations[filename] = samples
end
allSamples = []
# get a list of all the sample names
stations.invert.keys.each{|samples| allSamples << samples.keys}
printf "Sample\t"
stations.keys.each{|station| printf "%10s\t", station}
puts
allSamples.flatten.uniq.sort.each do |sample|
   printf "#{sample}\t"
   stations.each do |station,samp|
      padding = station.length
      if ! samp[sample].nil?
         printf("%10d\t", samp[sample])
      else
         printf("%10d\t", 0)
      end
   end
   puts
end
