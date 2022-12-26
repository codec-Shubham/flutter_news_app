class NewsQueryModel
{
   String newsHead;
   String newsDs;
   String newsImg;
   String newsurl;

  NewsQueryModel({this.newsHead = "News Headline" ,
    this.newsDs= "Some News" ,this.newsImg = "Some Image" ,this.newsurl = 'some url'});

  factory NewsQueryModel.fromMap(Map news)
  {
    return NewsQueryModel(
      newsHead: news["title"],
      newsDs:   news["description"],
      newsImg:  news["urlToImage"],
      newsurl: news["url"],
    );
  }
}