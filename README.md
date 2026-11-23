# Fast Food App (iOS, Swift)

An iOS prototype of a food-delivery app: browse a menu, build an order and check out — the kind of
flow you expect from Glovo, Just Eat or Uber Eats, rebuilt as a learning project in Swift.

<!-- TODO: this repo currently contains only a ZIP. Extract it (see SETUP.md) and then:
     1. Add 2-3 screenshots below — it is the fastest way to make this repo credible.
     2. Replace the feature list with what the app actually does. -->

| Menu | Item detail | Cart |
| :---: | :---: | :---: |
| ![Menu](docs/screenshot-menu.png) | ![Item](docs/screenshot-item.png) | ![Cart](docs/screenshot-cart.png) |

## Features

- Menu browsing by category, with prices and item detail
- Cart with quantities and running total
- Order confirmation flow
- <!-- TODO: confirm the rest: search? favourites? order history? mock checkout? -->
- Custom UI built with Auto Layout, no third-party UI framework

## Architecture

<!-- TODO: keep whichever applies, delete the rest -->

- **Pattern:** MVC
- **Persistence:** in-memory / `UserDefaults` / Core Data
- **Networking:** mocked locally, no real backend
- **Screens:** storyboard-based, one `UIViewController` per flow

```
FastFoodApp/
├── Models/          # MenuItem, Order, Cart
├── Views/           # Cells and reusable views
├── Controllers/     # One per screen
└── Resources/       # Assets, fonts, local JSON
```

## Running it

1. Open `FastFoodApp.xcodeproj` in Xcode 12+ (or the version noted below)
2. Select an iPhone simulator
3. `⌘R`

<!-- TODO: state the Xcode / iOS version it was built against, e.g. "Built and tested with Xcode 11 / iOS 13". -->

## Stack

`Swift` · `UIKit` · `Xcode` · `Auto Layout`

## What I learned

- Structuring a multi-screen app around a real user flow instead of isolated demos
- Building a reusable menu/cart model that survives navigation
- Custom table/collection view cells and layout constraints
- Judging when a mock backend is enough to validate the UX

## License

MIT — see [LICENSE](LICENSE).
