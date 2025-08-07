# 📺 ott_app

A modern OTT (Over-The-Top) streaming platform built using **Flutter SDK 3.22.2**.

---

## ✅ Prerequisites

Before you get started, make sure you have the following installed:

- **Flutter SDK Version:** `3.22.2`
- **Main Package Used:**
  ```yaml
  video_player: ^2.9.1

A modern OTT (Over-The-Top) streaming platform built using **Flutter SDK 3.22.2**.

## 🚀 Overview

This project demonstrates an OTT application where users can:
- View carousel banners of Batman movies
- Explore the latest movies and series
- Watch HLS videos with advanced playback features
- Search and filter content by year and type using OMDB APIs

---

## 🏠 Home Screen

- Displays a **carousel banner** featuring 5 Batman movies using OMDB APIs.
- Below the banner, dynamically shows **recent and latest movies & series** fetched from the OMDB database.

---

## ℹ️ Video Details Screen

- Fetches and displays **video details** using **IMDb ID or Title** via OMDB API.
- Includes metadata such as title, poster, genre, year, runtime, and more.

---

## 🎬 Video Player Features

- Built using the `video_player: ^2.9.1` Flutter package.
- Supports:
    - Inline video playback
    - Mini preview playback
    - Full-screen mode
    - **Mute/unmute** control
    - **HLS (HTTP Live Streaming) video support** for maintaining video quality
    - **Playback speed control**

---

## 🔍 Search Functionality

- Users can **search for movies/series** by title using the OMDB search API.
- Allows filtering by:
    - **Year**
    - **Type** (movie, series, etc.)
- Displays a responsive list of matched videos.

---

## ⚙️ Getting Started

To run the project on your local machine:

```bash
flutter pub get
flutter run
