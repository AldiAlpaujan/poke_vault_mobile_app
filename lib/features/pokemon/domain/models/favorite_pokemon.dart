import 'package:objectbox/objectbox.dart';

@Entity()
class FavoritePokemon {
  @Id()
  int id;

  final int pokemonId;

  FavoritePokemon({this.id = 0, required this.pokemonId});
}
