class ItemDTO {
  final String id;
  final String name;
  final String description;
  final String audioUrl;
  final int number;
  final String type;
  final String mean;
  final bool isFavorite;
  final String user;

  const ItemDTO({
    this.id = '',
    this.name = '',
    this.description = '',
    this.audioUrl = '',
    this.number = 0,
    this.type = '',
    this.mean = '',
    this.isFavorite = false,
    this.user = '',
  });

  factory ItemDTO.empty() => const ItemDTO();

  ItemDTO copyWith(bool isSelected, {String? users}) => ItemDTO(
        id: id,
        name: name,
        description: description,
        audioUrl: audioUrl,
        number: number,
        type: type,
        mean: mean,
        isFavorite: isSelected,
        user: users ?? user,
      );
}
