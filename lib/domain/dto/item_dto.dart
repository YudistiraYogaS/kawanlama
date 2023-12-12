class ItemDTO {
  final String id;
  final String name;
  final String description;
  final String audioUrl;
  final int number;
  final String type;
  final String mean;
  final bool isFavorite;

  const ItemDTO({
    this.id = '',
    this.name = '',
    this.description = '',
    this.audioUrl = '',
    this.number = 0,
    this.type = '',
    this.mean = '',
    this.isFavorite = false,
  });

  factory ItemDTO.empty() => const ItemDTO();

  ItemDTO copyWith(bool isSelected) => ItemDTO(
    id: id,
    name: name,
    description: description,
    audioUrl: audioUrl,
    number: number,
    type: type,
    mean: mean,
    isFavorite: isSelected,
  );
}
