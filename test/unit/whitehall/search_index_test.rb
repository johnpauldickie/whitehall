require 'test_helper'

module Whitehall
  class SearchIndexTest < ActiveSupport::TestCase
    class ::SearchableClass
    end

    test 'SearchIndex.add queues a search index add job for 10 seconds time to allow any transactions to complete' do
      searchable_thing = stub(class: SearchableClass, id: 'id')

      Sidekiq::Testing.fake! do
        SearchIndex.add(searchable_thing)
        job = SearchIndexAddWorker.jobs.last

        assert_equal ['SearchableClass', 'id', { "authenticated_user" => nil, "request_id" => nil }], job['args']
        assert_equal 10.seconds.from_now.to_i, job['at']
      end
    end

    test 'SearchIndex.delete queues a search index removal job for the instance based on its slug and rummager index' do
      searchable_thing = stub(search_index: { 'link' => 'full_slug' }, rummager_index: :index_name)

      Sidekiq::Testing.fake! do
        SearchIndex.delete(searchable_thing)
        args = SearchIndexDeleteWorker.jobs.last['args']

        assert_equal 'full_slug', args[0]
        assert_equal 'index_name', args[1]
      end
    end
  end
end
