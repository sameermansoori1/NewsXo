import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsxo/models/article_model.dart';
import 'package:newsxo/models/category_model.dart';
import 'package:newsxo/models/slider_model.dart';
import 'package:newsxo/pages/all_news.dart';
import 'package:newsxo/pages/article_view.dart';
import 'package:newsxo/pages/category_news.dart';
import 'package:newsxo/services/data.dart';
import 'package:newsxo/services/news.dart';
import 'package:newsxo/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true, loading2 = true;
  int activeIndex = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {
      loading2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            Text(
              "Xo",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 70,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                image: categories[index].images,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Breaking News!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllNews(news: "Breaking")));
                              },
                              child: Text(
                                "View All  >",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loading2
                          ? Center(child: CircularProgressIndicator())
                          : CarouselSlider.builder(
                              itemCount: 5,
                              itemBuilder: (context, index, realIndex) {
                                String? res = sliders[index].urlToImage;
                                String? res1 = sliders[index].title;
                                return buildImage(res!, index, res1!);
                              },
                              options: CarouselOptions(
                                  height: 250,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  })),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: buildIndicator(
                        carouselController: _carouselController,
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trending News!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            GestureDetector(onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllNews(news: "Trending")));
                            },
                              child: Text(
                                "View All  >",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: articles.length,
                            itemBuilder: ((context, index) {
                              return BlogTile(
                                  url: articles[index].url!,
                                  desc: articles[index].description!,
                                  imageUrl: articles[index].urlToImage!,
                                  title: articles[index].title!);
                            })),
                      )
                    ]),
              ),
            ),
    );
  }

  Widget buildImage(String images, int index, String name) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              imageUrl: images,
            ),
          ),
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 10.0),
            margin: EdgeInsets.only(top: 170.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      );
  Widget buildIndicator({required CarouselController carouselController}) =>
      AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        onDotClicked: (index) {
          carouselController.animateToPage(index);
        },
        effect: ScaleEffect(
            activeDotColor: Colors.orange, dotWidth: 13, dotHeight: 13),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              height: 60,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 60,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile(
      {required this.desc,
      required this.imageUrl,
      required this.title,
      required this.url,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            color: Colors.white10,
            borderRadius: BorderRadius.circular(10.0),
            shadowColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          desc,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
