import 'package:flutter_test/flutter_test.dart';
import 'package:project0/models/favorites.dart';

import 'utility.dart';

void main() {
  test('favorites provider has 0 items on init', () {
    final container = createContainer();

    expect(
      container.read(favoriteNotifier).numberOfFavorites,
      equals(0),
    );
  });

  test('can add and remove favorites to provider', () {
    final container = createContainer();
    final subscription =
        container.listen(favoriteNotifier, (previous, next) {});

    expect(
      container.read(favoriteNotifier).numberOfFavorites,
      equals(0),
    );

    subscription.read().add("1");
    subscription.read().add("1");
    subscription.read().add("2");
    expect(
      container.read(favoriteNotifier).numberOfFavorites,
      equals(2),
    );

    subscription.read().remove("2");
    subscription.read().remove("3");
    expect(
      container.read(favoriteNotifier).numberOfFavorites,
      equals(1),
    );

    subscription.read().remove("1");
    expect(
      container.read(favoriteNotifier).numberOfFavorites,
      equals(0),
    );
  });
}
