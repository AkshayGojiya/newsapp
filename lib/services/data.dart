import 'package:news_app/models/category_model.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category=[];
  CategoryModel categoryModel= CategoryModel();

  categoryModel.categoryName = 'Business';
  categoryModel.image = 'assets/images/business.png';
  category.add(categoryModel);

  categoryModel=CategoryModel();
  categoryModel.categoryName = 'Entertainment';
  categoryModel.image = 'assets/images/entertainment-2.png';
  category.add(categoryModel);

  categoryModel=CategoryModel();
  categoryModel.categoryName = 'AI';
  categoryModel.image = 'assets/images/03.png';
  category.add(categoryModel);

  categoryModel=CategoryModel();
  categoryModel.categoryName = 'IT';
  categoryModel.image = 'assets/images/business.png';
  category.add(categoryModel);

  categoryModel=CategoryModel();
  categoryModel.categoryName = 'Entertainment';
  categoryModel.image = 'assets/images/entertainment-2.png';
  category.add(categoryModel);

  return category;
}