ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

puts "🎓 COMPLETE RUBY PROGRAMMING MASTERY COURSE"
puts "=" * 50
puts "📚 Course: #{ruby_course.title}"
puts "👨‍🏫 Instructor: #{ruby_course.instructor.email}"
puts "⏱️  Duration: #{ruby_course.duration} hours"
puts "📖 Description: #{ruby_course.description}"
puts "📊 Published: #{ruby_course.published? ? 'Yes' : 'No'}"
puts "\n📋 LESSONS & CONTENT:"
puts "-" * 50

ruby_course.lessons.order(:position).each do |lesson|
  puts "\n#{lesson.position}. #{lesson.title}"
  puts "   Content Blocks: #{lesson.content_blocks.count}"
  
  lesson.content_blocks.order(:position).each do |block|
    content_preview = case block.block_type
                     when 'text'
                       block.content[0..50] + "..."
                     when 'image'
                       "Image: #{block.file_url}"
                     when 'video'
                       "Video: #{block.file_url}"
                     end
    puts "     #{block.position}. #{block.block_type.titleize}: #{content_preview}"
  end
  
  puts "   Assignments: #{lesson.assignments.count}"
  lesson.assignments.each do |assignment|
    puts "     • #{assignment.title} (#{assignment.assignment_type.titleize})"
    puts "       Questions: #{assignment.assignment_questions.count} | Points: #{assignment.max_score}"
    
    question_breakdown = assignment.assignment_questions.group(:question_type).count
    breakdown_text = question_breakdown.map { |type, count| "#{count} #{type.humanize}" }.join(", ")
    puts "       Breakdown: #{breakdown_text}"
  end
end

puts "\n📊 COURSE STATISTICS:"
puts "-" * 30
puts "• Total Lessons: #{ruby_course.lessons.count}"
puts "• Total Content Blocks: #{ruby_course.lessons.joins(:content_blocks).count}"
puts "  - Text Blocks: #{ruby_course.lessons.joins(:content_blocks).where(content_blocks: { block_type: 'text' }).count}"
puts "  - Image Blocks: #{ruby_course.lessons.joins(:content_blocks).where(content_blocks: { block_type: 'image' }).count}"
puts "  - Video Blocks: #{ruby_course.lessons.joins(:content_blocks).where(content_blocks: { block_type: 'video' }).count}"
puts "• Total Assignments: #{ruby_course.lessons.joins(:assignments).count}"
puts "• Total Questions: #{ruby_course.lessons.joins(assignments: :assignment_questions).count}"
puts "• Total Possible Points: #{ruby_course.lessons.joins(assignments: :assignment_questions).sum('assignment_questions.points')}"

question_types = ruby_course.lessons.joins(assignments: :assignment_questions)
                            .group('assignment_questions.question_type').count
puts "• Question Type Breakdown:"
question_types.each do |type, count|
  puts "  - #{type.humanize}: #{count}"
end

assignment_types = ruby_course.lessons.joins(:assignments).group('assignments.assignment_type').count
puts "• Assignment Type Breakdown:"
assignment_types.each do |type, count|
  puts "  - #{type.humanize}: #{count}"
end

puts "\n✅ Ruby Programming Mastery course is complete and ready for students!"