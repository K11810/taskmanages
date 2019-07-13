FactoryBot.define do

    factory :task do
      title { 'test_task_01' }
      content { 'testtesttest' }
      deadline { '2019-12-31'}
    end

    factory :second_task, class: Task do
      title { 'test_task_02' }
      content { 'samplesample' }
      deadline { '2019-11-10'}
      status { 1 }
    end
  end
