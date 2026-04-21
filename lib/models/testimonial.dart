class Testimonial {
  const Testimonial({
    required this.testimonial,
    required this.name,
    required this.designation,
    required this.company,
    required this.image,
  });

  final String testimonial;
  final String name;
  final String designation;
  final String company;
  final String image; // network URL or asset path
}
