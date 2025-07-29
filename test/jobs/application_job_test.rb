require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "should inherit from ActiveJob::Base" do
    assert ApplicationJob.ancestors.include?(ActiveJob::Base)
  end

  test "should have correct queue adapter" do
    assert_equal :test, ActiveJob::Base.queue_adapter.class.name.demodulize.underscore.to_sym
  end

  test "should be able to enqueue job" do
    assert_enqueued_jobs 1 do
      ApplicationJob.perform_later
    end
  end

  test "should handle job execution" do
    job = ApplicationJob.new
    assert_nothing_raised do
      job.perform
    end
  end

  test "should have default queue configuration" do
    # Test default queue setup
    assert_not_nil ApplicationJob.queue_name
  end
end
