import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/screens/article_view.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/category_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories= [];
  List<SliderModel> sliders= [];
  List<ArticleModel> articles = [];

  bool _loading= true;

  int activeIndex = 0;
  @override
  void initState() {
    categories = getCategories();
    getSliders();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass= News();
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
      _loading = false;
    });
  }
  getSliders() async {
    Sliders slider= Sliders();
    await slider.getSlider();
    sliders=slider.sliders;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter', style: TextStyle(fontSize: 30),),
            Text('News', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30),),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading? Center(child: CircularProgressIndicator(color: Colors.black,)) :SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,itemBuilder: (context, index){
                    return CategoryTile(image: categories[index].image, categoryName: categories[index].categoryName,);
                  }
                ),
              ),
              const SizedBox(height: 30.0,),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Breaking News!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),),
                    Text('View All', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 18.0, decoration: TextDecoration.underline),),
                  ],
                )
              ),
              const SizedBox(height: 20.0,),
              CarouselSlider.builder(itemCount: sliders.length, itemBuilder: (context, index, realIndex){
                String? res = sliders[index].urlToImage;
                String? res2 = sliders[index].title;
                return buildImage(res!, index, res2!);
              },options: CarouselOptions(
                  autoPlay: true,
                  height: 250,
                  // viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }
                ),
              ),
              const SizedBox(height: 20.0,),
              Center(child: buildIndicator()),
              const SizedBox(height: 30.0,),
              const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trending News!', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),),
                      Text('View All', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 18.0,  decoration: TextDecoration.underline),),
                    ],
                  )
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,itemBuilder: (context, index){
                      return BlogTile(title: articles[index].title!, desc: articles[index].description!, imageUrl: articles[index].urlToImage!, url: articles[index].url!,);
                    }
                ),
              ),

              SizedBox(height: 10.0,)
            ],
          ),
        ),
      ),
    );
  }
  Widget buildImage(String image, int index, String name) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(imageUrl: image, height: 250,fit: BoxFit.cover, width: MediaQuery.of(context).size.width,)
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.only(left: 10.0),
          margin: const EdgeInsets.only(top: 180.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
          child: Text(maxLines: 2,name, style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
        )
      ],
    ),
  );
  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: sliders.length,
    effect: const ScrollingDotsEffect(dotHeight: 6.0, dotWidth: 6.0, activeDotColor: Colors.blue, activeDotScale: 1.4),
  );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(image, width: 120, height: 70, fit: BoxFit.cover,)),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black38),
            child: Center(child: Text(categoryName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),)),
          )
        ],
      ),
    );
  }
}


class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({required this.title,required this.desc,required this.imageUrl, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
    },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 2.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(imageUrl: imageUrl, height: 150, width: 150, fit: BoxFit.cover,)
                    )
                  ),
                  SizedBox(width: 12.0,),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text(maxLines: 3,title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),)
                      ),
                      SizedBox(height: 7.0,),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text(maxLines: 4, desc, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 17.0),)
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
