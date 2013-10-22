require "spec_helper"
require "nokogiri/diff"

describe VCloudSdk::VDC do

  let(:logger) { VCloudSdk::Config.logger }
  let(:url) { ENV['VCLOUD_URL'] || VCloudSdk::Test::DefaultSetting::VCLOUD_URL }
  let(:username) { ENV['VCLOUD_USERNAME'] || VCloudSdk::Test::DefaultSetting::VCLOUD_USERNAME }
  let(:password) { ENV['VCLOUD_PWD'] || VCloudSdk::Test::DefaultSetting::VCLOUD_PWD }
  let(:vdc_name) { ENV['VDC_NAME'] || VCloudSdk::Test::DefaultSetting::VDC_NAME }
  let(:storage_profile_name) { ENV['STORAGE_PROFILE_NAME'] ||  VCloudSdk::Test::DefaultSetting::STORAGE_PROFILE_NAME }

  subject do
    client = VCloudSdk::Client.new(url, username, password, {}, logger)
    client.find_vdc_by_name(vdc_name)
  end

  its(:storage_profiles) { should have_at_least(1).items }

  describe "#find_storage_profile_by_name" do
    it "return a storage profile given targeted name" do
      storage_profile = subject.find_storage_profile_by_name(storage_profile_name)
      storage_profile.should_not be_nil
    end

    it "return nil if targeted storage profile with given name does not exist" do
      storage_profile = subject.find_storage_profile_by_name("xxxxxxx")
      storage_profile.should be_nil
    end
  end
end
