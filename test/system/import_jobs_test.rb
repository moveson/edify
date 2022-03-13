require "application_system_test_case"

class ImportJobsTest < ApplicationSystemTestCase
  setup do
    @import_job = import_jobs(:one)
  end

  test "visiting the index" do
    visit import_jobs_url
    assert_selector "h1", text: "Import jobs"
  end

  test "should create import job" do
    visit import_jobs_url
    click_on "New import job"

    fill_in "Elapsed time", with: @import_job.elapsed_time
    fill_in "Error message", with: @import_job.error_message
    fill_in "Failure count", with: @import_job.failure_count
    fill_in "Row count", with: @import_job.row_count
    fill_in "Started at", with: @import_job.started_at
    fill_in "Status", with: @import_job.status
    fill_in "Success count", with: @import_job.success_count
    fill_in "User", with: @import_job.user_id
    click_on "Create Import job"

    assert_text "Import job was successfully created"
    click_on "Back"
  end

  test "should update Import job" do
    visit import_job_url(@import_job)
    click_on "Edit this import job", match: :first

    fill_in "Elapsed time", with: @import_job.elapsed_time
    fill_in "Error message", with: @import_job.error_message
    fill_in "Failure count", with: @import_job.failure_count
    fill_in "Row count", with: @import_job.row_count
    fill_in "Started at", with: @import_job.started_at
    fill_in "Status", with: @import_job.status
    fill_in "Success count", with: @import_job.success_count
    fill_in "User", with: @import_job.user_id
    click_on "Update Import job"

    assert_text "Import job was successfully updated"
    click_on "Back"
  end

  test "should destroy Import job" do
    visit import_job_url(@import_job)
    click_on "Destroy this import job", match: :first

    assert_text "Import job was successfully destroyed"
  end
end
