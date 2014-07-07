Pod::Spec.new do |s|
  s.name             = "DRProducerConsumerQueue"
  s.version          = "0.1.0"
  s.summary          = "A simple producer-consumer queue."
  s.description      = <<-DESC
                       Implements a queue with an attached producer block, which runs automatically until the queue has least a specified number of items ready to consume. 
                       
                       The queue is synchronized on the main thread, while the production work itself can be done in the background.
                       DESC
  s.homepage         = "https://github.com/danra/DRProducerConsumerQueue"
  s.license          = 'MIT'
  s.author           = { "Dan Raviv" => "dan.raviv@gmail.com" }
  s.source           = { :git => "https://github.com/danra/DRProducerConsumerQueue.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'DRProducerConsumerQueue'
  s.public_header_files = 'DRProducerConsumerQueue/*.h'
end
