# TwingEarch

This application monitors the Twitter timeline and notifies Slack according to the conditions.

<img width="631" alt="2017-08-25 11 28 11" src="https://user-images.githubusercontent.com/9972700/29697194-a281ca3e-8988-11e7-9027-67449a9e2e34.png">

Migration from [earch](https://github.com/flum1025/earch)

## Installation

Add this line to your application's Gemfile

    $ gem install twing_earch

## Usage

Add configuration

REF: [twing#configuration-file](https://github.com/flum1025/twing#configuration-file)

Example

```yaml
modules:
  earch:
    slack:
      api_key:
        token: xxxxxxxxxxxxxxxxxxxxx
      user_icon: ':earch:'
      notify_channel: '#earch'
      icon: ':flum_:'
      source_user: flum_
    rules:
      - text:
          type: regexp
          match test.*
        screen_name: twitterdev
      - hashtag:
          - test
          - events
        favorite_count: 50
      - retweet_count:
          type: range
          match 0..10
      - lang: ja
        retweet: false
        quote: false
        reply: true
```

And, run

    $ twing -s setting.yml --home-timeline --earch

## Configuration File

### slack

This key is for `Slack` configuration.

Argument|Required|Description
---|---|---
api_key|Required|Get from [Bots](https://your-team.slack.com/apps/manage/custom-integrations)
user_icon|Optional|Set the [Slack emoji](https://flum1025.slack.com/customize/emoji)
notify_channel|Required|Specify the notification channel
icon|Optional|Set your Twitter account icon
source_user|Optional|Set your Twitter screen_name

### rules

The value corresponding to a key is need to `Array`. You can use multiple rules and conditions.

Argument|DataType|Example|Comments
---|---|---|---
text|String|`text: tweet text`
||Regexp|`text: !ruby/regexp /^\d+$/`
user_id|String|`user_id: "12345"`|Not a number
user_name|String|`user_name: twitter name`
||Regexp|`user_name: !ruby/regexp /^[A-Z]+$/`
screen_name|String|`screen_name: screen name`
||Regexp|`screen_name: !ruby/regexp /^@test[0-9]+/`
favorite_count|Integer|`favorite_count: 50`|Get over 50 the number of favorites
||Range|`favorite_count: !ruby/range 10..20`|The number of favorites is 10 to 20
retweet_count|Integer|`retweet_count: 50`
||Range|`retweet_count: !ruby/range 10..20`
lang|String|`lang: ja`
||Regexp|`lang: !ruby/regexp /ja\|en/`
user_lang|String|`user_lang: ja`
||Regexp|`user_lang: !ruby/regexp /ja\|en/`
source|Array\<String>|`source: [TweetDeck, Twitter for WEB]`
hashtag|Array\<String>|`source: [test, memo]`|
mention|Array\<String>|`source: [twitter, twitterdev]`|String for screen_name
||Array\<Integer>|`source: [123, 456]`|Integer for id
reply|Boolean|`reply: false`
quote|Boolean|`quote: false`
retweet|Boolean|`retweet: false`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flum1025/twing_earch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TwingEarch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flum1025/twing_earch/blob/master/CODE_OF_CONDUCT.md).
