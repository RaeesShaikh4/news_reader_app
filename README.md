# News Reader App

Flutter app that pulls top headlines from NewsAPI. Built as part of an assignment.

## What it does

- Browse news by category
- Bookmark articles to read later (saved locally)
- Tap an article to see details and open the full link in browser
- Simple login screen that saves your name locally

## Why Provider?

Went with Provider for state management. Honestly it just made sense for this scale — the app uses clean architecture so there's already a clear separation between layers (UseCases → Repositories → DataSources), and Provider slots into that without any fuss. BLoC would've been too much setup for what this app actually does.

## How to run

You'll need a free API key from [newsapi.org](https://newsapi.org/register) before you start.

```bash
git clone https://github.com/RaeesShaikh4/news_reader_app.git
cd news_reader_app
```

Create a `.env` file in the root folder (next to `pubspec.yaml`) and add your key:

```
NEWS_API_KEY=your_key_here
```

There's a `.env.example` file in the repo showing the format. The actual `.env` is gitignored so keys don't leak into the repo.

Then just:

```bash
flutter pub get
flutter run
```

Should work on both Android and iOS.
