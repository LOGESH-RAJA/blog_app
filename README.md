# Blog App

A blogging platform built with Flutter, allowing users to sign up, sign in, and post blogs with a single image per blog. The app follows the **Clean Architecture** pattern, implements **BLoC** state management, and uses **Supabase** for user authentication and data storage.

## Features

- **User Authentication**: Allows users to sign up and sign in using **Supabase Auth**.
- **Blog Posting**: Users can post blogs with a single image per blog. 
- **Image Storage**: Blogs are stored with images using **Supabase Storage**.
- **State Management**: Implemented using **BLoC** for managing app state efficiently.
- **Dependency Injection**: Used **get_it** for managing dependencies.
- **Responsive UI**: Built to work seamlessly across multiple screen sizes.

## Technologies Used

- **Flutter**: Cross-platform mobile development.
- **Dart**: Programming language used for Flutter development.
- **BLoC**: For state management.
- **Clean Architecture**: For separation of concerns and scalable code.
- **Supabase**: For authentication and data storage.
- **get_it**: For dependency injection.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter**: [Flutter installation guide](https://flutter.dev/docs/get-started/install)
- **Dart**: [Dart installation guide](https://dart.dev/get-dart)
- **Supabase Account**: [Sign up for Supabase](https://supabase.io/)

## Installation

Follow these steps to get your local development environment set up:

### 1. Clone the repository

Clone the Blog App repository to your local machine:

```bash
git clone https://github.com/LOGESH-RAJA/blog_app.git
