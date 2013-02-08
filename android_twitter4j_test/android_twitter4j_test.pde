/* From http://blog.blprnt.com/blog/blprnt/updated-quick-tutorial-processing-twitter
 * We need FOUR things to authenticate our sketch: A consumer key & secret, and an access token & secret. You can get all 4 of these things from the twitter developer page.
 
 *  1. Visit https://dev.twitter.com/ and login with your twitter username and password
 *  2. Click on the ‘Create an app’ button at the bottom right
 *  3. Fill out the form that follows – you can use temporary values (like “Jer’s awesome test application”) for the first three fields.
 *  4. Once you’ve agreed to the developer terms, you’ll arrive at a page which shows the first two of the four things that we need: the Consumer key and the Consumer secret. Copy and paste these somewhere so you have them ready to access.
 
 Consumer key  5c7u1e829C2d2cIiFaLiHQ
 Consumer secret  vbU7tgfZStiANl3JmkUsPLopa4RnCKR7ey9FlMZVVE
 
 
 Access token  64042332-bdK5S2myym2Cko2vd6eYlZwpvqcbLq8b3IYv8tbhz
 Access token secret  B7yMGXirREIF0FHPKfLfaLPgEKpHqe5mSERNbXeAJM
 */


//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();

void setup() {
  //Set the size of the stage, and the background to black.
  size(550, 550);
  background(0);
  smooth(); 
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("5c7u1e829C2d2cIiFaLiHQ");
  cb.setOAuthConsumerSecret("vbU7tgfZStiANl3JmkUsPLopa4RnCKR7ey9FlMZVVE");
  cb.setOAuthAccessToken("64042332-bdK5S2myym2Cko2vd6eYlZwpvqcbLq8b3IYv8tbhz");
  cb.setOAuthAccessTokenSecret("B7yMGXirREIF0FHPKfLfaLPgEKpHqe5mSERNbXeAJM");

  Twitter twitter = new TwitterFactory(cb.build()).getInstance();
  Query query = new Query("#SparkFun");

  query.setRpp(100);

  //Try making the query request.
  try {
    QueryResult result = twitter.search(query);
    ArrayList tweets = (ArrayList) result.getTweets();

    for (int i = 0; i < tweets.size(); i++) {
      Tweet t = (Tweet) tweets.get(i);
      String user = t.getFromUser();
      String msg = t.getText();
      Date d = t.getCreatedAt();
      println("Tweet by " + user + " at " + d + ": " + msg);

      //Break the tweet into words
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
        //Put each word into the words ArrayList
        words.add(input[j]);
      }
    };
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  };
}

void draw() {
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  fill(0, 1);
  rect(0, 0, width, height);

  //Draw a word from the list of words that we've built
  int i = (frameCount % words.size());
  String word = words.get(i);

  //Put it somewhere random on the stage, with a random size and colour
  fill(255, random(50, 150));
  textSize(random(10, 30));
  text(word, random(width), random(height));
}

