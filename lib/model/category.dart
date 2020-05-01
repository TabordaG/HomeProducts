
class Category {
  final String name;
  final String numOfCourses;
  final String image;

  Category(this.name, this.numOfCourses, this.image);
}

List<Category> categories = categoriesData
    .map((item) => Category(item['name'], item['courses'], item['image']))
    .toList();

var categoriesData = [
  {"name": "Alface", 'courses': "Gabriel", 'image': "assets/images/alface.png"},
  {"name": "Tomate", 'courses': "Kevin", 'image': "assets/images/tomate.png"},
  {
    "name": "Mamão",
    'courses': "Gustavo",
    'image': "assets/images/mamao.png"
  },
  {"name": "Cenoura", 'courses': "Elmo", 'image': "assets/images/cenoura.png"},
  {"name": "Abacate", 'courses': "Gustavo", 'image': "assets/images/abacate.png"},
  {"name": "Maça", 'courses': "Gabriel", 'image': "assets/images/maca.png"},
  {
    "name": "Mamão",
    'courses': "Kevin",
    'image': "assets/images/mamao.png"
  },
  {"name": "Paçoca", 'courses': "Elmo", 'image': "assets/images/pacoca.png"},
  {"name": "Alface", 'courses': "Gabriel", 'image': "assets/images/alface.png"},
  {"name": "Tomate", 'courses': "Kevin", 'image': "assets/images/tomate.png"},
];
