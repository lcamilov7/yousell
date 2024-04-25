require "test_helper"

class FetchCountryJobTest < ActiveJob::TestCase
  test 'enqueue correctly' do
    assert_enqueued_jobs(0) # Nos aseguramos que no haya jobs encolados antes
    FetchCountryJob.perform_later(users(:sara).id, '0.0.0.0') # aqui solo testeamos que este encolando jobs
    assert_enqueued_jobs(1)
  end
end
