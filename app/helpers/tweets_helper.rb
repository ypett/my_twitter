module TweetsHelper

  def get_tagged(tweet)

    message_array = tweet.message.split

    message_array.each_with_index do |word, index|
      if word[0] == "#"
        # see if the tag exists
        if Tag.pluck(:phrase).include?(word)
          # attach the tweet to existing tag (save it as a variable for when we create the tweet)
          tag = Tag.find_by(phrase: word)
        else
          # otherwise make a tag
          tag = Tag.create(phrase: word)
        end

        tweet_tag = TweetTag.create(tweet_id: tweet_id, tag_id: tag.id)

        message_array[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"

      end
    end

    tweet.update(message: message_array.join(" "))

    tweet

  end

end
