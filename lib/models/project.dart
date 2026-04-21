class ProjectTag {
  const ProjectTag({required this.name, required this.colorType});
  final String name;
  /// 'blue' | 'green' | 'pink' — maps to gradient colours in AppColors
  final String colorType;
}

class Project {
  const Project({
    required this.name,
    required this.description,
    required this.tags,
    required this.image,
    required this.sourceCodeLink,
  });

  final String name;
  final String description;
  final List<ProjectTag> tags;
  final String image; // asset path
  final String sourceCodeLink;
}
