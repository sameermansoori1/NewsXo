import 'package:newsxo/models/category_model.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category =[];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName="Sports";
  categoryModel.images="assets/images/sport.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  categoryModel.categoryName="Health";
  categoryModel.images="assets/images/health.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  categoryModel.categoryName="General";
  categoryModel.images="assets/images/general.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  categoryModel.categoryName="Entertainment";
  categoryModel.images="assets/images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  categoryModel.categoryName="Business";
  categoryModel.images="assets/images/business.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  categoryModel.categoryName="Building";
  categoryModel.images="assets/images/building.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  categoryModel.categoryName="Science";
  categoryModel.images="assets/images/science.jpg";
  category.add(categoryModel);
  categoryModel= new CategoryModel();

  return category;

}