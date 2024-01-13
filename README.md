# Factories or Fixtures

Why not both? This is a demo application to illustrate the performance differences between using fixtures and factories. 

## Setup

The test suite in this repository consists of 2000 CRUD tests for comment functionality. Each comment belongs to a user and post.

```ruby
# test/factories/comment.rb
FactoryBot.define do
  factory :comment do
    text { 'text' }
    user
    post
  end
end
```

```yml
# test/fixtures/comments.yml
default:
  text: text
  user: default
  post: default
```

Tests are run with a setup using FactoryBot as well as a setup using fixtures, as well as a hybrid setup. Parallelization is disabled.

```ruby
# comments_controller_test.rb
setup do
  # @comment = comments(:default)
  # vs
  # @comment = create(:comment)
  # vs
  # @comment = create(:comment, post: posts(:default), user: users(:default))
end
```

```bash
bundle exec rake test
```

## Profiling

To generate a stack profile run:

```bash
TEST_STACK_PROF=1 bin/rails test
```

Then upload the generated report to [speedscope](https://www.speedscope.app/). To profile events via ActiveSupport notifications run:

```bash
EVENT_PROF='sql.active_record' bundle exec rake test
```

```bash
 EVENT_PROF=factory.create bundle exec rake test
```

## Results

On 2000 tests this test suite uses around 30% of it's time on setup when using FactoryBot. When using only fixtures that overhead just goes away. 

```text
[TEST PROF INFO] EventProf results for factory.create

Total time: 00:07.520 of 00:25.654 (29.32%)
Total events: 2000
```

Overall, test run times on an XPS 13 9300 can be found below. 

|            | Total | runs/s |
|------------|-------|--------|
| FactoryBot | 18s   | 107    |
| Fixtures   | 12s   | 171    |
| Hybrid     | 16s   | 116    |

